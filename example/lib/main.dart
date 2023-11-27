import 'package:flutter/material.dart';

import 'package:flutter_dyscan/flutter_dyscan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CardScanScreen());
  }
}

class CardScanScreen extends StatefulWidget {
  const CardScanScreen({super.key});

  @override
  State<CardScanScreen> createState() => _CardScanScreenState();
}

class _CardScanScreenState extends State<CardScanScreen> {
  final FlutterDyScan _dyScan = FlutterDyScan.instance;

  @override
  void initState() {
    super.initState();
    _dyScan.init(''); // TODO Enter your DyScan apikey
  }

  void _showSnackBar(String message) {
    SnackBar snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin Example App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              CardScanResult result = await _dyScan.startCardScan();
              _showSnackBar(result.toMap().toString());
            } on DyScanNotInitialzedException catch (e) {
              _showSnackBar(e.message);
            } on CardScanResultException catch (e) {
              _showSnackBar(e.message);
            }
          },
          child: const Text('Scan Card'),
        ),
      ),
    );
  }
}
