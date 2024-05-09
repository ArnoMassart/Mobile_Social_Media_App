import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../helper/helper_functions.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  Future<void> login(BuildContext context) async {
    // show loading circle
    showDialog(
      context: context,
      builder: (BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await _authService
          .signInWithEmailAndPassword(
              _emailController.text, _passwordController.text)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              const SizedBox(
                height: 25,
              ),

              // app name
              const Text(
                "S O C I O U S",
                style: TextStyle(fontSize: 20),
              ),

              getSizedBox(height: 50),

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
                autocorrect: false,
                controller: _passwordController,
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

              // sign in button
              MyButton(
                text: "Login",
                onTap: () => login(context),
              ),

              getSizedBox(height: 25),

              // don't have an account? Register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Register here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
