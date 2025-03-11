import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:eventssytem/widgets/sliding_map.dart';

import 'package:latlong2/latlong.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<MapVisibleCubit, MapTochkiVisibleState>(
        builder: (context, state) {
      if (state is MapTochkiVisibleLoadingState) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is MapTochkiVisibleErrorState) {
        return Center(child: Text("${AppLocalizations.of(context)?.error}"));
      }
      if (state is MapTochkiVisibleLoadedState) {
        MapController mapController = MapController();

        late List<LatLng> latLngList = state.tochki!
            .map((points) => LatLng(points.latitude, points.longitude))
            .toList();

        List<Marker> markers = state.tochki!
          .map((points) => Marker(
                point: LatLng(points.latitude, points.longitude),
                width: 60,
                height: 60,
                child: GestureDetector(
                  onTap: () {
                    context.read<SlidingMapCubit>().open(
                        points.name,
                        points.description,
                        points.address,
                        points.website,
                        points.phone,
                        points.colorDot);
                  },
                  child: Icon(
                    Icons.pin_drop,
                    size: 44,
                    color: points.colorDot,
                  ),
                ),
              ))
          .toList();


        if (state.v == true) {
          Future.delayed(const Duration(milliseconds: 500), () {
            context.read<SlidingMapCubit>().open(
                state.tochki![0].name,
                state.tochki![0].description,
                state.tochki![0].address,
                state.tochki![0].website,
                state.tochki![0].phone,
                state.tochki![0].colorDot);
          });
        }

        return Stack(
          children: [
            FlutterMap(
              mapController: mapController,
                options: MapOptions(
                  initialCenter: LatLng(
                    state.tochki![0].latitude, state.tochki![0].longitude),
                  initialZoom: 7.0, 
                  maxZoom: 18,
                  minZoom: 2,
                  onTap: (tapPosition, latlng) {
                    print(latlng);
                },
              ),
              children: [
                TileLayer(
                  minZoom: 2,
                  maxZoom: 18,
                  //backgroundColor: kBacColor,
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                    maxClusterRadius: 190,
                    disableClusteringAtZoom: 16,
                    size: Size(50, 50),
                    // fitBoundsOptions: FitBoundsOptions(
                    //   padding: EdgeInsets.all(50),
                    // ),
                    markers: markers,
                    polygonOptions: PolygonOptions(
                      borderColor: Colors.blueAccent,
                      color: Colors.black12,
                      borderStrokeWidth: 3,
                    ),
                    builder: (context, markers) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${markers.length}',
                          style: kTextStyleWhiteZ,
                        ),
                      );
                    },
                  ),
                ),

              ]),
          Row(
            children: [
              SafeArea(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //     '/main', (Route<dynamic> route) => false);
                          },
                          child: Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1000)),
                              child: SvgPicture.asset(
                                "assets/icons/left.svg",
                                color: Color(0xFF25282B),
                              )),
                        ),
                      ))),
              Expanded(
                child: Visibility(
                  visible: state.v,
                  child: SafeArea(
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<MapVisibleCubit>()
                                    .fetchTochki(v: false);
                                //       context.read<SlidingMapCubit>().hide();
                              },
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(state.tochki![0].name,
                                            style: kMapVerhPanelV,
                                            textAlign: TextAlign.center),
                                      )),
                                      SizedBox(width: 10),
                                      SvgPicture.asset(
                                        "assets/icons/X.svg",
                                        color: Color(0xFFBDBDBD),
                                      ),
                                    ],
                                  )),
                            ),
                          ))),
                ),
              ),
              SafeArea(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            context.read<SlidingMapCubit>().hide();
                            Navigator.pushNamed(context, '/mapinfo');
                          },
                          child: Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1000)),
                              child: SvgPicture.asset(
                                "assets/icons/mapwhat.svg",
                                color: Color(0xFF25282B),
                              )),
                        ),
                      ))),
            ],
          ),
          SlidingMap()
        ]);
      }
      return Center(child: Text("${AppLocalizations.of(context)?.error}"));
    }));
  }
}
