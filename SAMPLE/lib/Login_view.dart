// ignore_for_file: non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Center(child: Text('Email Log-In')),
        ),
        body: FutureBuilder(
            future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final user = FirebaseAuth.instance.currentUser;
                  if (user?.emailVerified ?? false)
                    print('verified user');
                  else
                    print('not verified');
                  return Column(children: [
                    TextField(
                        controller: _email,
                        decoration: const InputDecoration(
                            hintText: 'Enter your email here')),
                    TextField(
                        controller: _password,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: 'Enter your password')),
                    TextButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          await Firebase.initializeApp(
                            options: DefaultFirebaseOptions.currentPlatform,
                          );
                          try {
                            final UserCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                            print("you're in");
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                          } catch (e) {
                            print("Error");
                          }
                        },
                        child: const Text('Login')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/register/',
                            (route) => false,
                          );
                        },
                        child: const Text('Don\'t have an account register '))
                  ]);

                default:
                  return const Center(child: const Text('Loading...'));
              }
            }));

    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
