// 📦 Package imports:
import 'package:depend/depend.dart';
import 'package:dvizh_mob/src/auth/data/repositories/iauth_repository.dart';
import 'package:dvizh_mob/src/category/data/icategory_repository.dart';
import 'package:dvizh_mob/src/city/data/icategory_repository.dart';
import 'package:dvizh_mob/src/current_location/data/repositories/current_location_repository.dart';
import 'package:dvizh_mob/src/events/repositories/ievent_repository.dart';
import 'package:dvizh_mob/src/user/data/repositories/iuser_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
    required this.authRepository,
    required this.userRepository,
    required this.eventRepository,
    required this.categoryRepository,
    required this.cityRepository,
    required this.currentLocationRepository,
    required this.supabaseClient,
  });

  final Talker talker;
  final DioService dioService;
  final AppSettings settings;
  final FlutterSecureStorage secureStorage;
  final SupabaseClient supabaseClient;

  // Repositories
  final IAuthRepository authRepository;
  final IUserRepository userRepository;
  final IEventRepository eventRepository;
  final ICategoryRepository categoryRepository;
  final ICityRepository cityRepository;
  final ICurrentLocationRepository currentLocationRepository;
}
