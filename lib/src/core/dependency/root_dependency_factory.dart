// 📦 Package imports:
import 'package:depend/depend.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/app_settings.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';

class RootDependencyFactory extends DependencyFactory<RootDependencyContainer> {
  @override
  Future<RootDependencyContainer> create() async {
    final talker = Talker();
    return RootDependencyContainer(
      dioService: DioService.initialize(
        'http://localhost',
      )..addInterceptor(
          TalkerDioLogger(
            talker: talker,
            settings: const TalkerDioLoggerSettings(),
          ),
        ),
      talker: talker,
      settings: AppSettings(useMocks: true),
      secureStorage: const FlutterSecureStorage(),
    );
  }
}
