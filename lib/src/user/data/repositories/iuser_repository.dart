// 🌎 Project imports:
import 'package:dvizh_mob/src/core/models/repository/repository.dart';
import 'package:dvizh_mob/src/user/models/user_model.dart';

abstract class IUserRepository extends IRepository {
  Stream<UserModel> get stream;

  Future<UserModel> get();
  Future<void> update();
}
