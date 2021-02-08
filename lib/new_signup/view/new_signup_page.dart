import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:void_chat_beta/new_signup/bloc/sign_up_form_bloc.dart';
import 'package:void_chat_beta/signup/widgets/form_header_signup.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:void_chat_beta/widgets/auth_custom_frame/custom_clip_path.dart';
import 'package:void_chat_beta/widgets/auth_custom_frame/custom_painter_for_clipper.dart';



class TestLoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    

    MultiBlocProvider(
    providers:[
    BlocProvider<SignUpFormBloc>(
        create: (context) => SignUpFormBloc(
              context.read<AuthenticationRepository>(),
              context.read<FirestoreNewUserRepository>(),
              ),
              ),
    ],



        child: Builder(builder: (context) {
          // ignore: close_sinks
          final loginFormBloc = context.watch<SignUpFormBloc>();

          return SignUpPage(loginFormBloc: loginFormBloc);
        }));
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({
    Key key,
    @required this.loginFormBloc,
  }) : super(key: key);

  final SignUpFormBloc loginFormBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        body: FormBlocListener<SignUpFormBloc, String, String>(
          onSubmitting: (context, state) {
           
          },
          onSuccess: (context, state) {



          },
          onFailure: (context, state) {
            

            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text(state.failureResponse)));
          },
          child: Align(
            alignment: Alignment.center,
                            child: Container(
                    margin: EdgeInsets.only(top: 40),
                    width: Get.size.width*0.95,
                    // height: double.infinity,
        child: CustomPaint(
            painter: CustomPainterForClipper(
            color: Theme.of(context).primaryColor,
            ),
            child: ClipPath(
            clipper: CustomClipPath(),
            // Implementation of stepper widget.
            child: Column(
                  mainAxisSize: MainAxisSize.min,
                children: [
                  FormHeaderSignUp(
                color:  Colors.green,
                title: 'signup_registration'.tr,
                  ),
                  Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                  TextFieldBlocBuilder(
                  padding: EdgeInsets.all(2),
                  textFieldBloc: loginFormBloc.email,
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.jura(color: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              .color),
                  cursorColor: Theme.of(context).primaryColor,
                  cursorWidth: 0.5,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).primaryColor.withOpacity(0.08),
                    labelStyle: GoogleFonts.jura(color: Theme.of(context).primaryColor),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Theme.of(context).primaryColor.withOpacity(0.6),),
                  ),
                ),

                TextFieldBlocBuilder(
                  padding: EdgeInsets.all(2),
                  textFieldBloc: loginFormBloc.password,
                  suffixButton: SuffixButton.obscureText,
                                    style: GoogleFonts.jura(color: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              .color),
                  cursorColor: Theme.of(context).primaryColor,
                  cursorWidth: 0.5,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).primaryColor.withOpacity(0.08),
                    labelStyle: GoogleFonts.jura(color: Theme.of(context).primaryColor),
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor.withOpacity(0.6),),
                  ),
                ),

                TextFieldBlocBuilder(
                  padding: EdgeInsets.all(2),
                  isEnabled: true,
                  textFieldBloc: loginFormBloc.confirmPassword,
                  suffixButton: SuffixButton.obscureText,
                  cursorColor: Theme.of(context).primaryColor,
                  cursorWidth: 0.5,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).primaryColor.withOpacity(0.08),
                    labelStyle: GoogleFonts.jura(color: Theme.of(context).primaryColor),
                    labelText: 'Confirm password',
                    prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor.withOpacity(0.6),),
                  ),
                ),

                TextFieldBlocBuilder(
                  padding: EdgeInsets.only(top: 2, left: 2, right: 2, bottom: 2),
                  isEnabled: true,
                  textFieldBloc: loginFormBloc.username,
                  suffixButton: SuffixButton.asyncValidating,
                  cursorColor: Theme.of(context).primaryColor,
                  cursorWidth: 0.5,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).primaryColor.withOpacity(0.08),
                    labelStyle: GoogleFonts.jura(color: Theme.of(context).primaryColor),
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person_add, color: Theme.of(context).primaryColor.withOpacity(0.6),),
                  ),
                ),

                SizedBox(
                  child: CheckboxFieldBlocBuilder(
                    checkColor: Theme.of(context).primaryColor,
                    activeColor: Theme.of(context).backgroundColor ,
                    padding: EdgeInsets.all(2),

                    booleanFieldBloc: loginFormBloc.showAgreementCheckbox,
                    body: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text('I agree with', style: GoogleFonts.jura(fontWeight: FontWeight.w300, fontSize: 16),),
                          FlatButton(
                            padding: EdgeInsets.all(5),
                            onPressed: (){}, 
                            child: Text('license agreement', style: GoogleFonts.jura(
                                                                                      fontWeight: FontWeight.w300, 
                                                                                      fontSize: 16, 
                                                                                      color: Theme.of(context).primaryColor,
                                                                                    ),
                                      ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                //       RaisedButton(
                //   onPressed: loginFormBloc.submit,
                //   child: Text('LOGINs'),
                // ),  
                
                  ],
                ),
                  ),
                  Container(width: 500,
                  clipBehavior: Clip.none,
                  height: 30,
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 0.4)),
                        child: 
                      Text('SIGN UP', style: GoogleFonts.jura(color: Theme.of(context).backgroundColor),)),
                      MaterialButton(onPressed: (){}, 
                      
                      child: Text('SIGNUP'),),
                    ],
                    
                  ),
                  ),
                  Container(
                    height: 40,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Divider(color: Theme.of(context).primaryColor, thickness: 0.4, indent: 12, endIndent: 12,),),
                      Text('OR'),
                      Expanded(child: Divider(color: Theme.of(context).primaryColor, thickness: 0.4, indent: 12, endIndent: 12,)),
                    ],
                ),
                  ),
                  Container(width: 500,
                  clipBehavior: Clip.none,
                  height: 30,
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('SIGN UP WITH GOOGLE', style: GoogleFonts.jura(color: Theme.of(context).backgroundColor),),
                    ],
                  ),
                  ),
                ],
              ),
            ),
        ),
      ),
          ),
        ));
  }
}

