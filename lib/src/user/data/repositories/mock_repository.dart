// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:dvizh_mob/src/user/data/repositories/iuser_repository.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';

final UserModel _user =
    UserModel(id: 1, name: 'Name', createdAt: DateTime.now());

class MockUserRepository extends IUserRepository {
  MockUserRepository() : _userController = StreamController();

  final StreamController<UserModel> _userController;

  @override
  Future<UserModel> get() async => _user;

  @override
  Stream<UserModel> get stream => _userController.stream;

  @override
  Future<void> update() async {
    final user = await get();
    _userController.add(user);
  }
}
