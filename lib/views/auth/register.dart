import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/auth_controller.dart';
import 'package:threads_clone/routes/routes_name.dart';
import 'package:threads_clone/widgets/auth_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //??
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  //?? TEC ->
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final TextEditingController cPasswordController =
      TextEditingController(text: "");

  //***
  final AuthController controller = Get.put(AuthController());

  //?? submit method ->
  void signUp() {
    if (_form.currentState!.validate()) {
      controller.register(
        nameController.text,
        emailController.text,
        passwordController.text,
      );
      if (kDebugMode) {
        print('All good');
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
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
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text("Welcome to Dhaagga,"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  AuthInput(
                    hintText: "Enter your Name",
                    label: "Name",
                    controller: nameController,
                    callback: ValidationBuilder()
                        .required()
                        .minLength(3)
                        .maxLength(50)
                        .build(),
                  ),
                  const SizedBox(height: 20),
                  AuthInput(
                    hintText: "Enter your email",
                    label: "Email",
                    controller: emailController,
                    callback: ValidationBuilder().required().email().build(),
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  AuthInput(
                    hintText: "Confirm your password",
                    label: "Confirm Password",
                    controller: cPasswordController,
                    callback: (arg) {
                      if (passwordController.text != arg) {
                        return 'Confirm Password not matched';
                      }
                      return null;
                    },
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 50),
                  Obx(
                    () => ElevatedButton(
                      onPressed: signUp,
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          const Size.fromHeight(40),
                        ),
                      ),
                      child: Text(controller.registerLoading.value
                          ? 'Processing...'
                          : 'Submit'),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: " Login",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            fontSize: 16.0,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(RouteNames.login),
                        ),
                      ],
                      text: "Already have an account ?",
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
