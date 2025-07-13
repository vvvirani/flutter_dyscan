import 'package:dyscan_example/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dyscan/flutter_dyscan.dart';

class CardScanScreen extends StatefulWidget {
  const CardScanScreen({super.key});

  @override
  State<CardScanScreen> createState() => _CardScanScreenState();
}

class _CardScanScreenState extends State<CardScanScreen> {
  final FlutterDyScan _dyScan = FlutterDyScan.instance;

  CardScanResult? _scanResult;

  @override
  void initState() {
    super.initState();
    _initDyScan();
  }

  Future<void> _initDyScan() async {
    try {
      await _dyScan.init(Constants.dyScanApiKey);
    } on DyScanException catch (e) {
      _showSnackBar('${e.type.name}: ${e.message}');
    }
  }

  Future<void> _startCardScan() async {
    bool granted = await _dyScan.requestCameraPermission();

    if (granted) {
      try {
        CardScanResult result = await _dyScan.startCardScan(
          uiSettings: const DyScanUiSettings(
            showDynetiLogo: true,
            showRotateButton: true,
            vibrateOnCompletion: true,
            iOSUiSettings: IOSUiSettings(
              modalPresentationStyle: ModalPresentationStyle.pageSheet,
              defaultCardNumberText: '1234 1234 1234 1234',
              defaultExpirationDate: 'MM / YY',
            ),
          ),
        );

        setState(() {
          _scanResult = result;
        });
      } on DyScanException catch (e) {
        _showSnackBar('${e.type.name}: ${e.message}');
      }
    }
  }

  void _showSnackBar(String message) {
    SnackBar snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Debit/Credit Card')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _scanResult != null
            ? Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _scanResult!.toMap().entries.map((e) {
                    return ListTile(
                      title: Text(e.key),
                      trailing: Text(e.value.toString()),
                    );
                  }).toList(),
                ),
              )
            : const Center(
                child: Text(
                  'Start Scan',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startCardScan,
        elevation: 0,
        highlightElevation: 0,
        splashColor: Colors.white.withValues(alpha: 0.01),
        child: const Icon(Icons.document_scanner_outlined),
      ),
    );
  }
}
