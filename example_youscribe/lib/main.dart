import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';
import 'package:pspdfkit_flutter/widgets/pspdfkit_widget.dart';

const String _documentPath = 'assets/PSPDFKit.pdf';
const String _lockedDocumentPath = 'assets/protected.pdf';

String? licenseError;

Future<File> extractAsset(BuildContext context, String assetPath,
    {bool shouldOverwrite = true, String prefix = ''}) async {
  final bytes = await DefaultAssetBundle.of(context).load(assetPath);
  final list = bytes.buffer.asUint8List();

  final tempDir = await Pspdfkit.getTemporaryDirectory();
  final tempDocumentPath = '${tempDir.path}/$prefix$assetPath';
  final file = File(tempDocumentPath);

  if (shouldOverwrite || !file.existsSync()) {
    await file.create(recursive: true);
    file.writeAsBytesSync(list);
  }
  return file;
}

void unlockPasswordProtectedDocument(BuildContext context) async {
  final extractedLockedDocument =
      await extractAsset(context, _lockedDocumentPath);
  await Navigator.of(context).push<dynamic>(
    MaterialPageRoute<dynamic>(
      builder: (_) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          top: false,
          bottom: false,
          child: PspdfkitWidget(
            documentPath: extractedLockedDocument.path,
            configuration: const PspdfkitConfiguration(password: 'test123'),
          ),
        ),
      ),
    ),
  );
}

void showDocument(BuildContext context) async {
  final extractedDocument = await extractAsset(context, _documentPath);
  await Navigator.of(context).push<dynamic>(
    MaterialPageRoute<dynamic>(
      builder: (_) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: SafeArea(
          top: false,
          bottom: false,
          child: PspdfkitWidget(
            documentPath: extractedDocument.path,
            configuration: const PspdfkitConfiguration(startPage: 6),
          ),
        ),
      ),
    ),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const String iosLicense = String.fromEnvironment('IOS_LICENSE');
  const String androidLicense = String.fromEnvironment('ANDROID_LICENSE');

  if (iosLicense.isEmpty || androidLicense.isEmpty) {
    licenseError =
        'You must provide `IOS_LICENSE` and `ANDROID_LICENSE` keys in your build environment.';
    print(licenseError);
  } else {
    await Pspdfkit.setLicenseKeys(androidLicense, iosLicense)
        .catchError((error) {
      print(error);
      if (error is PlatformException) {
        licenseError = error.message;
      } else {
        licenseError = error.toString();
      }
    });
  }

  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Main(),
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PSPDFKit / YouScribe Flutter Example'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          if (licenseError != null) ...[
            Text(
              'License Error: $licenseError',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          ListTile(
            title: const Text('Show Document'),
            onTap: () => showDocument(context),
          ),
          ListTile(
            title: const Text('Unlock Password Protected Document'),
            onTap: () => unlockPasswordProtectedDocument(context),
          ),
        ],
      ),
    );
  }
}
