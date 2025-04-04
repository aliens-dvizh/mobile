// 📦 Package imports:
import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/auth/data/export.dart';
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/auth/data/repositories/mock_auth_repository.dart';
import 'package:dvizh_mob/src/auth/data/repositories/supabase_auth_repository.dart';
import 'package:dvizh_mob/src/category/data/category_data_source.dart';
import 'package:dvizh_mob/src/category/data/category_repository.dart';
import 'package:dvizh_mob/src/category/data/mock_category_repository.dart';
import 'package:dvizh_mob/src/city/data/category_data_source.dart';
import 'package:dvizh_mob/src/city/data/category_repository.dart';
import 'package:dvizh_mob/src/city/data/mock_category_repository.dart';
import 'package:dvizh_mob/src/current_location/data/repositories/current_location_repository.dart';
import 'package:dvizh_mob/src/current_location/domain/repositories/current_location_repository.dart';
import 'package:dvizh_mob/src/current_location/domain/repositories/mock_current_location_repository.dart';
import 'package:dvizh_mob/src/events/export.dart';
import 'package:dvizh_mob/src/events/repositories/mock_event_repository.dart';
import 'package:dvizh_mob/src/user/data/repositories/iuser_repository.dart';
import 'package:dvizh_mob/src/user/data/repositories/mock_repository.dart';
import 'package:dvizh_mob/src/user/data/repositories/user_repository.dart';
import 'package:dvizh_mob/src/user/data/source/user_data_source.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

// 🌎 Project imports:
import 'package:dvizh_mob/src/core/app_settings.dart';
import 'package:dvizh_mob/src/core/dependency/root_dependency_container.dart';
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';

class RootDependencyFactory extends DependencyFactory<RootDependencyContainer> {
  RootDependencyFactory({required this.talker});

  final Talker talker;

  @override
  RootDependencyContainer create() {
    final settings = AppSettings(useMocks: false);
    const secureStorage = FlutterSecureStorage();
    final dioService = DioService.initialize(
      'http://localhost',
    )..addInterceptor(
        TalkerDioLogger(
          talker: talker,
          settings: const TalkerDioLoggerSettings(),
        ),
      );
    final supabase = Supabase.instance.client;

    final authRepository = settings.useMocks
        ? MockAuthRepository(
            TokenDataSource(
              secureStorage,
            ),
          )
        : SupabaseAuthRepository(
            TokenDataSource(
              secureStorage,
            ),
            AuthInterceptorDataSource(
              dioService,
            ),
            supabase);
    final userRepository = settings.useMocks
        ? MockUserRepository()
        : UserRepository(
            dataSource: UserDataSource(
              dioService: dioService,
            ),
            client: supabase,
          );

    final eventRepository = settings.useMocks
        ? MockEventRepository()
        : EventRepository(
            EventDataSource(
              dioService,
              supabase,
            ),
          );

    final categoryRepository = settings.useMocks
        ? MockCategoryRepository()
        : CategoryRepository(
            CategoryDataSource(
              dioService,
              supabase,
            ),
          );

    final cityRepository = settings.useMocks
        ? MockCityRepository()
        : CityRepository(
            CityDataSource(dioService, supabase),
          );

    final currentLocationRepository = false
        ? MockCurrentLocationRepository()
        : CurrentLocationRepository(secureStorage: secureStorage);

    return RootDependencyContainer(
      dioService: dioService,
      talker: talker,
      settings: settings,
      secureStorage: secureStorage,
      authRepository: authRepository,
      userRepository: userRepository,
      eventRepository: eventRepository,
      categoryRepository: categoryRepository,
      cityRepository: cityRepository,
      currentLocationRepository: currentLocationRepository,
      supabaseClient: Supabase.instance.client,
    );
  }
}
