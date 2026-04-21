import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob_final/core/theme/colors.dart';
import 'package:mob_final/core/theme/textStyles.dart';
import 'package:mob_final/moduels/auth/bloc/authBloc.dart';
import 'package:mob_final/moduels/auth/bloc/authEvent.dart';
import 'package:mob_final/moduels/profile/bloc/profileBloc.dart';
import 'package:mob_final/moduels/profile/bloc/profileEvent.dart';
import 'package:mob_final/moduels/profile/bloc/profileState.dart';
import 'package:mob_final/core/theme/spacing.dart';

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
  void initState() {
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
        errorText = "Username cannot be empty";
      });
      return;
    }

    context.read<ProfileBloc>().add(SetUsernameEvent(value));

    setState(() {
      isEditing = false;
      errorText = null;
    });
  }

  void _logOut()
  {
    context.read<AuthBloc>().add(LogOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Profile Info"),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Name", style: AppTextStyles.title),
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
                                hintText: "Enter new username",
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

                const Text("Language", style: AppTextStyles.title),
                const SizedBox(height: AppSpacing.s),

                DropdownButtonFormField<String>(
                  value: state.language,
                  items: const [
                    DropdownMenuItem(value: 'ru', child: Text('Русский 🇷🇺')),
                    DropdownMenuItem(value: 'kz', child: Text('Қазақ 🇰🇿')),
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

                const Text("Theme", style: AppTextStyles.title),
                const SizedBox(height: AppSpacing.s),

                SwitchListTile(
                  title: Text(
                      state.isDark ? "Dark Theme" : "Light Theme"),
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