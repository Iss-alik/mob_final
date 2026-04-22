import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/core/theme/theme.dart';
import 'package:mob_final/mainScreen.dart';
import 'package:mob_final/moduels/auth/bloc/authBloc.dart';
import 'package:mob_final/moduels/auth/bloc/authEvent.dart';
import 'package:mob_final/moduels/auth/bloc/authState.dart';
import 'package:mob_final/moduels/auth/screens/authSreenc.dart';
import 'package:mob_final/moduels/navigation/bloc/navigationBloc.dart';
import 'package:mob_final/moduels/navigation/bloc/navigationEvent.dart';
import 'package:mob_final/moduels/news/bloc/newsBloc.dart';
import 'package:mob_final/moduels/news/bloc/newsEvents.dart';
import 'package:mob_final/moduels/post/bloc/postBloc.dart';
import 'package:mob_final/moduels/post/bloc/postEvent.dart';
import 'package:mob_final/moduels/profile/bloc/profileBloc.dart';
import 'package:mob_final/moduels/profile/bloc/profileState.dart';

import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru'), Locale('kk')],
      path: 'assets/languages', // <-- change the path of the translation files 
      fallbackLocale: Locale('en'),
      child: MyApp()
    ),
  );
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
        BlocProvider<PostBloc>(
          create: (_) => PostBloc()..add(LoadPostEvent()),
        ),
        BlocProvider<NavigationBloc>(
          create: (_) => NavigationBloc()..add(ChangePageEvent(0)),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(),
        ),
        BlocProvider<NewsBloc>(
          create: (_) => NewsBloc()..add(LoadNewsEvent()),
        ),
      ],

      child: Builder(
        builder: (context) {
          return MaterialApp(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,

            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,

            themeMode: context.select(
              (ProfileBloc bloc) => bloc.state.isDark
            )
                ? ThemeMode.dark
                : ThemeMode.light,

            home: MyHomePage(),
          );
        },
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
          return MainPage();
        }
        else
        {
          return LogInPage();
        }
      } 
    );
  }
}

