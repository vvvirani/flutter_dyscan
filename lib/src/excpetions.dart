abstract class DyScanException implements Exception {
  final String code;
  final String message;

  DyScanException(this.code, this.message);
}

class DyScanNotInitialzedException extends DyScanException {
  DyScanNotInitialzedException()
      : super('not_initialzed',
            'Ensure to initialize FlutterDyScan before accessing it. Please execute the init() method');
}

class CardScanResultException extends DyScanException {
  CardScanResultException({required String code, required String message})
      : super(code, message);
}
