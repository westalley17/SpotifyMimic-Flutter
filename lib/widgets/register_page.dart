import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  String result = "";

  Future<void> register(
      String email, String password, String firstName, String lastName) async {
    result = "";

    // temporary "validation" until I get the register/login toggle and HTTP comms working
    if (email.length < 10) {
      result += "Email must be 10 characters or more!\n";
    }
    if (password.length < 10) {
      result += "Password must be 10 characters or more!\n";
    }
    if (firstName.length < 5) {
      result += "First name must be 5 characters or more!\n";
    }
    if (lastName.length < 5) {
      result += "Last name must be 5 characters or more!\n";
    }

    // true: send a POST to backend to attempt user creation. User passed front-end validation!
    // false: make a pop-up alert show all the errors that the user has on their input fields.
    if (result.isEmpty) {
      final url = Uri.parse('http://10.0.2.2:3030/api/users');
      final headers = {
        'Content-Type': 'application/json',
      };
      final body = jsonEncode({
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
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
            subtitleOptions:
                StatusAlertTextConfiguration(textAlign: TextAlign.start),
            context,
            title: "Successfully created your account, $firstName!",
            subtitle: responseData.toString(),
            configuration: const IconConfiguration(
              icon: Icons.check,
              size: 40.0,
              color: Colors.green,
            ),
            dismissOnBackgroundTap: true,
            padding: const EdgeInsets.all(6.0),
            duration: const Duration(seconds: 3),
          );
        } else {
          StatusAlert.show(
            context,
            title: "Error creating...",
            subtitle: 'Status code: ${response.statusCode}',
            configuration: const IconConfiguration(
              icon: Icons.check,
              size: 40.0,
              color: Colors.green,
            ),
            dismissOnBackgroundTap: true,
            padding: const EdgeInsets.all(20.0),
            duration: const Duration(seconds: 3),
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
          padding: const EdgeInsets.all(20.0),
          duration: const Duration(seconds: 10),
        );
      }
    } else {
      // did not format inputs correctly.
      StatusAlert.show(
        subtitleOptions:
            StatusAlertTextConfiguration(textAlign: TextAlign.start),
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
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
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
                  margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                  child: const Image(
                    width: 120.0,
                    height: 120.0,
                    image: AssetImage('assets/Spotify-Logo.png'),
                  ),
                ),
                Container(
                  width: 400.0,
                  padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                  child: TextField(
                    controller: firstNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                      hintText: "John",
                      label: Text("First Name"),
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
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 40.0),
                  child: TextField(
                    controller: lastNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                      hintText: "Doe",
                      label: Text("Last Name"),
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
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
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
                    onPressed: () {
                      // calls a register function that calls a GET to ensure uniqueness
                      // and then a POST to create the account.
                      register(emailController.text, passwordController.text,
                          firstNameController.text, lastNameController.text);
                      emailController.clear();
                      passwordController.clear();
                      firstNameController.clear();
                      lastNameController.clear();
                    },
                    child: const Text(
                      "Register",
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
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Back to login",
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
