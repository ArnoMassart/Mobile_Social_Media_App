import 'package:flutter/material.dart';
import 'package:social_media_app/auth/auth_service.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AuthService _authService = AuthService();

  Future<void> registerUser(BuildContext context) async {
    if (_passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      // show loading circle
      showDialog(
          context: context,
          builder: (BuildContext context) => const Center(
                child: CircularProgressIndicator(),
              ));

      // make sure passwords match
      if (_passwordController.text != _confirmPasswordController.text) {
        // pop loading circle
        Navigator.pop(context);

        // display error message to user
        displayMessageToUser("Passwords don't match!", context);
      }
      // if passwords do match
      else {
        // try creating the user
        try {
          // create the user
          await _authService
              .signUpWithEmailAndPassword(_emailController.text,
                  _passwordController.text, _usernameController.text)
              .then((value) {
            // pop loading circle
            Navigator.pop(context);
          });
        } catch (e) {
          // pop loading circle
          Navigator.pop(context);

          // display error message to user
          displayMessageToUser(e.toString(), context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getSizedBox(height: 120),
                // logo
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                getSizedBox(height: 25),

                // app name
                const Text(
                  "S O C I O U S",
                  style: TextStyle(fontSize: 20),
                ),

                getSizedBox(height: 50),

                // username textfield
                MyTextField(
                  hintText: "Username",
                  controller: _usernameController,
                ),

                getSizedBox(height: 10),

                // email textfield
                MyTextField(
                  hintText: "Email",
                  controller: _emailController,
                ),

                getSizedBox(height: 10),

                // password textfield
                MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  autoFill: false,
                  controller: _passwordController,
                ),

                getSizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  autoFill: false,
                  controller: _confirmPasswordController,
                ),

                getSizedBox(height: 10),

                // forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forgot Password?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                  ],
                ),

                getSizedBox(height: 25),

                // login button
                MyButton(
                  text: "Register",
                  onTap: () => registerUser(context),
                ),

                getSizedBox(height: 25),

                // register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
