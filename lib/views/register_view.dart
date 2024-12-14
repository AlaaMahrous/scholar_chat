// ignore_for_file: unused_local_variable, must_be_immutable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constraints/app_constraints.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/views/chat_view.dart';
import 'package:scholar_chat/widgets/start_use_app.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = 'RegisterView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late String userEmail;
  late String userPassword;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoadig = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoadig,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Form(
          key: formKey,
          child: StartUseApp(
            pageName: 'Register',
            description: 'already have an account',
            navigatePage: 'Login',
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
                  await registerUser();
                  showMessage(context, 'The account has been created successfully.');
                  Navigator.pushNamed(context, ChatView.id);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    showMessage(context, 'The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    showMessage(
                        context, 'The account already exists for that email.');
                  } else if (e.code == 'invalid-email' ||
                      e.message!.contains('email address is badly formatted')) {
                    showMessage(
                        context, 'The email address is badly formatted.');
                  } else if (e.code == 'operation-not-allowed') {
                    showMessage(
                        context, 'Email/password accounts are not enabled.');
                  } else if (e.code == 'network-request-failed') {
                    showMessage(context,
                        'Network error. Please check your connection.');
                  } else if (e.code == 'configuration-not-found') {
                    showMessage(context, 'Firebase configuration not found.');
                  } else {
                    showMessage(
                        context, 'An unknown error occurred: ${e.message}');
                  }
                } catch (e) {
                  showMessage(context, 'An error occurred: ${e.toString()}');
                }
                setState(() {
                  isLoadig = false;
                });
              } else {}
            },
            navigate: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );
  }
}
