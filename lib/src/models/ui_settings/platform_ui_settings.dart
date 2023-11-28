enum ModalPresentationStyle { pageSheet, fullScreen, automatic }

class AndroidUiSettings {
  final bool showCardOverlay;
  final bool showResultOverlay;

  const AndroidUiSettings({
    this.showCardOverlay = true,
    this.showResultOverlay = false,
  });

  Map<String, dynamic> asMap() {
    return <String, dynamic>{
      'showCardOverlay': showCardOverlay,
      'showResultOverlay': showResultOverlay,
    };
  }
}

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
