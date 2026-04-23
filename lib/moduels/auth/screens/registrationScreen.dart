import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/core/theme/spacing.dart';
import 'package:mob_final/core/theme/textStyles.dart';
import 'package:mob_final/moduels/auth/bloc/authBloc.dart';
import 'package:mob_final/moduels/auth/bloc/authState.dart';
import 'package:mob_final/moduels/auth/bloc/authEvent.dart';
import 'package:mob_final/core/widgets/inputField.dart';
import 'package:mob_final/moduels/auth/screens/authSreenc.dart';
import 'package:mob_final/services/validation.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>{

  String? name;
  String? email;
  String? password;  

  final _formKey = GlobalKey<FormState>();
  final password_controller = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _passwordConfirmFocus = FocusNode();
  final _nameFocus = FocusNode();

  String? password_match(String? value)
  {
    if(value != null && value != password_controller.text)
    {  return context.tr("password not same");}
    
    return null;
  }

  @override
  void dispose() {
    password_controller.dispose();
    _emailFocus.dispose();
    _passwordConfirmFocus.dispose();
    _passwordFocus.dispose();
    _nameFocus.dispose();
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
            Padding(
              padding: EdgeInsets.all(AppSpacing.s),
              child: Center(
                  child: Text(context.tr("register"), style: AppTextStyles.title)
                ),
            ),

            InputField(validationFuncs: [Validators.notEmpty],
            label: context.tr("name"),
            icon: Icons.person,
            onSaved: (value) => name = value,
            focusNode: _nameFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_emailFocus),
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
            validationFuncs: [Validators.notEmpty, Validators.validatePassword], 
            label: context.tr("password"), 
            icon: Icons.shield, 
            onSaved: (value) => password = value,
            isPassword: true,
            controller: password_controller,
            focusNode: _passwordFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_passwordConfirmFocus),
            ),

            InputField(
            validationFuncs: [Validators.notEmpty, password_match], 
            label: context.tr("password2"), 
            icon: Icons.draw,
            isPassword: true,
            focusNode: _passwordConfirmFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_nameFocus),
            ),

            SizedBox(height: AppSpacing.s),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).cardColor,
                  foregroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              onPressed: (){
                if (_formKey.currentState!.validate()) 
                {
                  _formKey.currentState!.save(); 

                  context.read<AuthBloc>().add(
                  RegisterEvent(
                    name: name!,
                    email: email!,
                    password: password!,
                  ),
                );
                }
              }, 
              child: Text(context.tr("register"))
            ),

            SizedBox(height: AppSpacing.s),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogInPage() )
                );
              },
              child: Text(
                context.tr("have account"),
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