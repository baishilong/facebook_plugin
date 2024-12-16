import Flutter
import UIKit
import FBSDKCoreKit
import AppTrackingTransparency
import AdSupport
import Photos
import AVFoundation
import Contacts
import ContactsUI
import CoreLocation

public class FacebookPlugin: NSObject, FlutterPlugin, CNContactPickerDelegate, CLLocationManagerDelegate {
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "facebook_plugin", binaryMessenger: registrar.messenger())
    let instance = FacebookPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    var myContactResult: FlutterResult?
    var locationContactResult: FlutterResult?
    var currentLocationResult: FlutterResult?
    var latitudeAndlongitude: FlutterResult?

    
    private let locationManager = CLLocationManager()
    private var latitude:String = ""
    private var longitude:String = ""
    private var currentLocation: CLLocation?

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "initFaceBook":
        if let  param = call.arguments as? [String : Any] {
            Settings.shared.clientToken = param["clientToken"] as? String ?? ""
            Settings.shared.displayName = param["displayName"] as? String ?? ""
            Settings.shared.appID = param["appID"] as? String ?? ""
            Settings.shared.appURLSchemeSuffix = param["appURLSchemeSuffix"] as? String ?? ""
            ApplicationDelegate.shared.initializeSDK()
            result("1");
        } else {
            result("0");
        }
    case "getIDFV":
        result(fetchIDFV());
    case "isVPN":
        result(isVPN() ? "1" : "0");
    case "deviceModel":
        result(deviceModel());
    case "getIDFA":
        getIDFA(result: result);
    case "getAppVersion":
        result(getAppVersion());
    case "systemVersion":
        result(UIDevice.current.systemVersion);
    case "defaultLanguage":
        result(Locale.preferredLanguages.first ?? "en");
    case "isProxy":
        result(isProxyFunction() ? "1" : "0");
    case "openAppSettings":
        openAppSettings(result: result)
    case "photoLibraryPermission":
        checkPhotoLibraryPermission(result: result)
    case "cameraAuthorizationPermission":
        checkCameraAuthorization(result: result)
    case "checkContactAuthorization":
        checkContactAuthorization(result: result)
    case "openSysContactPicker":
        openSysContactPicker(result: result)
    case "getAllContacts":
        getAllContacts(result: result)
    case "checkLocationAuthorization":
        checkLocationAuthorization(result: result)
    case "currentLocation":
        currentLocation(result: result)
    case "getlatitudeAndlongitude":
        getlatitudeAndlongitude(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
   
    func getlatitudeAndlongitude(result: @escaping FlutterResult) {
        latitudeAndlongitude = result
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func currentLocation(result: @escaping FlutterResult) -> Void {
        currentLocationResult = result;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    // 检查授权状态（兼容 iOS 12）
    private func checkLocationAuthorization(result: @escaping FlutterResult) {
        locationContactResult = result
        if #available(iOS 14.0, *) {
            // iOS 14 及以上版本，使用实例属性
            handleAuthorizationStatus(locationManager.authorizationStatus,result: result)
        } else {
            // iOS 13 和 iOS 12，使用静态方法
            handleAuthorizationStatus(CLLocationManager.authorizationStatus(),result: result)
        }
    }
    
    private func handleAuthorizationStatus(_ status: CLAuthorizationStatus,result: @escaping FlutterResult) {
        switch status {
        case .notDetermined:
            // 请求用户授权
            startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            result("-1")
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdatingLocation()
            result("1")
        @unknown default:
            fatalError("Unhandled case for location authorization status.")
        }
    }
    
    
    // 开始获取位置
    private func startUpdatingLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    // CLLocationManagerDelegate 方法
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            if let block = latitudeAndlongitude {
                var dict = Dictionary<String,Any>()
                dict["latitude"] = self.latitude;
                dict["longitude"] = self.longitude;
                block(dict)
                latitudeAndlongitude = nil
            }
            return
        }
        currentLocation = location
        self.latitude = String(format: "%.6f", location.coordinate.latitude)
        self.longitude = String(format: "%.6f", location.coordinate.longitude)
        if let block = latitudeAndlongitude {
            var dict = Dictionary<String,Any>()
            dict["latitude"] = self.latitude;
            dict["longitude"] = self.longitude;
            block(dict)
            latitudeAndlongitude = nil
        }
        
        print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
        fetchGeocodingData(location: location)

    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if #available(iOS 14.0, *) {
            handleAuthorizationStatus(status,result: locationContactResult!)
        } else {
            // iOS 12 和 13 不调用此方法，故无需处理
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    
 
    // 获取地理位置信息
    private func fetchGeocodingData(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [self] placemarks, error in
            if let error = error as NSError? {
                switch error.code {
                case CLError.network.rawValue:
                    print("Network error: Check your connection.")
                case CLError.geocodeFoundNoResult.rawValue:
                    print("No result found for the location.")
                case CLError.geocodeCanceled.rawValue:
                    print("Geocoding request was canceled.")
                default:
                    print("Failed to reverse geocode location: \(error.localizedDescription)")
                }
                if let block = currentLocationResult {
                    var dict = Dictionary<String,Any>()
                    dict["country"] = ""
                    dict["code"] = ""
                    dict["province"] = ""
                    dict["city"] = ""
                    dict["district"] = ""
                    dict["street"] = ""
                    dict["latitude"] = self.latitude;
                    dict["longitude"] = self.longitude;
                    block(dict)
                    currentLocationResult = nil
                }
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemark found.")
                if let block = currentLocationResult {
                    var dict = Dictionary<String,Any>()
                    dict["country"] = ""
                    dict["code"] = ""
                    dict["province"] = ""
                    dict["city"] = ""
                    dict["district"] = ""
                    dict["street"] = ""
                    dict["latitude"] = self.latitude;
                    dict["longitude"] = self.longitude;
                    block(dict)
                    currentLocationResult = nil
                }

                return
            }
            
            // 打印地理信息
             let country = placemark.country ?? ""
                print("Country: \(country)")
            
             let  isoCountryCode = placemark.isoCountryCode ?? ""
                print("Country Code: \(isoCountryCode)")
            
             let administrativeArea = placemark.administrativeArea ?? ""
                print("Province/State: \(administrativeArea)")
            
             let locality = placemark.locality ?? ""
                print("City: \(locality)")
            
             let subLocality = placemark.subLocality ?? ""
                print("Sub-locality/District: \(subLocality)")
            
             let thoroughfare = placemark.thoroughfare ?? ""
                print("Street: \(thoroughfare)")
            
             let postalCode = placemark.postalCode ?? ""
                print("Postal Code: \(postalCode)")
            
            if let block = currentLocationResult {
                var dict = Dictionary<String,Any>()
                dict["country"] = country
                dict["code"] = isoCountryCode
                dict["province"] = administrativeArea
                dict["city"] = locality
                dict["district"] = subLocality
                dict["street"] = thoroughfare
                dict["latitude"] = self.latitude;
                dict["longitude"] = self.longitude;
                block(dict)
                currentLocationResult = nil
            }
        }
    }
    
    
    func getAllContacts(result: @escaping FlutterResult) {
       
        var contactArray = [[String: Any]]()
        let store = CNContactStore()
            
            // 定义要获取的联系人信息
            let keysToFetch: [CNKeyDescriptor] = [CNContactGivenNameKey as CNKeyDescriptor,
                                                  CNContactFamilyNameKey as CNKeyDescriptor,
                                                  CNContactPhoneNumbersKey as CNKeyDescriptor]
            let request = CNContactFetchRequest(keysToFetch: keysToFetch)
            DispatchQueue.global(qos: .background).async {
                
                do {
                    try store.enumerateContacts(with: request) { contact, _ in
                        let fullName = "\(contact.givenName) \(contact.familyName)"
                        
                        // 获取每个联系人的电话号码
                        contact.phoneNumbers.forEach { phoneNumber in
                            let number = phoneNumber.value.stringValue
                            var contactInfo: [String: Any] = [
                                "phone": number,          // 电话号码
                                "uptime": "",       // 更新时间
                                "remark": "",            // 备注
                                "birthday": "",        // 生日
                                "email": "",          // 邮箱
                                "creattime": "",         // 创建时间
                                "name": fullName      // 名字
                            ]
                            //                    print("姓名：\(fullName)，电话号码：\(number)")
                            contactArray.append(contactInfo)
                            
                        }
                        
                   
                    }
                    
                    DispatchQueue.main.async {
                        result(contactArray)
                    }
                } catch {
                    
                    print("获取通讯录失败：\(error.localizedDescription)")
                }
            }
        
    }

    
    
    public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        
        if ((myContactResult) != nil) {
            myContactResult!([:])
        }
    }
    
    
    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        // 获取姓名
        let fullName = "\(contact.givenName) \(contact.familyName)"
        
        // 获取电话号码（选择第一个可用的号码）
         let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
        
        if ((myContactResult) != nil) {
            var param = ["fullName" : fullName,"phoneNumber" : phoneNumber]
            myContactResult!(param)
        }
        
    }
    
    
    func openSysContactPicker(result: @escaping FlutterResult) {
        myContactResult = result
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }),
               let rootViewController = keyWindow.rootViewController {
                // 获取最顶层的视图控制器
                var topController = rootViewController
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(contactPicker, animated: true, completion: nil)
                return
            }
        } else {
            // 获取当前视图控制器
            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                var topController = rootViewController
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                // 从当前最顶部的视图控制器呈现
                topController.present(contactPicker, animated: true, completion: nil)
                return
            }

            // Fallback on earlier versions
        }
        
        if ((myContactResult) != nil) {
            myContactResult!([:])
        }
    }
    
    
    func checkContactAuthorization(result: @escaping FlutterResult) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        
        switch authorizationStatus {
        case .authorized:
            DispatchQueue.main.async {
                result("1")
            }
        case .denied, .restricted, .limited:
            DispatchQueue.main.async {
                result("-1")
            }
        case .notDetermined:
            let store = CNContactStore()
            store.requestAccess(for: .contacts) { granted, error in
                DispatchQueue.main.async {
                    if granted {
                        result("1")
                    } else {
                        result("-1")
                    }
                }
            }
            
        @unknown default:
            DispatchQueue.main.async {
                // Handle other unknown cases
            }
        }
    }
    
    
    func checkCameraAuthorization(result: @escaping FlutterResult) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .notDetermined:
            // 请求相机权限
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        result("1")
                    } else {
                        result("-1")

                    }
                }
            }
        case .restricted, .denied:
            // 相机权限被拒绝或受限
            DispatchQueue.main.async {
                result("-1")
            }
        case .authorized:
            // 相机权限已授权
            DispatchQueue.main.async {
                result("1")
            }
        default:
            break
        }
    }
    

    func checkPhotoLibraryPermission(result: @escaping FlutterResult) {
        var status = PHPhotoLibrary.authorizationStatus()
        
        if #available(iOS 14, *) {
            // For iOS 14 and later, use the newer method with access level.
            status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        }
        
        switch status {
        case .authorized, .limited:
            DispatchQueue.main.async {
                result("1")
            }
        case .denied, .restricted:
            DispatchQueue.main.async {
                result("-1")
                // Handle case when access is denied or restricted
            }
        case .notDetermined:
            if #available(iOS 14, *) {
                // For iOS 14 and later, use the requestAuthorizationForAccessLevel method
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
                    DispatchQueue.main.async {
                        if newStatus == .authorized || newStatus == .limited {
                            result("1")
                        } else {
                            result("-1")
                            // Handle the case where authorization was not granted
                        }
                    }
                }
            } else {
                // For iOS 12 and earlier, use the old method
                PHPhotoLibrary.requestAuthorization { newStatus in
                    DispatchQueue.main.async {
                        if newStatus == .authorized {
                            result("1")
                        } else {
                            result("-1")
                        }
                    }
                }
            }
        default:
            break
        }
    }
    
    
    func openAppSettings(result: @escaping FlutterResult) {
        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                result("1")
            } else {
                result("0")
            }
        } else {
            result("0")
        }
    }

    
    // 是否使用代理 0、1
     func isProxyFunction() -> Bool {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any] else {
            return false
        }
        
        guard let httpEnable = proxySettings[kCFNetworkProxiesHTTPEnable as String] as? NSNumber else {
            return false
        }
        
        // If HTTP or HTTPS proxy is enabled, and the proxy port is not empty, the device has a proxy set
        return httpEnable.boolValue
    }
    
    
    /// 获取当前应用程序版本号
    /// - Returns: 应用程序版本号字符串
    func getAppVersion() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            print("应用程序版本号: \(version)")
            return version
        } else {
            print("无法获取应用程序版本号。")
        }
        return ""
    }
    
    /// 获取广告标识符 (IDFA)
    /// - Returns: IDFA字符串
    func getIDFA(result: @escaping FlutterResult) {
        var idfa = ""
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { trackingAuthorizationStatus in
                switch trackingAuthorizationStatus {
                case .authorized:
                    print("用户已授权跟踪 IDFA")
                    idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                    result(idfa)
                case .denied:
                    print("用户已拒绝跟踪 IDFA")
                    result("")
                case .notDetermined:
                    print("用户尚未决定是否跟踪 IDFA")
                    result("")
                case .restricted:
                    print("应用无法请求跟踪 IDFA 授权")
                    result("")
                @unknown default:
                    print("未知状态")
                    result("")
                }
            }
            
        } else {
            idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            result("")
        }
        
    }
    
    
    /// 获取当前设备型号
    /// - Returns: 设备型号字符串
    func deviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let deviceString = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch deviceString {
        case "i386": return "Simulator"
        case "x86_64": return "Simulator"
        case "iPhone1,1": return "iPhone 1G"
        case "iPhone1,2": return "iPhone 3G"
        case "iPhone2,1": return "iPhone 3GS"
        case "iPhone3,1", "iPhone3,2": return "iPhone 4"
        case "iPhone4,1": return "iPhone 4S"
        case "iPhone5,1", "iPhone5,2": return "iPhone 5"
        case "iPhone5,3", "iPhone5,4": return "iPhone 5C"
        case "iPhone6,1", "iPhone6,2": return "iPhone 5S"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone8,1": return "iPhone 6s"
        case "iPhone8,2": return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3": return "iPhone 7"
        case "iPhone9,2", "iPhone9,4": return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"
        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,4", "iPhone11,6": return "iPhone XS Max"
        case "iPhone11,8": return "iPhone XR"
        case "iPhone12,1": return "iPhone 11"
        case "iPhone12,3": return "iPhone 11 Pro"
        case "iPhone12,5": return "iPhone 11 Pro Max"
        case "iPhone12,8": return "iPhone SE (2nd generation)"
        case "iPhone13,1": return "iPhone 12 mini"
        case "iPhone13,2": return "iPhone 12"
        case "iPhone13,3": return "iPhone 12 Pro"
        case "iPhone13,4": return "iPhone 12 Pro Max"
        case "iPhone14,4": return "iPhone 13 mini"
        case "iPhone14,5": return "iPhone 13"
        case "iPhone14,2": return "iPhone 13 Pro"
        case "iPhone14,3": return "iPhone 13 Pro Max"
        case "iPhone14,6": return "iPhone SE (3rd generation)"
        case "iPhone14,7": return "iPhone 14"
        case "iPhone14,8": return "iPhone 14 Plus"
        case "iPhone15,2": return "iPhone 14 Pro"
        case "iPhone15,3": return "iPhone 14 Pro Max"
            
        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1": return "iPad 2 (WiFi)"
        case "iPad2,2": return "iPad 2"
        case "iPad2,3": return "iPad 2 (CDMA)"
        case "iPad2,4": return "iPad 2"
        case "iPad2,5": return "iPad Mini (WiFi)"
        case "iPad2,6": return "iPad Mini"
        case "iPad2,7": return "iPad Mini (GSM+CDMA)"
        case "iPad3,1": return "iPad 3 (WiFi)"
        case "iPad3,2": return "iPad 3 (GSM+CDMA)"
        case "iPad3,3": return "iPad 3"
        case "iPad3,4": return "iPad 4 (WiFi)"
        case "iPad3,5": return "iPad 4"
        case "iPad3,6": return "iPad 4 (GSM+CDMA)"
        case "iPad4,1": return "iPad Air (WiFi)"
        case "iPad4,2": return "iPad Air (Cellular)"
        case "iPad4,4": return "iPad Mini 2 (WiFi)"
        case "iPad4,5": return "iPad Mini 2 (Cellular)"
        case "iPad4,6": return "iPad Mini 2"
        case "iPad4,7": return "iPad Mini 3"
        case "iPad4,8", "iPad4,9": return "iPad Mini 3"
        case "iPad5,1": return "iPad Mini 4 (WiFi)"
        case "iPad5,2": return "iPad Mini 4 (LTE)"
        case "iPad5,3", "iPad5,4": return "iPad Air 2"
        case "iPad6,3", "iPad6,4": return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8": return "iPad Pro 12.9"
            
        default: return deviceString
        }
    }
    

    /// 检查是否有VPN连接
    func isVPN() -> Bool {

        guard let cfDict = CFNetworkCopySystemProxySettings() else {
            return false
        }
        
        let nsDict = cfDict.takeRetainedValue() as NSDictionary
        
        guard let keys = nsDict["__SCOPED__"] as? [String: Any] else {
            return false
        }
        
        let keyValues: [String] = [
            "tap",
            "tun",
            "ppp",
            "ipsec",
            "ipsec0",
        ]
        
        var result: Bool = false
        for key in keys.keys {
            keyValues.forEach { (value) in
                if key.contains(value) {
                    result = true
                }
            }
        }
        
        return result
    }
    
    
    /// 获取设备的UUID
    /// - Returns: UUID字符串
    func fetchIDFV() -> String? {
        var uuidString = getPassword(service: "", account: "face")
        if uuidString == nil {
            uuidString = UIDevice.current.identifierForVendor?.uuidString
            savePassword(service: "", account: "face", password: uuidString!)
        }
        return uuidString
    }
    
    
    /// Saves a password to the Keychain
    /// - Parameters:
    ///   - service: A string representing the service for which the password is stored
    ///   - account: A string representing the account for which the password is stored
    ///   - password: The password to be stored
    func savePassword(service: String, account: String, password: String) {
        if let passwordData = password.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account,
                kSecValueData as String: passwordData
            ]
            
            // Delete any existing item with the same service and account
            SecItemDelete(query as CFDictionary)
            
            // Add the new item to the Keychain
            SecItemAdd(query as CFDictionary, nil)
        }
    }
    
    
    /// Retrieves a password from the Keychain
    /// - Parameters:
    ///   - service: A string representing the service for which the password is stored
    ///   - account: A string representing the account for which the password is stored
    /// - Returns: The password as a string if found, otherwise `nil`
    func getPassword(service: String, account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let retrievedData = dataTypeRef as? Data {
            return String(data: retrievedData, encoding: .utf8)
        } else {
            return nil
        }
    }
}
