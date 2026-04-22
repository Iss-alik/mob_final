import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/core/theme/spacing.dart';
import 'package:mob_final/core/theme/textStyles.dart';
import 'package:mob_final/moduels/auth/bloc/authBloc.dart';
import 'package:mob_final/moduels/auth/bloc/authState.dart';
import 'package:mob_final/moduels/auth/bloc/authEvent.dart';
import 'package:mob_final/core/widgets/inputField.dart';
import 'package:mob_final/moduels/auth/screens/registrationScreen.dart';
import 'package:mob_final/services/validation.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage>{

  String? email;
  String? password;  

  final _formKey = GlobalKey<FormState>();
  final password_controller = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _logInFocus = FocusNode();

  
  @override
  void dispose() {
    password_controller.dispose();
    _emailFocus.dispose();
    _logInFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  { 
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is AuthFailure)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error))
          );
        }
      },

      child: Scaffold(
      body: Form(
        key: _formKey, 
        child: Column(
          children: [

            SizedBox(height: AppSpacing.m),

            Padding(
              padding: EdgeInsets.all(AppSpacing.s),
              child: Center(
                  child: Text(context.tr("log in"), style: AppTextStyles.title)
                ),
            ),
          
            InputField(
            validationFuncs: [Validators.notEmpty, Validators.email], 
            label: "Email", 
            icon: Icons.email, 
            onSaved: (value) => email = value,
            focusNode: _emailFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_passwordFocus),
            ),

            InputField(
            validationFuncs: [Validators.notEmpty, Validators.minLength], 
            label: context.tr("password"), 
            icon: Icons.shield, 
            onSaved: (value) => password = value,
            isPassword: true,
            controller: password_controller,
            focusNode: _passwordFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_logInFocus),
            ),

            ElevatedButton(
              focusNode: _logInFocus,
              style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              onPressed: (){
                if (_formKey.currentState!.validate()) 
                {
                  _formKey.currentState!.save(); 

                  context.read<AuthBloc>().add(
                    LogInEvent(
                      email: email!,
                      password: password!,
                    ),
                  );
                }
              }, 
              child: Text(context.tr("log in"))
            ),

            SizedBox(height: AppSpacing.s),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage() )
                );
              },
              child: Text(
                context.tr("no account"),
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 12
                ),
              ),
            )
          ],
        ),
        
      )
    )
    );
    
  }
}