import 'package:flutter/services.dart';
import 'package:flutter_dyscan/flutter_dyscan.dart';

import 'flutter_dyscan_platform_interface.dart';

/// An implementation of [FlutterDyScanPlatform] that uses method channels.
class MethodChannelFlutterDyScan extends FlutterDyScanPlatform {
  /// The method channel used to interact with the native platform.
  final MethodChannel _methodChannel =
      const MethodChannel('vvvirani/flutter_dyscan');

  @override
  Future<bool> init(String apiKey) async {
    bool? result = await _methodChannel.invokeMethod<bool?>(
      'init',
      <String, dynamic>{'apiKey': apiKey},
    );
    return result ?? false;
  }

  @override
  Future<CardScanResult> startCardScan() async {
    try {
      return await _methodChannel.invokeMethod('startCardScan').then((result) {
        return CardScanResult.fromMap(Map<String, dynamic>.from(result));
      });
    } on PlatformException catch (e) {
      throw CardScanResultException(code: e.code, message: e.message ?? 'null');
    } catch (e) {
      throw CardScanResultException(code: 'failed', message: e.toString());
    }
  }
}
