import 'package:flutter/material.dart';
import 'package:mynotes/constants/toutes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify ur email dum dumb')),
      body: Column(
        children: [
          const Text('We\'ve sent you an email verification'),
          const Text('If you have not received a verification email yet, press the button below'),
          TextButton(
            onPressed: () async {
              await AuthService.fireBase().sendEmailVerification();
            },
            child: const Text('Send email verification')
          ),
          TextButton(
            onPressed: () async {
            await AuthService.fireBase().logOut();
            Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Restart'),
          )
        ]),
    );
  }
}