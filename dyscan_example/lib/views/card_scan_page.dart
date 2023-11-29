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
      _showSnackBar('${e.type}-${e.message}');
    }
  }

  Future<void> _startCardScan() async {
    try {
      CardScanResult result = await _dyScan.startCardScan(
        uiSettings: const DyScanUiSettings(
          showDynetiLogo: true,
          showRotateButton: false,
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
      _showSnackBar('${e.type}-${e.message}');
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Constants.creditCardPaymentIcon,
                height: 130,
                width: 130,
                filterQuality: FilterQuality.high,
              ),
              const SizedBox(height: 40),
              MaterialButton(
                height: 50,
                minWidth: MediaQuery.of(context).size.width * 0.6,
                onPressed: _startCardScan,
                elevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                color: Theme.of(context).primaryColor,
                splashColor: Colors.white.withOpacity(0.01),
                highlightColor: Colors.white.withOpacity(0.01),
                shape: const StadiumBorder(),
                textColor: Colors.white,
                child: const Text(
                  'Start Scan',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              if (_scanResult != null) ...[
                const SizedBox(height: 30),
                Card(
                  child: Column(
                    children: _scanResult!.toMap().entries.map((e) {
                      return ListTile(
                        title: Text(e.key),
                        trailing: Text(e.value.toString()),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
