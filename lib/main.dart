import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/core/theme/theme.dart';
import 'package:mob_final/moduels/auth/bloc/authBloc.dart';
import 'package:mob_final/moduels/auth/bloc/authEvent.dart';
import 'package:mob_final/moduels/auth/bloc/authState.dart';
import 'package:mob_final/moduels/auth/screens/authSreenc.dart';
import 'package:mob_final/moduels/auth/screens/registrationScreen.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc()..add(AuthCheckEvent()),
        ),
      ],
      child: MaterialApp(
        home: MyHomePage(),
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context){
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state){
        if(state is AuthLoggedIn)
        { 
          // Заглушка
          return RegistrationPage();
        }
        else
        {
          return LogInPage();
        }
      } 
    );
  }
}

