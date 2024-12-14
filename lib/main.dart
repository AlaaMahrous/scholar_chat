import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/firebase_options.dart';
import 'package:scholar_chat/views/chat_view.dart';
import 'package:scholar_chat/views/login_view.dart';
import 'package:scholar_chat/views/register_view.dart';
import 'package:scholar_chat/widgets/custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.getThemeData(),
      routes: {
        LoginView.id : (context) => LoginView(),
        RegisterView.id : (context) => RegisterView(),
        ChatView.id : (context) => ChatView()
      },
      initialRoute: LoginView.id,
    );
  }
}