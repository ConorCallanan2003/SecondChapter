import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class SellPage extends StatelessWidget {
  SellPage({super.key});

  ValueNotifier<String> barcode = ValueNotifier('');

  void handleScan() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        'blue', 'Cancel', false, ScanMode.BARCODE);
    barcode.value = barcodeScanRes;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 100),
          color: Colors.blue,
          height: height,
          width: width,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            TextButton(
              onPressed: () => handleScan(),
              child: const Text(
                'Scan',
                style: TextStyle(
                    fontSize: 44,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: width,
              height: height * .2,
            ),
            Container(
              height: height * .35,
              width: width * .8,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.white),
            ),
            ValueListenableBuilder(
              valueListenable: barcode,
              builder: (context, String value, child) {
                return Text(
                  value,
                  style: const TextStyle(
                      fontSize: 44,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}
