import 'dart:async';

import 'package:depend/depend.dart';
import 'package:dvizh_mob/core/services/dio_service.dart';
import 'package:dvizh_mob/src/events/bloc/events/events_bloc.dart';
import 'package:dvizh_mob/src/events/data/repositories/event_repository.dart';
import 'package:dvizh_mob/src/events/data/sources/event_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() async {
  final Talker talker = Talker();
  final dependencies = await DependenciesInit().init(
    progress: [
      (progress) async => DioService.initialize(
            'http://localhost',
          )..addInterceptor(
              TalkerDioLogger(
                talker: talker,
                settings: const TalkerDioLoggerSettings(
                  printRequestHeaders: true,
                  printResponseHeaders: true,
                  printResponseMessage: true,
                ),
              ),
            ),
      (progress) async => EventRepository(
            EventDataSource(
              progress.dependencies.get<DioService>(),
            ),
          ),
    ],
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    talker.error(
      details.exceptionAsString(),
      details.stack.toString(),
    );
  };

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
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
        navigatorObservers: [
          TalkerRouteObserver(Talker()),
        ],
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
