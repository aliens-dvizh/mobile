// 📦 Package imports:
import 'package:depend/depend.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/events/dependency/ievent_dependency.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/events/repositories/ievent_repository.dart';

class EventLibrary extends DependencyContainer<RootLibrary>
    implements IEventDependency {
  EventLibrary({required super.parent});

  @override
  Future<void> init() async {
    eventRepository = EventRepository(
      EventDataSource(
        parent.dioService,
      ),
    );
  }

  @override
  late final IEventRepository eventRepository;
}
