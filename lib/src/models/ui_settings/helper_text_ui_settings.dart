import 'dart:ui';
import '../dy_scan_ui_settings.dart';

class HelperTextUiSettings {
  final bool showHelperText;
  final DyScanHelperTextPosition helperTextPosition;
  final double? helperTextFontSize;
  final String? helperTextString;
  final String? helperTextFontFamily;
  final Color? helperTextColor;

  const HelperTextUiSettings({
    this.showHelperText = true,
    this.helperTextPosition = DyScanHelperTextPosition.bottom,
    this.helperTextFontSize,
    this.helperTextString,
    this.helperTextFontFamily,
    this.helperTextColor,
  });

  Map<String, dynamic> asMap() {
    return <String, dynamic>{
      'showHelperText': showHelperText,
      'helperTextPosition': helperTextPosition.name,
      'helperTextFontSize': helperTextFontSize?.toString(),
      'helperTextString': helperTextString,
      'helperTextFontFamily': helperTextFontFamily,
      'helperTextColor': helperTextColor?.toHex(),
    };
  }
}

enum DyScanHelperTextPosition { top, center, bottom }
