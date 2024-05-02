// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
//
// class BarcodeScanner extends StatefulWidget {
//   BarcodeScanner({super.key, this.color});
//
//   Color? color;
//
//   @override
//   State<BarcodeScanner> createState() => _BarcodeScannerState();
// }
//
// class _BarcodeScannerState extends State<BarcodeScanner> with WidgetsBindingObserver {
//
//   final MobileScannerController controller = MobileScannerController(
//     // required options for the scanner
//   );
//
//   StreamSubscription<Object?>? _subscription;
//
//   @override
//   void initState() {
//     super.initState();
//     // Start listening to lifecycle changes.
//     WidgetsBinding.instance.addObserver(this);
//
//     // Start listening to the barcode events.
//     _subscription = controller.barcodes.listen(_handleBarcode);
//
//     // Finally, start the scanner itself.
//     unawaited(controller.start());
//   }
//
//     void _handleBarcode(BarcodeCapture barcode){
//       print("Barcode :::: $barcode");
//     }
//
//
//   @override
//   Future<void> dispose() async {
//     // Stop listening to lifecycle changes.
//     WidgetsBinding.instance.removeObserver(this);
//     // Stop listening to the barcode events.
//     unawaited(_subscription?.cancel());
//     _subscription = null;
//     // Dispose the widget itself.
//     super.dispose();
//     // Finally, dispose of the controller.
//     controller.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//
//       },
//       child: Icon(Icons.qr_code, color: widget.color,),
//     );
//   }
//
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//
//     switch (state) {
//       case AppLifecycleState.detached:
//       case AppLifecycleState.hidden:
//       case AppLifecycleState.paused:
//         return;
//       case AppLifecycleState.resumed:
//       // Restart the scanner when the app is resumed.
//       // Don't forget to resume listening to the barcode events.
//         _subscription = controller.barcodes.listen(_handleBarcode);
//
//         unawaited(controller.start());
//       case AppLifecycleState.inactive:
//       // Stop the scanner when the app is paused.
//       // Also stop the barcode events subscription.
//         unawaited(_subscription?.cancel());
//         _subscription = null;
//         unawaited(controller.stop());
//     }
//   }
// }
