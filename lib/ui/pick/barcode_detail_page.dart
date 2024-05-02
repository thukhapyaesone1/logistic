import 'dart:ui';

import 'package:barcode/barcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logistic/src/extension/number_extension.dart';

class BarcodeDetailPage extends StatefulWidget {
  BarcodeDetailPage({super.key, required this.barcodeString});

  String barcodeString;

  @override
  State<BarcodeDetailPage> createState() => _BarcodeDetailPageState();
}

class _BarcodeDetailPageState extends State<BarcodeDetailPage> {
  late String qrSvg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _buildBarcode(Barcode.code128(), widget.barcodeString);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color:
                      Colors.black.withOpacity(0.3), // Adjust the opacity here
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: (250, 50).padding,
              decoration: BoxDecoration(
                  borderRadius: 10.borderRadius, color: Colors.white),
              child: Padding(
                padding: (40, 20).padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: 10.horizontalPadding,
                      child: Center(child: SvgPicture.string(qrSvg)),
                    ),
                    Padding(
                      padding: 16.verticalPadding,
                      child: const Divider(
                        thickness: 3,
                      ),
                    ),
                    const Text(
                      'Product Name',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Expanded(
                      child: Text(
                        'Product Detail. will be used instead (which ensures better layout experience). There is currently no way to show an Error visually, however errors will get properly logged to the console in debug mode',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _buildBarcode(
    Barcode bc,
    String data, {
    String? filename,
    double? width,
    double? height,
    double? fontHeight,
  }) {
    qrSvg = bc.toSvg(
      data,
      width: width ?? 200,
      height: height ?? 80,
      fontHeight: fontHeight,
    );

    print('QR ::: $qrSvg');
  }
}
