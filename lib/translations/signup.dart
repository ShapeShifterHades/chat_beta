import 'package:get/get.dart';

class SignupTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'i_agree': 'I agree with Terms and Conditions',
          'registration': 'REGISTRATION',
          'switch_to_login': 'SWITCH TO SIGNIN',
          'failure': 'FAILURE',
          'submit': 'SUBMIT',
          'connecting': 'CONNECTING...',
          'email': 'Email',
          'username': 'Username',
          'password': 'Password',
          'confirm_password': 'Confirm password',
          'invalid_confirm_password': 'Passwords do not match',
          'invalid_username': 'Invalid username',
          'invalid_email': 'Invalid email',
          'invalid_password': 'Invalid password',
        },
        'ru_RU': {
          'i_agree': 'Я согласен с условиями предоставления услуг',
          'registration': 'РЕГИСТРАЦИЯ',
          'switch_to_login': 'ПЕРЕЙТИ К АВТОРИЗАЦИИ',
          'failure': 'ОШИБКА',
          'submit': 'ОТПРАВИТЬ',
          'connecting': 'СОЕДИНЕНИЕ',
          'email': 'Почта',
          'username': 'Имя пользователя',
          'password': 'Пароль',
          'confirm_password': 'Подтвердите пароль',
          'invalid_confirm_password': 'Введенные пароли не совпадают',
          'invalid_username': 'Некорректное имя пользователя',
          'invalid_email': 'Неверно введена почта',
          'invalid_password': 'Некорректно введен пароль',
        }
      };
}
