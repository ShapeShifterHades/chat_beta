import 'package:get/get.dart';

class LoginPageTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'login_form': 'LOGIN FORM',
          'switch_to_registration': 'SWITCH TO REGISTRATION',
          'failure': 'FAILURE',
          'submit': 'SUBMIT',
          'connecting': 'CONNECTING...',
          'email': 'Email',
          'password': 'Password',
          'invalid.email': 'Invalid email',
          'invalid.password': 'Invalid password',
        },
        'ru_RU': {
          'login_form': 'АВТОРИЗАЦИЯ',
          'switch_to_registration': 'ПЕРЕЙТИ К РЕГИСТРАЦИИ',
          'failure': 'ОШИБКА',
          'submit': 'ОТПРАВИТЬ',
          'connecting': 'СОЕДИНЕНИЕ',
          'email': 'Почта',
          'password': 'Пароль',
          'invalid.email': 'Неверно введена почта',
          'invalid.password': 'Неверно введен пароль',
        }
      };
}
