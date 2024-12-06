
import 'facebook_plugin_platform_interface.dart';

class FacebookPlugin {

  // 初始化
  Future<String?> initFaceBook(Map param) {
    return FacebookPluginPlatform.instance.initFaceBook(param);
  }

  Future<String?> getPlatformVersion() {
    return FacebookPluginPlatform.instance.getPlatformVersion();
  }

  // 获取设备的uUID
  Future<String?> getIDFV() {
    return FacebookPluginPlatform.instance.getIDFV();
  }

  Future<String?> isVPN() {
    return FacebookPluginPlatform.instance.isVPN();
  }

  Future<String?> deviceModel() {
    return FacebookPluginPlatform.instance.deviceModel();
  }

  Future<String?> getIDFA() {
    return FacebookPluginPlatform.instance.getIDFA();
  }

  Future<String?> getAppVersion() {
    return FacebookPluginPlatform.instance.getAppVersion();
  }

  Future<String?> systemVersion() {
    return FacebookPluginPlatform.instance.systemVersion();
  }

  Future<String?> defaultLanguage() {
    return FacebookPluginPlatform.instance.defaultLanguage();
  }

  Future<String?> isProxy() {
    return FacebookPluginPlatform.instance.isProxy();
  }

}
