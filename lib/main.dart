import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/moduels/auth/bloc/authBloc.dart';
import 'package:mob_final/moduels/auth/bloc/authState.dart';
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
    return MaterialApp(
      home: MultiBlocProvider(providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(), 
        ),
      ], 
      child: ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context){
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state){
        if(state is AuthLoggedIn)
        {
          
        }
        else if (state is AuthLoggedOut)
        {
          return null;
        }
      } 
    );
  }
}

