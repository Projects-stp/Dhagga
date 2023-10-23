import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:threads_clone/routes/routes_name.dart';
import 'package:threads_clone/widgets/auth_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //??
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  //?? TEC ->
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");

  //?? submit method ->
  void login() {
    if (_form.currentState!.validate()) {
      // controller.register(
      //   nameController.text,
      //   emailController.text,
      //   passwordController.text,
      // );
      if (kDebugMode) {
        print('All good');
      }
    }
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text("Welcome back,"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  AuthInput(
                    hintText: "Enter your email",
                    label: "Email",
                    controller: emailController,
                    callback: ValidationBuilder().required().email().build(),
                  ),
                  const SizedBox(height: 30),
                  AuthInput(
                    hintText: "Enter your password",
                    label: "Password",
                    controller: passwordController,
                    callback: ValidationBuilder()
                        .required()
                        .minLength(6)
                        .maxLength(50)
                        .build(),
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: login,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size.fromHeight(40),
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 40),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: " Sign up",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            fontSize: 16.0,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(RouteNames.register),
                        ),
                      ],
                      text: "Don't have an account ?",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
