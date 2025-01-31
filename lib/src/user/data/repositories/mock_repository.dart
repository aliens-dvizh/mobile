// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:dvizh_mob/src/user/data/repositories/iuser_repository.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';
import 'package:dvizh_mob/src/user/params/update_params.dart';

final UserModel _user =
    UserModel(id: 1, name: 'Name', createdAt: DateTime.now());

class MockUserRepository extends IUserRepository {
  MockUserRepository() : _userController = StreamController.broadcast();

  final StreamController<UserModel> _userController;

  @override
  Future<UserModel> get() async => _user;

  @override
  Stream<UserModel> get stream => _userController.stream;

  @override
  Future<void> update(UpdateUserParams params) async {
    _userController.add(_user.copyWith(name: params.name));
  }
}
