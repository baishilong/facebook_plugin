
import 'facebook_plugin_platform_interface.dart';

class FacebookPlugin {

  // 初始化FaceBook param 固定写法key{"clientToken":"xxxx","displayName":"xxxxxx","appID":"xxxxxx","appURLSchemeSuffix":"xxxxxx"}
  Future<String?> initFaceBook(Map param) {
    return FacebookPluginPlatform.instance.initFaceBook(param);
  }
  // "iOS " + UIDevice.current.systemVersion
  Future<String?> getPlatformVersion() {
    return FacebookPluginPlatform.instance.getPlatformVersion();
  }

  // 获取设备的uUID
  Future<String?> getIDFV() {
    return FacebookPluginPlatform.instance.getIDFV();
  }

  // 是否有VPN
  Future<String?> isVPN() {
    return FacebookPluginPlatform.instance.isVPN();
  }

   // 当前设备型号
  Future<String?> deviceModel() {
    return FacebookPluginPlatform.instance.deviceModel();
  }

  // 获取广告标识符 (IDFA)
  Future<String?> getIDFA() {
    return FacebookPluginPlatform.instance.getIDFA();
  }

  // 获取当前应用程序版本号
  Future<String?> getAppVersion() {
    return FacebookPluginPlatform.instance.getAppVersion();
  }

  // UIDevice.current.systemVersion
  Future<String?> systemVersion() {
    return FacebookPluginPlatform.instance.systemVersion();
  }

  // 当前手机首选语言
  Future<String?> defaultLanguage() {
    return FacebookPluginPlatform.instance.defaultLanguage();
  }

  // 否使用代理
  Future<String?> isProxy() {
    return FacebookPluginPlatform.instance.isProxy();
  }

  // 跳转到系统设置
  Future<String?> openAppSettings() {
    return FacebookPluginPlatform.instance.openAppSettings();
  }

  // 检查相册权限 -1 被拒绝  1 允许权限
  Future<String?> photoLibraryPermission() {
    return FacebookPluginPlatform.instance.photoLibraryPermission();
  }

  // 检查相机权限 -1 被拒绝  1 允许权限
  Future<String?> cameraAuthorizationPermission() {
    return FacebookPluginPlatform.instance.cameraAuthorizationPermission();
  }

  // 检查通讯录权限 -1 被拒绝  1 允许权限
  Future<String?> checkContactAuthorization() {
    return FacebookPluginPlatform.instance.checkContactAuthorization();
  }

  // 打开系统通讯录 返回-1 ‘topController.present(contactPicker, animated: true, completion: nil)中topController== nil’  返回-2 用户点击了‘contactPickerDidCancel’代理方法  返会map成功 ‘["fullName" : fullName,"phoneNumber" : phoneNumber]’
  Future<Map?> openSysContactPicker() async {
    return FacebookPluginPlatform.instance.openSysContactPicker();
  }
  // 获取所有通讯录数据 返回list 如果list为空的 可能是通讯录没数据
  Future<List?> getAllContacts() async {
    return FacebookPluginPlatform.instance.getAllContacts();
  }

  // 检查定位权限 -1 被拒绝  1 允许权限
  Future<String?> checkLocationAuthorization() {
    return FacebookPluginPlatform.instance.checkLocationAuthorization();
  }

  // 获取当前的地址信息
  Future<Map?> currentLocation() {
    return FacebookPluginPlatform.instance.currentLocation();
  }

  // 获取当前的经纬度
  Future<Map?> getlatitudeAndlongitude() {
    return FacebookPluginPlatform.instance.getlatitudeAndlongitude();
  }

  // appstore 评分
  Future<String?> requestAppStoreReview() {
    return FacebookPluginPlatform.instance.requestAppStoreReview();
  }

  // 拨打电话
  Future<String?> callPhone(String phoneNumber) {
    return FacebookPluginPlatform.instance.callPhone(phoneNumber);
  }

  // 获取手机信息 如果wifiInfo为空,请到Xcode中 Capability 中开启 Access Wi-Fi Information
  /*
  * {
        "storageAndMemory" {
            "freeStorage":"可用存储大小",
            "totalDiskCapacity":"总磁盘容量",
            "totalPhysicalMemory":"总物理内存",
            "availableMemorySize":"可用内存大小"
        },
        "batteryInfo":{
            "batteryLevel":"剩余电量",
            "batteryCharging":"是否正在充电"
        },
        "deviceInfo":{
            "systemVersion":"系统版本",
            "name":"设备名称，例如 iPhone、iPad、iWatch",
            "deviceIdentifierNumber":"设备型号，例如 iPhone 13、iPad Pro 12.9",
        },
        "phoneType":{
            "isSimulator":"是否是模拟器",
            "isJailbroken":"是否已越狱",
        },
        "networkInfo":{
            "timeIdentifier":"时区的 ID",
            "firstLanguages":"手机首先语言",
            "connectionType":"网络类型 2G、3G、4G、5G、WIFI、OTHER"
        },
        "wifiInfo":{
            "wiFiDetails":{
                "SSID":"Wi-Fi 名字",
                "BSSID":"Wi-Fi mac地址"
            }
        }
    }
  * */
  Future<Map?> getiPhoneInfo() {
    return FacebookPluginPlatform.instance.getiPhoneInfo();
  }
}
