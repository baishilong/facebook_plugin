import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'facebook_plugin_method_channel.dart';

abstract class FacebookPluginPlatform extends PlatformInterface {
  /// Constructs a FacebookPluginPlatform.
  FacebookPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FacebookPluginPlatform _instance = MethodChannelFacebookPlugin();

  /// The default instance of [FacebookPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFacebookPlugin].
  static FacebookPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FacebookPluginPlatform] when
  /// they register themselves.
  static set instance(FacebookPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // "iOS " + UIDevice.current.systemVersion
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  
  // 初始化FaceBook param 固定写法key{"clientToken":"xxxx","displayName":"xxxxxx","appID":"xxxxxx","appURLSchemeSuffix":"xxxxxx"}
  Future<String?> initFaceBook(Map param) {
    throw UnimplementedError('initFaceBook() has not been implemented.');
  }

  // 获取设备的uUID
  Future<String?> getIDFV() {
    throw UnimplementedError('getIDFV() has not been implemented.');
  }

  // 是否有VPN
  Future<String?> isVPN() {
    throw UnimplementedError('isVPN() has not been implemented.');
  }

  // 当前设备型号
  Future<String?> deviceModel() {
    throw UnimplementedError('deviceModel() has not been implemented.');
  }

  // 获取广告标识符 (IDFA)
  Future<String?> getIDFA() {
    throw UnimplementedError('getIDFA() has not been implemented.');
  }

  // 获取当前应用程序版本号
  Future<String?> getAppVersion() {
    throw UnimplementedError('getAppVersion() has not been implemented.');
  }

  // UIDevice.current.systemVersion
  Future<String?> systemVersion() {
    throw UnimplementedError('systemVersion() has not been implemented.');
  }

  // 当前手机首选语言
  Future<String?> defaultLanguage() {
    throw UnimplementedError('defaultLanguage() has not been implemented.');
  }

  // 否使用代理
  Future<String?> isProxy() {
    throw UnimplementedError('isProxy() has not been implemented.');
  }

  // 跳转到系统设置
  Future<String?> openAppSettings() {
    throw UnimplementedError('openAppSettings() has not been implemented.');
  }

  // 检查相册权限 -1 被拒绝  1 允许权限
  Future<String?> photoLibraryPermission() {
    throw UnimplementedError('photoLibraryPermission() has not been implemented.');
  }

  // 检查相机权限 -1 被拒绝  1 允许权限
  Future<String?> cameraAuthorizationPermission() {
    throw UnimplementedError('cameraAuthorizationPermission() has not been implemented.');
  }

  // 检查通讯录权限 -1 被拒绝  1 允许权限
  Future<String?> checkContactAuthorization() {
    throw UnimplementedError('checkContactAuthorization() has not been implemented.');
  }

  // 打开系统通讯录 返回null ‘topController.present(contactPicker, animated: true, completion: nil)中topController== nil’  返回{} 用户点击了‘contactPickerDidCancel’代理方法  返会map成功 ‘["fullName" : fullName,"phoneNumber" : phoneNumber]’
  Future<Map?> openSysContactPicker() {
    throw UnimplementedError('openSysContactPicker() has not been implemented.');
  }

  // 获取所有通讯录数据 返回list 如果list为空的 可能是通讯录没数据
  Future<List?> getAllContacts() {
    throw UnimplementedError('getAllContacts() has not been implemented.');
  }

  // 检查定位权限 -1 被拒绝  1 允许权限
  Future<String?> checkLocationAuthorization() {
    throw UnimplementedError('checkLocationAuthorization() has not been implemented.');
  }

  // 获取当前的地址信息
  Future<Map?> currentLocation() {
    throw UnimplementedError('currentLocation() has not been implemented.');
  }

  // 获取当前的经纬度
  Future<Map?> getlatitudeAndlongitude() {
    throw UnimplementedError('getlatitudeAndlongitude() has not been implemented.');
  }

  // appstore 评分
  Future<String?> requestAppStoreReview() {
    throw UnimplementedError('requestAppStoreReview() has not been implemented.');
  }

  // 拨打电话 固定写法key {"phoneNumber":phoneNumber}
  Future<String?> callPhone(String phoneNumber) {
    throw UnimplementedError('callPhone() has not been implemented.');
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
            "deviceIdentifierNumber":"设备型号，例如 iPhone11,8、iPad Pro 12.9",
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
    throw UnimplementedError('getiPhoneInfo() has not been implemented.');
  }

}
