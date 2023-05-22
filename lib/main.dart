import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/controller/cubit/app_cubit/app_cubit.dart';
import 'package:voting_app/controller/cubit/login_cubit/login_cubit.dart';
import 'package:voting_app/controller/cubit/register_cubit/register_cubit.dart';
import 'package:voting_app/controller/observer.dart';
import 'package:voting_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:voting_app/screens/home_layout_screen.dart';
import 'package:voting_app/screens/register_screen.dart';
import 'package:voting_app/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..getDataFromDB(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0)),
              ),
              centerTitle: true),
          primarySwatch: Colors.purple,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
