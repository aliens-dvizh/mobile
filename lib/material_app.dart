import 'dart:async';

import 'package:depend/depend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'src/events/export.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        TalkerRouteObserver(Talker()),
      ],
      title: 'Flutter Demo',
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                EventsBloc(Dependencies.of(context).get<EventRepository>()),
          )
        ],
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  EventIndexParams params = EventIndexParams();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void _listener(BuildContext context, EventsState state) {
    print('listener');
  }

  @override
  void initState() {
    super.initState();
    context.read<EventsBloc>().add(FetchEventsEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EventsBloc, EventsState>(
        listener: _listener,
        builder: (context, state) {
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              Marker(
                markerId: MarkerId('1'),
                position: LatLng(37.42796133580664, -122.085749655962),
                infoWindow: InfoWindow(
                  title: 'Googleplex',
                  snippet: 'Google Headquarters',
                ),
              ),
            },
          );
        },
      ),
    );
  }
}
