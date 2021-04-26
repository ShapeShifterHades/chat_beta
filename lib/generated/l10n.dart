// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `LOGIN FORM`
  String get loginpage_login_form {
    return Intl.message(
      'LOGIN FORM',
      name: 'loginpage_login_form',
      desc: '',
      args: [],
    );
  }

  /// `SWITCH TO REGISTRATION`
  String get loginpage_switch_to_registration {
    return Intl.message(
      'SWITCH TO REGISTRATION',
      name: 'loginpage_switch_to_registration',
      desc: '',
      args: [],
    );
  }

  /// `FAILURE`
  String get loginpage_failure {
    return Intl.message(
      'FAILURE',
      name: 'loginpage_failure',
      desc: '',
      args: [],
    );
  }

  /// `SUBMIT`
  String get loginpage_submit {
    return Intl.message(
      'SUBMIT',
      name: 'loginpage_submit',
      desc: '',
      args: [],
    );
  }

  /// `CONNECTING...`
  String get loginpage_connecting {
    return Intl.message(
      'CONNECTING...',
      name: 'loginpage_connecting',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get loginpage_email {
    return Intl.message(
      'Email',
      name: 'loginpage_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginpage_password {
    return Intl.message(
      'Password',
      name: 'loginpage_password',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get loginpage_invalid_email {
    return Intl.message(
      'Invalid email',
      name: 'loginpage_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password`
  String get loginpage_invalid_password {
    return Intl.message(
      'Invalid password',
      name: 'loginpage_invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `LOGIN WITH GOOGLE`
  String get loginpage_login_with_google {
    return Intl.message(
      'LOGIN WITH GOOGLE',
      name: 'loginpage_login_with_google',
      desc: '',
      args: [],
    );
  }

  /// `I agree with `
  String get signup_i_agree {
    return Intl.message(
      'I agree with ',
      name: 'signup_i_agree',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get signup_with_terms {
    return Intl.message(
      'Terms and Conditions',
      name: 'signup_with_terms',
      desc: '',
      args: [],
    );
  }

  /// `REGISTRATION`
  String get signup_registration {
    return Intl.message(
      'REGISTRATION',
      name: 'signup_registration',
      desc: '',
      args: [],
    );
  }

  /// `SWITCH TO LOGIN`
  String get signup_switch_to_login {
    return Intl.message(
      'SWITCH TO LOGIN',
      name: 'signup_switch_to_login',
      desc: '',
      args: [],
    );
  }

  /// `FAILURE`
  String get signup_failure {
    return Intl.message(
      'FAILURE',
      name: 'signup_failure',
      desc: '',
      args: [],
    );
  }

  /// `SUBMIT`
  String get signup_submit {
    return Intl.message(
      'SUBMIT',
      name: 'signup_submit',
      desc: '',
      args: [],
    );
  }

  /// `CONNECTING...`
  String get signup_connecting {
    return Intl.message(
      'CONNECTING...',
      name: 'signup_connecting',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get signup_email {
    return Intl.message(
      'Email',
      name: 'signup_email',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get signup_username {
    return Intl.message(
      'Username',
      name: 'signup_username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get signup_password {
    return Intl.message(
      'Password',
      name: 'signup_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get signup_confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'signup_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get signup_invalid_confirm_password {
    return Intl.message(
      'Passwords do not match',
      name: 'signup_invalid_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Invalid username`
  String get signup_invalid_username {
    return Intl.message(
      'Invalid username',
      name: 'signup_invalid_username',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get signup_invalid_email {
    return Intl.message(
      'Invalid email',
      name: 'signup_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password`
  String get signup_invalid_password {
    return Intl.message(
      'Invalid password',
      name: 'signup_invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get signup_or {
    return Intl.message(
      'OR',
      name: 'signup_or',
      desc: '',
      args: [],
    );
  }

  /// `SIGNUP WITH GOOGLE AUTH`
  String get signup_with_google {
    return Intl.message(
      'SIGNUP WITH GOOGLE AUTH',
      name: 'signup_with_google',
      desc: '',
      args: [],
    );
  }

  /// `This user already exist`
  String get signup_this_user_taken {
    return Intl.message(
      'This user already exist',
      name: 'signup_this_user_taken',
      desc: '',
      args: [],
    );
  }

  /// `   Check to continue`
  String get signup_agree {
    return Intl.message(
      '   Check to continue',
      name: 'signup_agree',
      desc: '',
      args: [],
    );
  }

  /// `Night mode`
  String get signup_brightness {
    return Intl.message(
      'Night mode',
      name: 'signup_brightness',
      desc: '',
      args: [],
    );
  }

  /// `Locale`
  String get signup_locale {
    return Intl.message(
      'Locale',
      name: 'signup_locale',
      desc: '',
      args: [],
    );
  }

  /// `search user`
  String get contacts_search_username {
    return Intl.message(
      'search user',
      name: 'contacts_search_username',
      desc: '',
      args: [],
    );
  }

  /// `Friends`
  String get contacts_friends {
    return Intl.message(
      'Friends',
      name: 'contacts_friends',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get contacts_pending {
    return Intl.message(
      'Requests',
      name: 'contacts_pending',
      desc: '',
      args: [],
    );
  }

  /// `Blocked`
  String get contacts_blocked {
    return Intl.message(
      'Blocked',
      name: 'contacts_blocked',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get contacts_loading {
    return Intl.message(
      'Loading...',
      name: 'contacts_loading',
      desc: '',
      args: [],
    );
  }

  /// `More info`
  String get contacts_more_info {
    return Intl.message(
      'More info',
      name: 'contacts_more_info',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get contacts_cancel {
    return Intl.message(
      'Cancel',
      name: 'contacts_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get contacts_reject {
    return Intl.message(
      'Reject',
      name: 'contacts_reject',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get contacts_accept {
    return Intl.message(
      'Accept',
      name: 'contacts_accept',
      desc: '',
      args: [],
    );
  }

  /// `Username: `
  String get contacts_user {
    return Intl.message(
      'Username: ',
      name: 'contacts_user',
      desc: '',
      args: [],
    );
  }

  /// `Id: `
  String get contacts_id {
    return Intl.message(
      'Id: ',
      name: 'contacts_id',
      desc: '',
      args: [],
    );
  }

  /// `Sent at: `
  String get contacts_sent_at {
    return Intl.message(
      'Sent at: ',
      name: 'contacts_sent_at',
      desc: '',
      args: [],
    );
  }

  /// `Status: `
  String get contacts_status {
    return Intl.message(
      'Status: ',
      name: 'contacts_status',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get contacts_form_message {
    return Intl.message(
      'Message',
      name: 'contacts_form_message',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get contacts_form_remove {
    return Intl.message(
      'Remove',
      name: 'contacts_form_remove',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get drawer_messages {
    return Intl.message(
      'Messages',
      name: 'drawer_messages',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get drawer_contacts {
    return Intl.message(
      'Contacts',
      name: 'drawer_contacts',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get drawer_settings {
    return Intl.message(
      'Settings',
      name: 'drawer_settings',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get drawer_security {
    return Intl.message(
      'Security',
      name: 'drawer_security',
      desc: '',
      args: [],
    );
  }

  /// `Faq`
  String get drawer_faq {
    return Intl.message(
      'Faq',
      name: 'drawer_faq',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get drawer_logout {
    return Intl.message(
      'Logout',
      name: 'drawer_logout',
      desc: '',
      args: [],
    );
  }

  /// `YorKee - keep the choice to yourself.`
  String get drawer_slogan {
    return Intl.message(
      'YorKee - keep the choice to yourself.',
      name: 'drawer_slogan',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'ru', countryCode: 'RU'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}