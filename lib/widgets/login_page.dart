import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 50.0),
                  child: const Image(
                    width: 150.0,
                    height: 150.0,
                    image: AssetImage('assets/Spotify-Logo.png'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40.0),
                  child: const Text(
                    "Music for everyone",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
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
                    onPressed: () => {},
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
