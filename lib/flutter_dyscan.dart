import 'package:flutter_dyscan/flutter_dyscan_platform_interface.dart';
import 'package:flutter_dyscan/src/exceptions/excpetions.dart';
import 'package:flutter_dyscan/src/models/models.dart';

export 'src/models/models.dart';
export 'src/exceptions/excpetions.dart' hide DyScanException;

class FlutterDyScan {
  FlutterDyScan._();

  static FlutterDyScan get instance => FlutterDyScan._();

  final FlutterDyScanPlatform _platform = FlutterDyScanPlatform.instance;

  bool _isInitialize = false;

  Future<bool> init(String apiKey) async {
    _isInitialize = await _platform.init(apiKey);
    return _isInitialize;
  }

  Future<CardScanResult> startCardScan({DyScanUiSettings? uiSettings}) async {
    if (_isInitialize) {
      return _platform.startCardScan(uiSettings: uiSettings);
    } else {
      throw DyScanNotInitialzedException();
    }
  }
}
