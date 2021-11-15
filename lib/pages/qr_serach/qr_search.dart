import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRSearch extends StatefulWidget {
  QRSearch({Key? key}) : super(key: key);

  @override
  _QRSearchState createState() => _QRSearchState();
}

class _QRSearchState extends State<QRSearch> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _qrController;
  int _goBackTimes = 0;
  bool _cameraOnHold = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _qrController!.pauseCamera();
    } else if (Platform.isIOS) {
      _qrController!.resumeCamera();
    }
  }

  @override
  void dispose() {
    _qrController?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController qrController, BuildContext context) {
    _qrController = qrController;
    _qrController!.scannedDataStream.listen((scanData) {
      _qrController!.pauseCamera();
      _cameraOnHold = true;
      _goBackTimes = 0;
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          leading: Icon(Icons.qr_code_rounded),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Contenido del QR:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text("${scanData.code}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                await Future.delayed(Duration(milliseconds: 600));
                Navigator.of(context).pop();
              },
              child: Text("Salir"),
            ),
            TextButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                await Future.delayed(Duration(milliseconds: 600));
                Navigator.of(context).pop("${scanData.code}");
              },
              child: Text("Buscar libro"),
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        await _qrController!.resumeCamera();
        _cameraOnHold = false;
        _goBackTimes++;
        // if (_goBackTimes == 1)
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text("Back de nuevo para salir"),
        //     ),
        //   );
        // true: Navigator pop, false: return
        return !_cameraOnHold && _goBackTimes > 1;
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: QRView(
                overlay: QrScannerOverlayShape(
                  borderWidth: 2,
                  // cutOutHeight: 200,
                  // cutOutWidth: 200,
                ),
                key: _qrKey,
                onQRViewCreated: (qrController) {
                  _onQRViewCreated(qrController, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
