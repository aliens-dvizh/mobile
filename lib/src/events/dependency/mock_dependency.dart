// 📦 Package imports:
import 'package:depend/depend.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/events/dependency/ievent_dependency.dart';
import 'package:dvizh_mob/src/events/repositories/ievent_repository.dart';
import 'package:dvizh_mob/src/events/repositories/mock_event_repository.dart';

class MockEventDependency extends DependencyContainer<RootLibrary>
    implements IEventDependency {
  MockEventDependency({required super.parent});

  @override
  Future<void> init() async {
    eventRepository = MockEventRepository();
  }

  @override
  late IEventRepository eventRepository;
}
