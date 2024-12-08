// 📦 Package imports:
import 'package:depend/depend.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';
import 'package:dvizh_mob/src/events/dependency/event_dependency.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/events/repositories/mock_event_repository.dart';

class EventDependencyFactory extends DependencyFactory<EventDependency> {
  EventDependencyFactory({
    required bool useMocks,
    required DioService dioService,
  })  : _useMocks = useMocks,
        _dioService = dioService;

  final bool _useMocks;
  final DioService _dioService;

  @override
  Future<EventDependency> create() async {
    final repository = _useMocks
        ? MockEventRepository()
        : EventRepository(
            EventDataSource(
              _dioService,
            ),
          );

    return EventDependency(eventRepository: repository);
  }
}
