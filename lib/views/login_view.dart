// ignore_for_file: must_be_immutable, unused_local_variable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constraints/app_constraints.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/views/chat_view.dart';
import 'package:scholar_chat/views/register_view.dart';
import 'package:scholar_chat/widgets/start_use_app.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoadig = false;
  late String userEmail;
  late String userPassword;
  late UserCredential userCredential;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoadig,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Form(
          key: formKey,
          child: StartUseApp(
            pageName: 'Login',
            description: 'don\'t have an account',
            navigatePage: 'Sign Up',
            email: (String value) {
              userEmail = value;
              AppConstraints.appUserId = userEmail;
            },
            password: (String value) {
              userPassword = value;
            },
            pageRole: () async {
              if (formKey.currentState!.validate()) {
                try {
                  setState(() {
                    isLoadig = true;
                  });
                  await loginUser();
                  showMessage(context, 'Sign in success');
                  Navigator.pushNamed(context, ChatView.id);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    showMessage(context, 'No user found for this email.');
                  } else if (e.code == 'wrong-password') {
                    showMessage(context, 'Incorrect password. Please try again.');
                  } else {
                    showMessage(context, 'Sign in failed: ${e.message}');
                  }
                } catch (e) {
                  showMessage(context, 'An unknown error occurred: $e');
                }
                setState(() {
                  isLoadig = false;
                });
              }
            },
            navigate: () {
              Navigator.pushNamed(context, RegisterView.id);
            },
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );
  }
}
