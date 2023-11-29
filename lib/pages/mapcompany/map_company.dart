// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:fms_mobile_app/services/provider_service.dart';
import 'package:fms_mobile_app/shared/mydata.dart';
import 'package:fms_mobile_app/theme/color.dart';
import 'package:fms_mobile_app/widgets/custom_image.dart';
import 'package:fms_mobile_app/widgets/custom_popup.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Mapcompany extends StatefulWidget {
  const Mapcompany({super.key});

  @override
  State<Mapcompany> createState() => _MapcompanyState();
}

late Map<DateTime, List<Appointment>> _dataCollection;

class _MapcompanyState extends State<Mapcompany> {
  var _mapController = MapController();
  bool isMapRead = false;
  bool? _loding;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCurrentLocation();
    });
  }

  getCurrentLocation() async {
    setState(() {
      _loding = true;
    });

    final providerService = Provider.of<ProviderService>(context, listen: false);
    // await

    if (Geolocator.checkPermission == LocationPermission.denied) {
      providerService.setLocation();
    } else {
      await providerService.setLocation();
      setState(() {
        _loding = false;
      });
      setState(() {
        print(providerService.userLocation);
        _mapController.move(
            LatLng(providerService.userLocation?.latitude ?? 0, providerService.userLocation?.longitude ?? 0), 15.0);
      });
    }
  }

  Future checkingWorks() async {
    final providerService = Provider.of<ProviderService>(context, listen: false);

    await Future.delayed(Duration(seconds: 3), (() {
      providerService.setTeamWork();

      setState(() {
        _mapController.move(
            LatLng(providerService.userLocation?.latitude ?? 0, providerService.userLocation?.longitude ?? 0), 15.0);
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: white,
          ),
          onPressed: () {
            Navigator.pop(
              context,
              // MYHomePage is another page for showcase
              // replace it with your page name
            );
          },
        ),
        title: const Text(
          " ແຜນທີ່",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xff039881),
                Color(0xff024C41),
              ],
            ),
          ),
        ),
      ),
      body: _loding == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : getHeader(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 20),
        child: FloatingActionButton(
          backgroundColor: primary,
          onPressed: () {
            getCurrentLocation();
          },
          child: const Icon(
            Icons.my_location,
            color: white,
          ),
        ),
      ),
    );
  }

  List id = [];

  getHeader() {
    final providerService = Provider.of<ProviderService>(context);
    final locationall = providerService.locationall;
    final circleMarkers = <CircleMarker>[
      // CircleMarker(
      //     point: LatLng(17.964476191926465, 102.63424515724182),
      //     color: Colors.red.withOpacity(0.3),
      //     borderStrokeWidth: 2,
      //     useRadiusInMeter: true,
      //     radius: 500 // 2000 meters | 2 km
      //     ),
    ];

    final markers = <Marker>[
      // Marker(
      //   width: 60,
      //   height: 60,
      //   point: LatLng(providerService.userLocation?.latitude ?? 0,
      //       providerService.userLocation?.longitude ?? 0),
      //   builder: (ctx) => Container(
      //     key: const Key('purple'),
      //     child: Image.asset(
      //       "assets/images/22.gif",
      //     ),
      //   ),
      // ),
    ];

    // for(var i in locationall){
    //   id.add(i.fieldLocationId);
    // }

    for (var i = 0; i < locationall.length; i++) {
      double distance = double.parse('${locationall[i].distance ?? 0}');
      var dateInFormatText = locationall[i].latLng?.toString().split(",");

      // int idlocation = locationall[i].fieldLocationId?? 0 ;

      // id.add(locationall[i].fieldLocationId?? 0);

      double latitude = double.parse(dateInFormatText![0]);
      double longitude = double.parse(dateInFormatText[1]);
      //  print(MyData.field_location_id);

      // print(latitude);
      circleMarkers.add(CircleMarker(
          point: LatLng(latitude, longitude),
          // color: Colors.red.withOpacity(0.3),
          color: MyData.field_location_id == locationall[i].fieldLocationId
              ? Colors.green.withOpacity(0.3)
              : Colors.red.withOpacity(0.3),
          borderStrokeWidth: 2,
          useRadiusInMeter: true,
          radius: distance // 2000 meters | 2 km
          // radius:2000
          ));

      markers.add(
        Marker(
          key: ValueKey(locationall[i].fieldLocationId),
          alignment: Alignment.center,
          width: locationall[i].img == null ? 30 : 55, // 279.0,
          height: locationall[i].img == null ? 30 : 55, // 256.0,
          point: LatLng(latitude, longitude),
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: CustomPopup(),
                // Text("${Detail}"),
              ));
            },
            child: locationall[i].img == null
                ? Image.asset(
                    "assets/images/giphy.gif",
                  )
                : CustomImage(
                    locationall[i].img.toString(),
                    radius: 25,
                  ),
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        Container(
          child: providerService.userLocation?.latitude == "" &&
                  providerService.userLocation?.latitude == null &&
                  providerService.userLocation?.longitude == "" &&
                  providerService.userLocation?.longitude == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      center: LatLng(
                          providerService.userLocation?.latitude ?? 0, providerService.userLocation?.longitude ?? 0),
                      zoom: 15.0,
                      // maxZoom: 18.4,
                      minZoom: 1.0,
                      onTap: (final tapos, LatLng position) {},
                    ),
                    //                    nonRotatedChildren: [
                    //   AttributionWidget.defaultWidget(
                    //     source: '© OpenStreetMap contributors',
                    //     onSourceTapped: () {},
                    //   ),
                    // ],

                    children: [
                      MyData.urlMap == '1'
                          ? TileLayer(
                              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c'],
                              tileSize: 256,
                            )
                          : TileLayer(
                              wmsOptions: WMSTileLayerOptions(
                                baseUrl: '${MyData.urlMap}',
                                layers: ['s2cloudless-2018_3857'],
                              ),
                              subdomains: ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'],
                            ),
                      //    LocationMarkerLayerWidget(),
                      CircleLayer(circles: circleMarkers),
                      MarkerLayer(markers: markers),

                      CurrentLocationLayer(),

                      // Positioned(
                      //   bottom: 80,
                      //   right: 20,
                      //   child:
                      //       //              ElevatedButton(

                      //       //     style: ButtonStyle(
                      //       //  backgroundColor: MaterialStatePropertyAll<Color>(primary),
                      //       //         padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      //       //             EdgeInsets.only(
                      //       //                 bottom: 10, top: 10, left: -12, right: -12)),
                      //       //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      //       //           RoundedRectangleBorder(
                      //       //             borderRadius: BorderRadius.circular(10.0),
                      //       //             // side: BorderSide(color: Colors.red),
                      //       //           ),
                      //       //         )),
                      //       //       onPressed: () {
                      //       //                 getCurrentLocation();
                      //       //               },
                      //       //     child: Icon(
                      //       //      Icons.my_location,
                      //       //       size: 35.0,
                      //       //       color: appBarColor,
                      //       //     ),
                      //       //   )
                      //   //     FloatingActionButton(
                      //   //   backgroundColor: primary,
                      //   //   elevation: 2,
                      //   //   onPressed: () {
                      //   //     getCurrentLocation();
                      //   //   },
                      //   //   tooltip: 'My location',
                      //   //   child: const Icon(
                      //   //     Icons.my_location,
                      //   //     color: white,
                      //   //   ),
                      //   // ),
                      // ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  var infoWindowVisible = false;
  GlobalKey<State> key = new GlobalKey();
  // _buildCustomMarker() {
  //   return Stack(
  //     children: <Widget>[popup(), marker()],
  //   );
  // }

  popup(item) {
    return Opacity(
      opacity: 1.0,
      child: Container(
        // alignment: Alignment.bottomCenter,
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/ic_info_window.png"), fit: BoxFit.cover)),
        child: CustomPopup(),
      ),
    );
  }

  marker() {
    return Opacity(
      child: Container(
          width: 279.0,
          height: 256.0,
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            'assets/images/giphy.gif',
            width: 50.0,
            height: 50.0,
          )),
      opacity: 1.0,
    );
  }
}
