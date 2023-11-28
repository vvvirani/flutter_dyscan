import 'package:flutter_dyscan/flutter_dyscan_platform_interface.dart';
import 'package:flutter_dyscan/src/models/models.dart';

export 'src/models/models.dart';
export 'src/exceptions/excpetions.dart' hide DyScanException;

class FlutterDyScan {
  FlutterDyScan._();

  static FlutterDyScan get instance => FlutterDyScan._();

  final FlutterDyScanPlatform _platform = FlutterDyScanPlatform.instance;

  Future<void> init(String apiKey) {
    return _platform.init(apiKey);
  }

  Future<CardScanResult> startCardScan({DyScanUiSettings? uiSettings}) async {
    return _platform.startCardScan(uiSettings: uiSettings);
  }
}
