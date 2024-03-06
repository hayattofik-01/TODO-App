import 'package:todo_app/app/data/provider/appwrite_provider.dart';
import 'package:appwrite/models.dart' as models;

class AuthRepository{
  final AppWriteProvider appWriteProvider;
  AuthRepository(this.appWriteProvider);

  Future<models.User> signup(Map map) => appWriteProvider.signup(map);
  Future<models.Session> login(Map map) => appWriteProvider.login(map);


}