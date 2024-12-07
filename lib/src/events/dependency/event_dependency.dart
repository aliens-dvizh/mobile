// 📦 Package imports:
import 'package:depend/depend.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/events/repositories/ievent_repository.dart';

class EventDependency extends DependencyContainer {
  EventDependency({required this.eventRepository});

  final IEventRepository eventRepository;
}
