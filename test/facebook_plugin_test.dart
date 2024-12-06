import 'package:flutter_test/flutter_test.dart';
import 'package:facebook_plugin/facebook_plugin.dart';
import 'package:facebook_plugin/facebook_plugin_platform_interface.dart';
import 'package:facebook_plugin/facebook_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFacebookPluginPlatform
    with MockPlatformInterfaceMixin
    implements FacebookPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FacebookPluginPlatform initialPlatform = FacebookPluginPlatform.instance;

  test('$MethodChannelFacebookPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFacebookPlugin>());
  });

  test('getPlatformVersion', () async {
    FacebookPlugin facebookPlugin = FacebookPlugin();
    MockFacebookPluginPlatform fakePlatform = MockFacebookPluginPlatform();
    FacebookPluginPlatform.instance = fakePlatform;

    expect(await facebookPlugin.getPlatformVersion(), '42');
  });
}
