import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:void_chat_beta/new_signup/bloc/sign_up_form_bloc.dart';
import 'package:void_chat_beta/signup/widgets/form_header_signup.dart';


  FormBlocStep signUpStepZero(SignUpFormBloc signUpFormBloc) {
    return FormBlocStep(
      state: StepState.disabled,
          title: Text(''),
          content: Column(
            mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.lightGreen,
          // padding: EdgeInsets.symmetric(
          //     horizontal: 12, vertical: 20,),
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
            ],
          ),
            ),
          ],
                      ),
    );
  }
