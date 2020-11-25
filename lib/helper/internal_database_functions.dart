import 'package:shared_preferences/shared_preferences.dart';

class InternalDbFunctions {
  String isUserLoggedInKey = 'loggedin';
  String userNameKey = 'username';
  String userEmailKey = 'email';

  // saving data to shared_preference
  Future<bool> saveThatUserIsLoggedIn(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(isUserLoggedInKey, isUserLoggedIn);
  }

  Future<bool> saveUsersName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userNameKey, userName);
  }

  Future<bool> saveUsersEmail(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userEmailKey, userEmail);
  }

  // getting the data from the shared_preference

  Future<bool> getUsersLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isUserLoggedInKey);
  }

  Future<String> getUsersName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String> getUsersEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }
}
