enum ModalPresentationStyle { pageSheet, fullScreen, automatic }

class IOSUiSettings {
  final ModalPresentationStyle modalPresentationStyle;
  final String? language;
  final bool useFrontCamera;
  final String? defaultCardNumberText;
  final String? defaultExpirationDate;

  const IOSUiSettings({
    this.modalPresentationStyle = ModalPresentationStyle.automatic,
    this.defaultCardNumberText,
    this.defaultExpirationDate,
    this.language,
    this.useFrontCamera = false,
  });

  Map<String, dynamic> asMap() {
    return <String, dynamic>{
      'modalPresentationStyle': modalPresentationStyle.name,
      'defaultCardNumberText': defaultCardNumberText,
      'defaultExpirationDate': defaultExpirationDate,
      'useFrontCamera': useFrontCamera,
      'language': language,
    };
  }
}
