import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:void_chat_beta/new_signup/bloc/sign_up_form_bloc.dart';
import 'package:void_chat_beta/signup/widgets/form_header_signup.dart';


  FormBlocStep signUpStepOne(SignUpFormBloc signUpFormBloc) {
    return FormBlocStep(
          title: Text(''),
          content: Column(
                        mainAxisSize: MainAxisSize.min,
                      children: [
                        FormHeaderSignUp(
                      color:  Colors.green,
                      title: 'signup_registration'.tr,
                        ),
                        Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFieldBlocBuilder(
                        cursorColor: Colors.white,
                        cursorWidth: 0.5,
                        textFieldBloc: signUpFormBloc.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: signUpFormBloc.password,
                        suffixButton: SuffixButton.obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      TextFieldBlocBuilder(
                        isEnabled: true,
                        textFieldBloc: signUpFormBloc.confirmPassword,
                        suffixButton: SuffixButton.obscureText,
                        decoration: InputDecoration(
                          labelText: 'Confirm password',
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: CheckboxFieldBlocBuilder(
                          booleanFieldBloc: signUpFormBloc.showSuccessResponse,
                          body: Container(
                            alignment: Alignment.centerLeft,
                            child: Text('Show success response'),
                          ),
                        ),
                      ),
                            RaisedButton(
                        onPressed: signUpFormBloc.submit,
                        child: Text('LOGINs'),
                      ),  // Here comes forms
                        ],
                      ),
                        ),
                      ],
                    ),
    );
  }
