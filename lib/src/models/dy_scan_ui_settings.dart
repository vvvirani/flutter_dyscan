import 'package:flutter/services.dart';
import 'package:flutter_dyscan/flutter_dyscan.dart';

export 'ui_settings/platform_ui_settings.dart';
export 'ui_settings/helper_text_ui_settings.dart';
export 'ui_settings/corner_ui_settings.dart';

class DyScanUiSettings {
  final HelperTextUiSettings helperTextUiSettings;
  final CornerUiSettings cornerUiSettings;
  final AndroidUiSettings androidUiSettings;
  final IOSUiSettings iOSUiSettings;
  final Color? bgColor;
  final double? bgOpacity;
  final bool showDynetiLogo;
  final bool showRotateButton;
  final bool vibrateOnCompletion;
  final bool lightTorchWhenDark;

  const DyScanUiSettings({
    this.androidUiSettings = const AndroidUiSettings(),
    this.iOSUiSettings = const IOSUiSettings(),
    this.helperTextUiSettings = const HelperTextUiSettings(),
    this.cornerUiSettings = const CornerUiSettings(),
    this.bgColor,
    this.bgOpacity,
    this.showDynetiLogo = true,
    this.showRotateButton = false,
    this.vibrateOnCompletion = true,
    this.lightTorchWhenDark = false,
  });

  Map<String, dynamic> asMap() {
    return <String, dynamic>{
      ...helperTextUiSettings.asMap(),
      ...cornerUiSettings.asMap(),
      ...androidUiSettings.asMap(),
      ...iOSUiSettings.asMap(),
      'bgColor': bgColor?.toHex(),
      'bgOpacity': bgOpacity?.toString(),
      'showDynetiLogo': showDynetiLogo,
      'showRotateButton': showRotateButton,
      'vibrateOnCompletion': vibrateOnCompletion,
      'lightTorchWhenDark': lightTorchWhenDark,
    };
  }

  static DyScanUiSettings get defaultUiSettings {
    return const DyScanUiSettings(
      androidUiSettings: AndroidUiSettings(),
      iOSUiSettings: IOSUiSettings(),
    );
  }
}

extension ColorEx on Color {
  String toHex() {
    return '#${value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }
}
