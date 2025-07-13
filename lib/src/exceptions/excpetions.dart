import 'package:flutter/services.dart';

class DyScanException implements Exception {
  final DyScanExceptionType type;
  final String? message;
  final Object? details;

  const DyScanException({
    required this.type,
    this.message,
    this.details,
  });

  factory DyScanException.fromPlatformException(PlatformException exception) {
    return DyScanException(
      type: DyScanExceptionType.fromString(exception.code),
      message: exception.message,
      details: exception.details,
    );
  }
}

enum DyScanExceptionType {
  notInitialized,
  notSupported,
  authError,
  cameraError,
  noPermissions,
  userCancelled,
  unknown;

  static DyScanExceptionType fromString(String type) {
    return DyScanExceptionType.values.firstWhere(
      (e) => e.name == type,
      orElse: () => DyScanExceptionType.unknown,
    );
  }
}
