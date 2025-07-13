import 'package:flutter_dyscan/flutter_dyscan_platform_interface.dart';
import 'package:flutter_dyscan/src/exceptions/excpetions.dart';
import 'package:flutter_dyscan/src/models/models.dart';

export 'src/models/models.dart';
export 'src/exceptions/excpetions.dart';

class FlutterDyScan {
  FlutterDyScan._();

  static FlutterDyScan get instance => FlutterDyScan._();

  final FlutterDyScanPlatform _platform = FlutterDyScanPlatform.instance;

  Future<void> init(String apiKey) {
    return _platform.init(apiKey);
  }

  Future<bool> requestCameraPermission() {
    return _platform.requestCameraPermission();
  }

  Future<CardScanResult> startCardScan({DyScanUiSettings? uiSettings}) async {
    bool hasPermission = await _platform.checkCameraPermission();

    if (hasPermission) {
      return _platform.startCardScan(uiSettings: uiSettings);
    } else {
      throw DyScanException(
        type: DyScanExceptionType.noPermissions,
        message: 'Camera permission denied',
        details: StackTrace.current.toString(),
      );
    }
  }
}
