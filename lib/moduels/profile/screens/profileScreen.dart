import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/core/theme/colors.dart';
import 'package:mob_final/core/theme/textStyles.dart';
import 'package:mob_final/moduels/auth/bloc/authBloc.dart';
import 'package:mob_final/moduels/auth/bloc/authEvent.dart';
import 'package:mob_final/moduels/auth/data/user.dart';
import 'package:mob_final/moduels/profile/bloc/profileBloc.dart';
import 'package:mob_final/moduels/profile/bloc/profileEvent.dart';
import 'package:mob_final/moduels/profile/bloc/profileState.dart';
import 'package:mob_final/core/theme/spacing.dart';
import 'package:mob_final/services/dbClient.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  late TextEditingController controller;
  String? errorText;

  @override
  void initState(){
    super.initState();
    final username = context.read<ProfileBloc>().state.username;
    controller = TextEditingController(text: username);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      isEditing = true;
      errorText = null;
    });
  }

  void _cancelEditing() {
    final username = context.read<ProfileBloc>().state.username;

    setState(() {
      controller.text = username;
      isEditing = false;
      errorText = null;
    });
  }

  void _save() {
    final value = controller.text.trim();

    if (value.isEmpty) {
      setState(() {
        errorText = context.tr("empty name");
      });
      return;
    }

    context.read<ProfileBloc>().add(SetUsernameEvent(newName: value));

    setState(() {
      isEditing = false;
      errorText = null;
    });
  }

  void _logOut()
  {
    context.read<AuthBloc>().add(LogOutEvent());
    context.read<ProfileBloc>().add(ClearProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr("change profile")),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) {
          return previous.language != current.language;
        },

        listener: (context, state) {
            context.setLocale(Locale(state.language));
        } ,

        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.tr("name"), style: AppTextStyles.title),
                const SizedBox(height: AppSpacing.s),

                Row(
                  children: [
                    /// TEXT / INPUT
                    Expanded(
                      child: isEditing
                          ? TextField(
                              controller: controller,
                              autofocus: true,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: context.tr("name helper"),
                                errorText: errorText,
                              ),
                              onSubmitted: (_) => _save(),
                            )
                          : Text(
                              state.username.isEmpty
                                  ? "No Name"
                                  : state.username,
                              style: AppTextStyles.body,
                            ),
                    ),

                    const SizedBox(width: AppSpacing.s),

                    /// EDIT / SAVE
                    IconButton(
                      icon: Icon(isEditing ? Icons.check : Icons.edit),
                      onPressed: isEditing ? _save : _startEditing,
                      color: Theme.of(context).primaryColor,
                    ),

                    IconButton(
                        icon: Icon(isEditing? Icons.close : Icons.logout),
                        onPressed: isEditing ? _cancelEditing: _logOut,
                        color: isEditing ? AppColors.like : Theme.of(context).primaryColor,
                      ),
                      
                  ],
                ),

                const SizedBox(height: 24),

                Text(context.tr("language"), style: AppTextStyles.title),
                const SizedBox(height: AppSpacing.s),

                DropdownButtonFormField<String>(
                  value: state.language,
                  items: const [
                    DropdownMenuItem(value: 'ru', child: Text('Русский 🇷🇺')),
                    DropdownMenuItem(value: 'kk', child: Text('Қазақ 🇰🇿')),
                    DropdownMenuItem(value: 'en', child: Text('English 🇬🇧')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      context
                          .read<ProfileBloc>()
                          .add(SetLanguageEvent(value));
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: AppSpacing.l),

                Text(context.tr("theme"), style: AppTextStyles.title),
                const SizedBox(height: AppSpacing.s),

                SwitchListTile(
                  title: Text(
                      state.isDark ? context.tr("dark"): context.tr("light")),
                  value: state.isDark,
                  onChanged: (_) {
                    context
                        .read<ProfileBloc>()
                        .add(ToggleThemeEvent());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}