import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:facebook_plugin/facebook_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _facebookPlugin = FacebookPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    contact();
  }

  void contact() async{
  //String? rulst  = await  _facebookPlugin.checkContactAuthorization();
  //if (rulst == "1") {
    print("checkLocationAuthorizationcheckLocationAuthorization");

    String? ad = await _facebookPlugin.checkLocationAuthorization();
      print((ad ?? ""));

if (ad == "1") {
  Map? map1 = await _facebookPlugin.getiPhoneInfo();
  print((map1 ?? {}));

}



  //}



  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _facebookPlugin.getIDFA() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
