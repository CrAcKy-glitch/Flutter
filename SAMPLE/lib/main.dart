// ignore_for_file: non_constant_identifier_names
//
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'Login_view.dart';
import 'Register_view.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const (title: 'Login Page'),
      routes: {
        '/login/': (context) => LoginView(),
        '/register/': (context) => RegisT(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent0 (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => cover();
}

class cover extends StatefulWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void initState() {
    // _email = TextEditingController();
    // _password = TextEditingController();
    // super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    // super.dispose();
  }

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
                  if (user != null) if (user?.emailVerified ?? false)
                    print('verified user');
                  else
                    print('no verfied');
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
                  return const CircularProgressIndicator();
              }
            }));

    // This trailing comma makes auto-formatting nicer for build methods.
  }
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Notes')));
  }
}
