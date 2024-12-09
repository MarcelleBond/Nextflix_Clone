import 'package:flutter/material.dart';
import 'package:netflix_clone/constants/assets.dart';
import 'package:netflix_clone/extensions/build_context_extension.dart';

import '../data/validators.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "onboarding";
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLogin = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    super.dispose();
  }
  
    void submit() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20),
              child: Image.asset(
                Assets.imagesNetflixLogo1,
                fit: BoxFit.contain,
                width: 120,
                // height: 50,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isLogin ? "Sign In" : "Sign Up",
                      style: context.textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.validateEmail.call,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        label: Text("Email"),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      validator: isLogin
                          ? Validators.validateRequiredField("Password").call
                          : Validators.validatePassword.call,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        label: Text("Password"),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: submit,
                        child: Text(isLogin ? "Sign In" : "Sign Up"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => {},
                          child: const Text("Forgot password"),
                        ),
                        TextButton(
                          onPressed: () => {},
                          child: const Text("Sign up"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }


}
