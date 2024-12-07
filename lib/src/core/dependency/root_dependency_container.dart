// 📦 Package imports:
import 'package:depend/depend.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talker/talker.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/app_settings.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';

class RootDependencyContainer extends DependencyContainer {
  RootDependencyContainer({
    required this.dioService,
    required this.talker,
    required this.settings,
    required this.secureStorage,
  });

  final Talker talker;
  final DioService dioService;
  final AppSettings settings;
  final FlutterSecureStorage secureStorage;
}
