// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:dvizh_mob/src/user/data/user_data_source.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';

class UserRepository {
  UserRepository({
    required UserDataSource dataSource,
  }) : _dataSource = dataSource;

  final UserDataSource _dataSource;
  final StreamController<UserModel> _userController =
      StreamController<UserModel>.broadcast();

  Stream<UserModel> get stream => _userController.stream;

  Future<UserModel> get() => _dataSource.get().then((value) => value.toModel());

  Future<void> update() async {
    final user = await get();
    _userController.add(user);
  }
}
