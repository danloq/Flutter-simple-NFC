# Flutter Simple NFC App

This is a simple Flutter application that demonstrates the capabilities of scanning NFC tags on Android devices using the `flutter_nfc_kit` package.

## Features

- Checks NFC availability on device startup.
- Provides feedback when NFC is not available.
- Listens for NFC tags and outputs the scanned data to the console.

## Installation

1. Ensure you have [Flutter](https://flutter.dev/docs/get-started/install) installed and set up on your machine.

2. Clone this repository:
   ```sh
   git clone https://github.com/danloq/Flutter-simple-NFC.git
   ```

3. Navigate to the cloned directory and install dependencies:
   ```sh
   cd Flutter-simple-NFC
   flutter pub get
   ```

4. Connect your device and run the app:
   ```sh
   flutter run
   ```

## Usage

1. Launch the app on your Android device.
2. Bring an NFC tag close to your device.
3. Check the console output to see the scanned NFC data.

## Dependencies

- [flutter_nfc_kit](https://pub.dev/packages/flutter_nfc_kit): A Flutter plugin for accessing the NFC features on Android.

## License

This project is open-source and available under the MIT License. See [LICENSE](LICENSE) for more details.
