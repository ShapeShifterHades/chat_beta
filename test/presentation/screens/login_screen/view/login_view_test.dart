import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:void_chat_beta/core/themes/app_theme.dart';

import 'package:void_chat_beta/logic/cubit/brightness/brightness.dart';
import 'package:void_chat_beta/logic/cubit/login/login_cubit.dart';

import 'package:void_chat_beta/presentation/screens/login_screen/login_view.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockLoginCubit extends Mock implements LoginCubit {}

class MockAppTheme extends Mock implements AppTheme {}

class MockBrightnessCubit extends Mock implements BrightnessCubit {}

void main() {
  group('LoginView', () {
    test('has a page', () {
      expect(MaterialPageRoute<dynamic>(builder: (ctx) => const LoginView()),
          isA<MaterialPageRoute<dynamic>>());
    });
    // testWidgets('renders a LoginForm', (tester) async {
    //   await tester.pumpWidget(
    //     RepositoryProvider<BrightnessCubit>(
    //       create: (_) => MockBrightnessCubit(),
    //       child: RepositoryProvider<AuthenticationRepository>(
    //           create: (_) => MockAuthenticationRepository(),
    //           child: BlocProvider<MockLoginCubit>(
    //             create: (context) => MockLoginCubit(context.read<MockAuthenticationRepository?>()),
    //             child: const LoginMainFormFrame(),
    //           )),
    //     ),
    //   );
    //   const loginFormFrameKey = ValueKey('login_main_form_frame');
    //   expect(find.byKey(loginFormFrameKey), findsOneWidget);
    // });
  });
}
