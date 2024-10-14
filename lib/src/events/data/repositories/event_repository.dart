import 'package:depend/depend.dart';

import '../sources/event_data_source.dart';

class EventRepository extends Dependency {
  final EventDataSource _eventDataSource;

  EventRepository(this._eventDataSource);

  Future getEvents() async => _eventDataSource.getEvents();
}
