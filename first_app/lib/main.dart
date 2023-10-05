import 'package:first_app/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

import 'gradient_container.dart';

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
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    initNFC(); // check NFC availability on app start
  }

  Future<void> initNFC() async {
    var availability = await FlutterNfcKit.nfcAvailability;
    if (availability != NFCAvailability.available) {
      setState(() {
        _nfcData = 'NFC not available';
      });
    }
  }

  Future<void> toggleListening() async {
    setState(() {
      _isListening =
          !_isListening; // Toggle the listening state immediately when the button is pressed
    });

    if (_isListening) {
      var availability = await FlutterNfcKit.nfcAvailability;
      if (availability == NFCAvailability.available) {
        while (_isListening) {
          try {
            final NFCTag tag = await FlutterNfcKit.poll();
            setState(() {
              _nfcData = tag.id;
            });
          } on Exception catch (e) {
            setState(() {
              _nfcData = 'Error reading NFC: $e';
              _isListening = false; // Stop listening if there's an error
            });
          }
        }
      } else {
        setState(() {
          _nfcData = 'NFC not available';
        });
      }
    } else {
      // If the user wants to stop listening
      FlutterNfcKit.finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('NFC Reader App'),
      ),
      body: GradientContainer(
        colors: const [Colors.blue, Colors.purple],
        children: [
          const StyledText(text: 'NFC Data:'),
          StyledText(key: ValueKey(_nfcData), text: _nfcData),
          const SizedBox(height: 20),
          TextButton(
            onPressed: toggleListening,
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return _isListening ? Colors.red[700]! : Colors.green[700]!;
                  }
                  return _isListening ? Colors.red[600]! : Colors.green[600]!;
                },
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            child: Text(
              _isListening ? 'Stop Listening' : 'Start Listening',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
