// 📦 Package imports:
import 'package:depend/depend.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/main.dart';
import 'package:dvizh_mob/src/events/repositories/ievent_repository.dart';

interface class IEventDependency extends DependencyContainer<RootLibrary> {
  late final IEventRepository eventRepository;

  @override
  Future<void> init() async {}
}
