import 'package:get/get.dart';

class ContentTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'US': {
          // LoginPage Translations: starts with loginpage_
          'loginpage_login_form': 'LOGIN FORM',
          'loginpage_switch_to_registration': 'SWITCH TO REGISTRATION',
          'loginpage_failure': 'FAILURE',
          'loginpage_submit': 'SUBMIT',
          'loginpage_connecting': 'CONNECTING...',
          'loginpage_email': 'Email',
          'loginpage_password': 'Password',
          'loginpage_invalid_email': 'Invalid email',
          'loginpage_invalid_password': 'Invalid password',
          // NewSignUp page translations: starts with signup_
          'signup_i_agree': 'I agree with ',
          'signup_with_terms': 'Terms and Conditions',
          'signup_registration': 'REGISTRATION',
          'signup_switch_to_login': 'SWITCH TO SIGNIN',
          'signup_failure': 'FAILURE',
          'signup_submit': 'SUBMIT',
          'signup_connecting': 'CONNECTING...',
          'signup_email': 'Email',
          'signup_username': 'Username',
          'signup_password': 'Password',
          'signup_confirm_password': 'Confirm password',
          'signup_invalid_confirm_password': 'Passwords do not match',
          'signup_invalid_username': 'Invalid username',
          'signup_invalid_email': 'Invalid email',
          'signup_invalid_password': 'Invalid password',
          'signup_or': 'OR',
          'signup_with_google': 'SIGNUP WITH GOOGLE AUTH',
          'signup_this_user_taken': 'This user already exist',
          'signup_agree': '   Check to continue'
        },
        'RU': {
          // LoginPage Translations: starts with loginpage_
          'loginpage_login_form': 'АВТОРИЗАЦИЯ',
          'loginpage_switch_to_registration': 'ПЕРЕЙТИ К РЕГИСТРАЦИИ',
          'loginpage_failure': 'ОШИБКА',
          'loginpage_submit': 'ОТПРАВИТЬ',
          'loginpage_connecting': 'СОЕДИНЕНИЕ',
          'loginpage_email': 'Почта',
          'loginpage_password': 'Пароль',
          'loginpage_invalid_email': 'Неверно введена почта',
          'loginpage_invalid_password': 'Неверно введен пароль',
          // SignUp page translations: starts with signup_
          'signup_i_agree': 'Я согласен c',
          'signup_with_terms': 'Соглашением',
          'signup_registration': 'РЕГИСТРАЦИЯ',
          'signup_switch_to_login': 'ПЕРЕЙТИ К АВТОРИЗАЦИИ',
          'signup_failure': 'ОШИБКА',
          'signup_submit': 'ОТПРАВИТЬ',
          'signup_connecting': 'СОЕДИНЕНИЕ',
          'signup_email': 'Почта',
          'signup_username': 'Имя пользователя',
          'signup_password': 'Пароль',
          'signup_confirm_password': 'Подтвердите пароль',
          'signup_invalid_confirm_password': 'Введенные пароли не совпадают',
          'signup_invalid_username': 'Некорректное имя пользователя',
          'signup_invalid_email': 'Неверно введена почта',
          'signup_invalid_password': 'Некорректно введен пароль',
          'signup_or': 'ИЛИ',
          'signup_with_google': 'РЕГЕСТРИРОВАТЬСЯ ЧЕРЕЗ GOOGLE AUTH',
          'signup_this_user_taken': 'Такой пользователь уже существует',
          'signup_agree': '   Необходимо согласие'
        }
      };
}
