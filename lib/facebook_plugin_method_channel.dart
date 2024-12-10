import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'facebook_plugin_platform_interface.dart';

/// An implementation of [FacebookPluginPlatform] that uses method channels.
class MethodChannelFacebookPlugin extends FacebookPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('facebook_plugin');

  @override
  // "iOS " + UIDevice.current.systemVersion
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  // 初始化FaceBook param 固定写法key{"clientToken":"xxxx","displayName":"xxxxxx","appID":"xxxxxx","appURLSchemeSuffix":"xxxxxx"}
  Future<String?> initFaceBook(Map param) async {
    final result = await methodChannel.invokeMethod<String>('initFaceBook',param);
    return result;
  }

  // 获取设备的uUID
  Future<String?> getIDFV() async {
    final result = await methodChannel.invokeMethod<String>('getIDFV');
    return result;
  }

  // 是否有VPN
  Future<String?> isVPN() async {
    final result = await methodChannel.invokeMethod<String>('isVPN');
    return result;
  }

  // 当前设备型号
  Future<String?> deviceModel() async {
    final result = await methodChannel.invokeMethod<String>('deviceModel');
    return result;
  }

  // 获取广告标识符 (IDFA)
  Future<String?> getIDFA() async {
    final result = await methodChannel.invokeMethod<String>('getIDFA');
    return result;
  }

  // 获取当前应用程序版本号
  Future<String?> getAppVersion() async {
    final result = await methodChannel.invokeMethod<String>('getAppVersion');
    return result;
  }

  // UIDevice.current.systemVersion
  Future<String?> systemVersion() async {
    final result = await methodChannel.invokeMethod<String>('systemVersion');
    return result;
  }

  // 当前手机首选语言
  Future<String?> defaultLanguage() async {
    final result = await methodChannel.invokeMethod<String>('defaultLanguage');
    return result;
  }

  // 否使用代理
  Future<String?> isProxy() async {
    final result = await methodChannel.invokeMethod<String>('isProxy');
    return result;
  }

  // 跳转到系统设置
  Future<String?> openAppSettings() async {
    final result = await methodChannel.invokeMethod<String>('openAppSettings');
    return result;
  }

}
