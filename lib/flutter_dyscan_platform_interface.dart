import 'package:flutter_dyscan/src/models/models.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_dyscan_method_channel.dart';

abstract class FlutterDyScanPlatform extends PlatformInterface {
  /// Constructs a FlutterDyscanPlatform.
  FlutterDyScanPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterDyScanPlatform _instance = MethodChannelFlutterDyScan();

  /// The default instance of [FlutterDyScanPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterDyScan].
  static FlutterDyScanPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterDyScanPlatform] when
  /// they register themselves.
  static set instance(FlutterDyScanPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init(String apiKey);

  Future<CardScanResult> startCardScan({DyScanUiSettings? uiSettings});

  Future<bool> requestCameraPermission();

  Future<bool> checkCameraPermission();
}
