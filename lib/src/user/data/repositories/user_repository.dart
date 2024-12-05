// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:dvizh_mob/src/user/data/repositories/iuser_repository.dart';
import 'package:dvizh_mob/src/user/data/source/user_data_source.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';

class UserRepository extends IUserRepository {
  UserRepository({
    required UserDataSource dataSource,
  })  : _dataSource = dataSource,
        _userController = StreamController<UserModel>.broadcast();

  final UserDataSource _dataSource;
  final StreamController<UserModel> _userController;

  @override
  Stream<UserModel> get stream => _userController.stream;

  @override
  Future<UserModel> get() => _dataSource.get().then((value) => value.toModel());

  @override
  Future<void> update() async {
    final user = await get();
    _userController.add(user);
  }
}
