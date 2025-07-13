import 'dart:ui';
import '../dy_scan_ui_settings.dart';

class CornerUiSettings {
  final bool showCorners;
  final Color? cornerActiveColor;
  final Color? cornerCompletedColor;
  final Color? cornerInactiveColor;
  final int? cornerThickness;

  const CornerUiSettings({
    this.showCorners = true,
    this.cornerActiveColor,
    this.cornerCompletedColor,
    this.cornerInactiveColor,
    this.cornerThickness,
  });

  Map<String, dynamic> asMap() {
    return <String, dynamic>{
      'showCorners': showCorners,
      'cornerActiveColor': cornerActiveColor?.toHex(),
      'cornerCompletedColor': cornerCompletedColor?.toHex(),
      'cornerInactiveColor': cornerInactiveColor?.toHex(),
      'cornerThickness': cornerThickness,
    };
  }
}
