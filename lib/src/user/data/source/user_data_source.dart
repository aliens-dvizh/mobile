// 🌎 Project imports:
import 'package:dvizh_mob/src/core/services/dio/dio_service.dart';
import 'package:dvizh_mob/src/user/models/user_dto.dart';

class UserDataSource {
  UserDataSource({
    required DioService dioService,
  }) : _dioService = dioService;

  final DioService _dioService;

  Future<UserDTO> get() => _dioService.I
      .get<Map<String, Object?>>('auth/user-info')
      .then((value) => UserDTO.fromJson(value.data as Map<String, Object?>));
}
