
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

}
