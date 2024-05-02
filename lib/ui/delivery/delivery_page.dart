import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:logistic/common_widget/barcode_scanner.dart';
import 'package:logistic/src/extension/navigator_extension.dart';
import 'package:logistic/src/extension/number_extension.dart';
import 'package:logistic/ui/pick/barcode_detail_page.dart';

import '../../common_widget/mobile_scanner_with_controller.dart';
import '../../model/product.dart';
import '../../route/page_routes.dart';
import '../../src/enum.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final List<Product> _productList = [
    Product(name: "Product 1", status: PickingStatus.loading),
    Product(name: "Product 2", status: PickingStatus.ready),
    Product(name: "Product 3", status: PickingStatus.done),
    Product(name: "Product 4", status: PickingStatus.loading),
    Product(name: "Product 5", status: PickingStatus.done),
    Product(name: "Product 6", status: PickingStatus.loading),
    Product(name: "Product 7", status: PickingStatus.ready),
    Product(name: "Product 8", status: PickingStatus.loading),
    Product(name: "Product 9", status: PickingStatus.done),
  ];

  final TextEditingController _searchController = TextEditingController();
  late ValueNotifier<List<Product>?> _searchNotifier;
  String? _scanBarcode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchNotifier = ValueNotifier(_productList);
    _searchController.addListener(() {
      _searchNotifier.value = _productList
          .where((element) =>
          (element.name ?? '').contains(_searchController.text))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                    onTap: () async {
                      _scanBarcode = await _scanBarcodeNormal();
                      if (_scanBarcode != null) {
                        print("Scanned Barcode : $_scanBarcode");
                      }
                    },
                    child: Icon(
                      Icons.qr_code,
                      color: Colors.green.shade200,
                    )))
          ],
          title: SearchBar(
            leading: const Icon(Icons.search, color: Colors.black,),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
            ),
            controller: _searchController,
            hintText: "Search",
            elevation: MaterialStateProperty.all(0.0),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Delivery List',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: _showSearchList())
            ],
          ),
        ),
        floatingActionButton: Container(
          padding: 20.allPadding,
          width: 120,
          decoration: BoxDecoration(
              color: Colors.green.shade200, borderRadius: 10.borderRadius),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fire_truck_sharp),
              SizedBox(
                width: 10,
              ),
              Text('Pick')
            ],
          ),
        ));
  }

  Widget _showSearchList() {
    return ValueListenableBuilder(
      valueListenable: _searchNotifier,
      builder: (context, value, child) {
        return _showPickUpList(productList: value ?? []);
      },
    );
  }

  Widget _showPickUpList({required List<Product> productList}) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey.withOpacity(0.5),
        ).animate().scale(duration: 200.milliseconds, delay: 200.ms);
      },
      itemCount: productList.length,
      itemBuilder: (context, index) {
        Product product = productList[index];
        return _pickUpItem(product);
      },
    );
  }

  Future<String?> _scanBarcodeNormal() async {
    try {
      return await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE)
          .onError((error, stackTrace) {
        return 'Barcode Scanner Fail';
      });
    } on PlatformException {
      return null;
    }
  }

  Widget _pickUpItem(Product product) {
    return GestureDetector(
      onTap: () async {
        await context.push(
            route: PageRoutes.dialog(
                BarcodeDetailPage(barcodeString: "Hello World")));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: 20.borderRadius),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: 10.borderRadius, color: product.status.color),
              child: const Center(child: Text("TY")),
            ),
            Expanded(
              child: Container(
                margin: (20, 20).padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? '',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Mini detail',
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ).animate().slideX(duration: 200.milliseconds),
    );
  }
}
