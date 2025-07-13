class CardScanResult {
  final String? cardNumber;
  final int? expiryMonth;
  final int? expiryYear;
  final bool isFraud;

  const CardScanResult({
    this.cardNumber,
    this.expiryMonth,
    this.expiryYear,
    this.isFraud = true,
  });

  factory CardScanResult.fromMap(Map<String, dynamic> map) {
    return CardScanResult(
      cardNumber: map['cardNumber'],
      expiryMonth: map['expiryMonth'],
      expiryYear: map['expiryYear'],
      isFraud: map['isFraud'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cardNumber': cardNumber,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'isFraud': isFraud,
    };
  }
}
