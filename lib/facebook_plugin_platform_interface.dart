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

}