class ShimmerTextSwitch extends StatelessWidget {
  const ShimmerTextSwitch({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
          baseColor: Theme.of(context)
              .inputDecorationTheme
              .enabledBorder
              .borderSide
              .color.withOpacity(0.35),
          highlightColor: Theme.of(context)
              .inputDecorationTheme
              .enabledBorder
              .borderSide
              .color.withOpacity(1),
          loop: 0,
          period: Duration(milliseconds: 2500),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
    'Switch to Login',
    style: TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 18,
    ),
              ),
              SizedBox(width: 10),
              Transform.translate(
    offset: Offset(0.0, 1.5),
    child: Transform(
      transform: Matrix4.diagonal3Values(1, 0.85, 1.2),
      child: Icon(
        Icons.double_arrow,
        color: Theme.of(context).primaryColor,
      ),
    ),
              ),
            ],
          ),
        );
  }
}


class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      tileMode: TileMode.mirror,
      begin: Alignment.topRight,
      end: Alignment.bottomRight,
      colors: [
        Color(0xff000000),
        Color(0xff20649b),
      ],
      stops: [
        0,
        1,
      ],
    ),
    backgroundBlendMode: BlendMode.plus,
  ),
  child: PlasmaRenderer(
    type: PlasmaType.infinity,
    particles: 10,
    color: Color(0x440fbcdf),
    blur: 0.4,
    size: 1,
    speed: 1,
    offset: 0,
    blendMode: BlendMode.screen,
    variation1: 0,
    variation2: 0,
    variation3: 0,
    rotation: 0,
  ),
);
 
  }
}
