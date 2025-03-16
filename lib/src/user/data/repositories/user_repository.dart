// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:dvizh_mob/src/user/data/repositories/iuser_repository.dart';
import 'package:dvizh_mob/src/user/data/source/user_data_source.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';
import 'package:dvizh_mob/src/user/params/update_params.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository extends IUserRepository {
  UserRepository({
    required UserDataSource dataSource,
    required SupabaseClient client,
  })  : _client = client,
        // _dataSource = dataSource,
        _userController = StreamController<UserModel>.broadcast();

  // final UserDataSource _dataSource;
  final StreamController<UserModel> _userController;
  final SupabaseClient _client;

  @override
  Stream<UserModel> get stream => _userController.stream;

  @override
  Future<UserModel> get() async {
    final currentUser = _client.auth.currentUser;
    return UserModel(
      id: currentUser?.id ?? '',
      name: currentUser!.userMetadata?['name'] as String? ?? '',
      createdAt: DateTime.parse(currentUser.createdAt),
    );
  }

  @override
  Future<void> update(UpdateUserParams params) async {
    final response = await _client.auth.updateUser(UserAttributes(
      data: {
        'name': params.name,
      },
    ));
    final user = UserModel(
      id: response.user!.id,
      name: response.user?.userMetadata?['name'] as String? ?? '',
      createdAt: DateTime.parse(response.user!.createdAt),
    );
    _userController.add(user);
  }
}
