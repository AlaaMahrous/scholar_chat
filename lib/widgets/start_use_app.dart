// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/cubits/password_cubit.dart';
import 'package:scholar_chat/cubits/password_states.dart';
import 'package:scholar_chat/widgets/custom_button.dart';

class StartUseApp extends StatelessWidget {
  const StartUseApp({
    super.key,
    required this.pageName,
    required this.description,
    required this.navigatePage,
    required this.email,
    required this.password,
    required this.pageRole,
    required this.navigate,
  });

  final String pageName;
  final String description;
  final String navigatePage;
  final ValueChanged<String> email;
  final ValueChanged<String> password;
  final VoidCallback pageRole;
  final VoidCallback navigate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordCubit(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 70),
            Image.asset('assets/images/scholar.png', height: 100),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Scolar chat',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                pageName,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUnfocus,
              validator: (value) {
                if (value!.isEmpty){
                  return 'Feild is required';
                } else if (!value.endsWith('@gmail.com')){
                  return 'email should end with @gmail.com';
                }
              },
              onChanged: (value) => email(value),
              decoration: const InputDecoration(hintText: 'Email'),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            BlocBuilder<PasswordCubit, PasswordStates>(
              builder: (context, state) {
                final passwordCubit = context.read<PasswordCubit>();
                return TextFormField(
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Feild is required';
                    } else if (value.length < 6){
                      return 'The password must be at least 6 characters long.';
                    } 
                  },
                  onChanged: (value) => password(value),
                  obscureText: passwordCubit.passwordStates,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        passwordCubit.changePasswordState();
                      },
                      icon: Icon(
                        passwordCubit.passwordStates
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    suffixIconColor: Colors.grey,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              },
            ),
            const SizedBox(height: 30),
            CustomButton(onTap: pageRole, text: pageName),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextButton(
                  onPressed: navigate,
                  child: Text(
                    navigatePage,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
