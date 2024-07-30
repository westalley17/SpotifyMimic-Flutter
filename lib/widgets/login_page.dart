import 'dart:async';
import 'dart:convert';
import 'package:first_app/widgets/register_page.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String result = "";

  Future<void> login(String email, String password) async {
    result = "";

    // temporary "validation" until I get the register/login toggle and HTTP comms working
    if (email.length < 10) {
      result += "Email must be 10 characters or more!\n";
    }
    if (password.length < 10) {
      result += "Password must be 10 characters or more!\n";
    }

    // true: send a POST to backend to attempt user log in. User passed front-end validation!
    // false: make a pop-up alert show all the errors that the user has on their input fields.
    if (result.isEmpty) {
      final url = Uri.parse('http://10.0.2.2:3030/api/sessions');
      final headers = {
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        'email': email,
        'password': password,
      });
      try {
        final response = await http.post(
          url,
          headers: headers,
          body: body,
        );
        if (response.statusCode == 200) {
          // the preferable outcome
          final responseData = jsonDecode(response.body);
          // final prefs = await SharedPreferences.getInstance();
          // await prefs.setString('SessionID', responseData.SessionID);
          StatusAlert.show(
            context,
            title: "Successfully logged in!",
            subtitle: responseData.toString(),
            configuration: const IconConfiguration(
              icon: Icons.check,
              size: 40.0,
              color: Colors.green,
            ),
            dismissOnBackgroundTap: true,
            padding: const EdgeInsets.all(6.0),
          );
        } else {
          StatusAlert.show(
            context,
            title: "Error posting...",
            subtitle: 'Status code: ${response.statusCode}',
            configuration: const IconConfiguration(
              icon: Icons.check,
              size: 40.0,
              color: Colors.green,
            ),
            dismissOnBackgroundTap: true,
            padding: const EdgeInsets.all(20.0),
          );
        }
      } catch (error) {
        StatusAlert.show(
          context,
          title: "Really bad error...",
          subtitle: 'Error response: $error',
          configuration: const IconConfiguration(
            icon: Icons.check,
            size: 40.0,
            color: Colors.green,
          ),
          dismissOnBackgroundTap: true,
          padding: const EdgeInsets.all(0.0),
          duration: const Duration(seconds: 10),
        );
      }
    } else {
      // did not format inputs correctly.
      StatusAlert.show(
        context,
        title: "Incorrect formatting!",
        subtitle: result,
        configuration: const IconConfiguration(
          icon: Icons.error,
          size: 40.0,
          color: Colors.red,
        ),
        dismissOnBackgroundTap: true,
        padding: const EdgeInsets.all(6.0),
      );
    }
  }

  /*
    FIX SINGLE-SIGN-ON LATER WITH SHARED PREFERENCES!!!!
   */

  // Future<SharedPreferences> getSession() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs;
  // }

  @override
  void initState() {
    super.initState();
    // final SharedPreferences prefs = getSession() as SharedPreferences;
    // if (prefs.getString('SessionID') != "") {
    //   // user has an existing Session so we need to sign them in automatically.
    //   // we do this by calling a GET on the sessions endpoint and see if their session is still valid.
    // }
  }

  Route _animateRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const RegisterPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(
          child: Text(
            'Spotify Mimic',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color.fromARGB(255, 47, 45, 45)],
          ),
        ),
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 30.0),
                  child: const Image(
                    width: 120.0,
                    height: 120.0,
                    image: AssetImage('assets/Spotify-Logo.png'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 60.0),
                  child: const Text(
                    "Music for everyone",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                ),
                Container(
                  width: 400.0,
                  padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 30.0),
                  child: TextField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                      hintText: "johndoe@gmail.com",
                      label: Text("Email"),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(
                        color: Color.fromARGB(44, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 400.0,
                  padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                      hintText: "Johndoe1234!",
                      label: Text("Password"),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(
                        color: Color.fromARGB(44, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                  child: FilledButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green),
                    ),
                    onPressed: () => {
                      login(emailController.text, passwordController.text),
                      emailController.clear(),
                      passwordController.clear()
                    },
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 1.0,
                  indent: 40.0,
                  endIndent: 40.0,
                  height: 30.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(_animateRoute());
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
