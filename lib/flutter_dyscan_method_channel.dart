import 'package:flutter/services.dart';
import 'package:flutter_dyscan/flutter_dyscan.dart';

import 'flutter_dyscan_platform_interface.dart';

/// An implementation of [FlutterDyScanPlatform] that uses method channels.
class MethodChannelFlutterDyScan extends FlutterDyScanPlatform {
  /// The method channel used to interact with the native platform.
  final MethodChannel _methodChannel =
      const MethodChannel('vvvirani/flutter_dyscan');

  @override
  Future<void> init(String apiKey) async {
    try {
      return await _methodChannel.invokeMethod(
        'init',
        <String, dynamic>{'apiKey': apiKey},
      );
    } on PlatformException catch (e) {
      throw DyScanException.fromPlatformException(e);
    }
  }

  @override
  Future<CardScanResult> startCardScan({DyScanUiSettings? uiSettings}) async {
    try {
      uiSettings = uiSettings ?? DyScanUiSettings.defaultUiSettings;

      Map<String, dynamic> arguments = uiSettings.asMap();

      return await _methodChannel
          .invokeMethod('startCardScan', arguments)
          .then((result) {
        return CardScanResult.fromMap(Map<String, dynamic>.from(result));
      });
    } on PlatformException catch (e) {
      throw DyScanException.fromPlatformException(e);
    }
  }
}
