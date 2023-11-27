import 'package:flutter_dyscan/flutter_dyscan_platform_interface.dart';
import 'package:flutter_dyscan/src/card_scan_result.dart';
import 'package:flutter_dyscan/src/excpetions.dart';

export 'src/card_scan_result.dart';
export 'src/excpetions.dart' hide DyScanException;

class FlutterDyScan {
  FlutterDyScan._();

  static FlutterDyScan get instance => FlutterDyScan._();

  final FlutterDyScanPlatform _platform = FlutterDyScanPlatform.instance;

  bool _isInitialize = false;

  Future<bool> init(String apiKey) async {
    _isInitialize = await _platform.init(apiKey);
    return _isInitialize;
  }

  Future<CardScanResult> startCardScan() async {
    if (_isInitialize) {
      return _platform.startCardScan();
    } else {
      throw DyScanNotInitialzedException();
    }
  }
}
