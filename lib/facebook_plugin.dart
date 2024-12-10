
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

  // 初始化IQKeyboardManager
  Future<String?> initKeyboardManager() {
    return FacebookPluginPlatform.instance.initKeyboardManager();
  }

}
