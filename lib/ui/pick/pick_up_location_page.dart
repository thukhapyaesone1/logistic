import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:logistic/src/extension/navigator_extension.dart';
import 'package:logistic/src/extension/number_extension.dart';
import 'package:logistic/ui/delivery/delivery_page.dart';
import 'package:logistic/ui/pick/pick_up_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../model/location.dart';
import '../../route/route_list.dart';

class PickUpLocationsPage extends StatefulWidget {
  PickUpLocationsPage({super.key, required this.isPickUp});
  bool isPickUp ;

  @override
  State<PickUpLocationsPage> createState() => _PickUpLocationsPageState();
}

class _PickUpLocationsPageState extends State<PickUpLocationsPage> {
  late ValueNotifier<List<Location>?> _searchNotifier;
  final TextEditingController _searchController = TextEditingController();
  final List<Location> _locationList = [
    Location(
        name: "Location 1",
        phoneNumber: '09000000',
        createdAt: DateTime.tryParse('2024-02-12')),
    Location(
        name: "Location 2",
        phoneNumber: '09000000',
        createdAt: DateTime.tryParse('2024-02-12')),
    Location(
        name: "Location 3",
        phoneNumber: '09000000',
        createdAt: DateTime.tryParse('2024-02-12')),
    Location(
        name: "Location 4",
        phoneNumber: '09000000',
        createdAt: DateTime.tryParse('2024-02-12'))
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchNotifier = ValueNotifier(_locationList);
    _searchController.addListener(() {
      _searchNotifier.value = _locationList
          .where((element) => (element.name ?? '').contains(_searchController.text))
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
          title: SearchBar(
            leading: const Icon(
              Icons.search,
              color: Colors.black,
            ),
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
          padding: 24.allPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: 8.verticalPadding,
                child: Text( widget.isPickUp ? "Pick Up Location List" : "Delivery Location", style: const TextStyle(fontWeight: FontWeight.bold),),
              ),
              _showLocationList(),
            ],
          ),
        ));
  }

  Widget _showLocationList() {
    return ValueListenableBuilder(
      valueListenable: _searchNotifier,
      builder: (context, value, child) {
        return _showPickUpList(locationList: value ?? []);
      },
    );
  }

  Widget _showPickUpList({required List<Location> locationList}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey.withOpacity(0.5),
          ).animate().scale(duration: 200.milliseconds, delay: 200.ms);
        },
        itemCount: locationList.length,
        itemBuilder: (context, index) {
          Location location = locationList[index];
          return _pickUpLocation(location);
        },
      ),
    );
  }

  Widget _pickUpLocation(Location location) {
    return GestureDetector(
      onTap: () async {
        // context.pushTo(route: RouteList.pickUpPage);
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: widget.isPickUp ? const PickUpPage() : const DeliveryPage(),
        );
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: 20.borderRadius),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: 10.borderRadius, color: Colors.green.shade50),
              child: const Center(child: Text("TY")),
            ),
            Expanded(
              child: Container(
                margin: (20, 20).padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.name ?? '',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      location.createdAt.toString(),
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
