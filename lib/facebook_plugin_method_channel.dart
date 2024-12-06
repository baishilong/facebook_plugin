import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'facebook_plugin_platform_interface.dart';

/// An implementation of [FacebookPluginPlatform] that uses method channels.
class MethodChannelFacebookPlugin extends FacebookPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('facebook_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  Future<String?> initFaceBook(Map param) async {
    final result = await methodChannel.invokeMethod<String>('initFaceBook',param);
    return result;
  }

  Future<String?> getIDFV() async {
    final result = await methodChannel.invokeMethod<String>('getIDFV');
    return result;
  }

  Future<String?> isVPN() async {
    final result = await methodChannel.invokeMethod<String>('isVPN');
    return result;
  }

  Future<String?> deviceModel() async {
    final result = await methodChannel.invokeMethod<String>('deviceModel');
    return result;
  }

  Future<String?> getIDFA() async {
    final result = await methodChannel.invokeMethod<String>('getIDFA');
    return result;
  }

  Future<String?> getAppVersion() async {
    final result = await methodChannel.invokeMethod<String>('getAppVersion');
    return result;
  }

  Future<String?> systemVersion() async {
    final result = await methodChannel.invokeMethod<String>('systemVersion');
    return result;
  }

  Future<String?> defaultLanguage() async {
    final result = await methodChannel.invokeMethod<String>('defaultLanguage');
    return result;
  }

  Future<String?> isProxy() async {
    final result = await methodChannel.invokeMethod<String>('isProxy');
    return result;
  }

}
