import 'dart:async';

import 'package:depend/depend.dart';
import 'package:dvizh_mob/core/services/dio_service.dart';
import 'package:dvizh_mob/src/events/bloc/events/events_bloc.dart';
import 'package:dvizh_mob/src/events/data/repositories/event_repository.dart';
import 'package:dvizh_mob/src/events/data/sources/event_data_source.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() async {
  final dependencies = await DependenciesInit().init(
    progress: [
      (progress) async => DioService.initialize(
            'http://localhost',
          )..addInterceptor(
              PrettyDioLogger(
                requestHeader: true,
                requestBody: true,
                responseBody: true,
                responseHeader: false,
                error: true,
                compact: true,
                maxWidth: 90,
                enabled: kDebugMode,
              ),
            ),
      (progress) async => EventRepository(
            EventDataSource(
              progress.dependencies.get<DioService>(),
            ),
          ),
    ],
  );
  runApp(
    MyApp(
      dependencies: dependencies,
    ),
  );
}

class MyApp extends StatelessWidget {
  final DependenciesLibrary dependencies;
  const MyApp({super.key, required this.dependencies});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Dependencies(
      dependencies: dependencies,
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => EventsBloc(
                Dependencies.of(context).get<EventRepository>()
              ),
            )
          ],
          child: const MyHomePage(),
        ),
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
    context.read<EventsBloc>().add(FetchEventsEvent());
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
          );
        },
      ),
    );
  }
}
