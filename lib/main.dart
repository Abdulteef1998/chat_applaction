import 'package:chatapplaction/firebase_options.dart';
import 'package:chatapplaction/pages/blocs/auth_bloc/auth_bloc.dart';
import 'package:chatapplaction/pages/chat_page.dart';

import 'package:chatapplaction/pages/cubits/chat_cubit.dart';
import 'package:chatapplaction/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/cubits/auth/auth_cubit.dart';
import 'pages/login_page.dart';
import 'pages/registeer_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  BlocOverrides.runZoned(
    () {
      runApp(ScholarChat());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => AuthBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage()
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}
