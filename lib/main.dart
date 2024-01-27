import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes/new_note_view.dart';
import 'package:mynotes/views/notes/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';
import 'dart:developer' as devtools show log;
import 'package:mynotes/constants/routes.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute:(context) => const NotesView(),
        mainRoute:(context) => const HomePage(),
        verifyEmailRoute:(context) => const VerifyEmailView(),
        newNoteRoute:(context) => new NewNoteView(),
      },
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.fireBase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState){

            case ConnectionState.done:
              final user = AuthService.fireBase().currentUser;
              devtools.log(user.toString());
              if (user != null) {
                if (user.isEmailVerified != false) {
                  devtools.log('verifyed');
                  return const NotesView();
                } else {
                  devtools.log('verify');
                  return const VerifyEmailView();
                }
              } else {
                devtools.log('register');
                return LoginView();
              }
              // return const LoginView();
            default:
              return const CircularProgressIndicator();
          } //switch end
        }, //builder end
        
      );
  }
}