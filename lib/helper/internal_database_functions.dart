import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  String sharedPreferenceUserLoggedInKey = 'ISLOGGED';
  String sharedPreferenceUserNameKey = 'USERNAMEKEY';
  String sharedPreferenceUserEmailKey = 'USEREMAILKEY';

  // saving data to shared_preference
  Future<bool> saveThatUserIsLoggedIn(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  Future<bool> saveUsersName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName);
  }

  Future<bool> saveUsersEmail(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  // getting the data from the shared_preference

  Future<bool> getUsersLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  Future<String> getUsersName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserNameKey);
  }

  Future<String> getUsersEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserEmailKey);
  }
}
