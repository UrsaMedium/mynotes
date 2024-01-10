import 'dart:developer' as devtools show log;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/toutes.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Column(
                  children: [
                    TextField(
                      controller: _email,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter your email here',
                      ),
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password here',
                      ),
                    ),
                    TextButton(
                      onPressed: () async {           
                        final email = _email.text;
                        final password = _password.text;
                        if (email == '' || password == '') {   
                          await showErrorDialog(context, 'You\'ve left an empty field');
                        } else {
                          try {
                            await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password,);
                            final user = FirebaseAuth.instance.currentUser;
                            await user?.sendEmailVerification();
                            Navigator.of(context).pushNamed(verifyEmailRoute);
                          } on FirebaseAuthException catch (e) {
                            devtools.log(e.code.toString());
                            await showErrorDialog(context, e.code.toString());
                          } 
                        }                                           
                      },
                      child: const Text('Register'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute,
                          (route) => false,
                        );
                      },
                      child: const Text('Registered? Holy shit, go login then, champ!'),
                    )
                  ],
                ),
    );
  }
}
