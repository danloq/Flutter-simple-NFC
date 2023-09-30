import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFC Reader',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _nfcData = 'No Data';

  @override
  void initState() {
    super.initState();
    initNFC();
  }

  Future<void> initNFC() async {
    var availability = await FlutterNfcKit.nfcAvailability;
    if (availability == NFCAvailability.available) {
      try {
        final NFCTag tag = await FlutterNfcKit.poll();
        // This is where you handle the NFC tag data
        setState(() {
          _nfcData = tag.id;
        });
      } on Exception catch (e) {
        setState(() {
          _nfcData = 'Error reading NFC: $e';
        });
      }
    } else {
      setState(() {
        _nfcData = 'NFC not available';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC Reader App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('NFC Data:'),
            Text(_nfcData),
            ElevatedButton(
              onPressed: initNFC,
              child: const Text('Scan Again'),
            ),
          ],
        ),
      ),
    );
  }
}
