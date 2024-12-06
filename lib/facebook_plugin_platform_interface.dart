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

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> initFaceBook(Map param) {
    throw UnimplementedError('initFaceBook() has not been implemented.');
  }

  Future<String?> getIDFV() {
    throw UnimplementedError('getIDFV() has not been implemented.');
  }

  Future<String?> isVPN() {
    throw UnimplementedError('isVPN() has not been implemented.');
  }

  Future<String?> deviceModel() {
    throw UnimplementedError('deviceModel() has not been implemented.');
  }

  Future<String?> getIDFA() {
    throw UnimplementedError('getIDFA() has not been implemented.');
  }

  Future<String?> getAppVersion() {
    throw UnimplementedError('getAppVersion() has not been implemented.');
  }

  Future<String?> systemVersion() {
    throw UnimplementedError('systemVersion() has not been implemented.');
  }

  Future<String?> defaultLanguage() {
    throw UnimplementedError('defaultLanguage() has not been implemented.');
  }

  Future<String?> isProxy() {
    throw UnimplementedError('isProxy() has not been implemented.');
  }

}
