import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/assets.dart';
import '../data/validators.dart';
import '../extensions/build_context_extension.dart';
import '../helpers/responsive.dart';
import '../providers/account.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "onboarding";
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  bool isLogin = true;
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.5),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
  }

  void _submit() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          isLoading = true;
        });
        if (isLogin) {
          await context
              .read<AccountProvider>()
              .login(_emailController.text, _passwordController.text);
        } else {
          await context.read<AccountProvider>().register(_emailController.text,
              _passwordController.text, _nameController.text);
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.25; // 25% of screen width
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: Responsive.isMobile(context)
              ? null
              : EdgeInsets.symmetric(horizontal: horizontalPadding),
          decoration: Responsive.isMobile(context)
              ? null
              : const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.imagesBg),
                    fit: BoxFit.cover,
                    opacity: 0.3,
                  ),
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20),
                child: Image.asset(
                  Assets.imagesNetflixLogo1,
                  fit: BoxFit.contain,
                  width: Responsive.isMobile(context) ? 120 : 250,
                  // height: 50,
                ),
              ),
              const Spacer(),
              Container(
                height: screenheight - (screenheight * 0.25),
                color: Colors.black54,
                padding: Responsive.isMobile(context)
                    ? const EdgeInsets.symmetric(horizontal: 20.0)
                    : const EdgeInsets.symmetric(horizontal: 50),
                margin: Responsive.isDesktop(context)
                    ? const EdgeInsets.symmetric(horizontal: 100)
                    : null,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isLogin ? "Sign In" : "Sign Up",
                        style: context.textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 28),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail.call,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          label: Text("Email"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.emailAddress,
                        validator: isLogin
                            ? Validators.validateRequiredField("Password").call
                            : Validators.validatePassword.call,
                        decoration: const InputDecoration(
                          hintText: "Password",
                          label: Text("Password"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AnimatedContainer(
                        constraints: BoxConstraints(
                          minHeight: !isLogin ? 60 : 0,
                          maxHeight: !isLogin ? 120 : 0,
                        ),
                        duration: const Duration(milliseconds: 300),
                        child: FadeTransition(
                          opacity: _opacityAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: TextFormField(
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              enabled: !isLogin,
                              decoration: const InputDecoration(
                                hintText: "Name",
                                label: Text("Name"),
                              ),
                              validator: !isLogin
                                  ? Validators.validateName.call
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      if (!isLogin) const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: isLoading ? null : _submit,
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : Text(isLogin ? "Sign In" : "Sign Up"),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          runAlignment: WrapAlignment.spaceBetween,
                          children: [
                            if (isLogin)
                              TextButton(
                                onPressed: () => {},
                                child: const Text("Forgot password"),
                              ),
                            TextButton(
                              onPressed: () => setState(() {
                                if (!isLogin) {
                                  _animationController.reverse();
                                } else {
                                  _animationController.forward();
                                }
                                isLogin = !isLogin;
                              }),
                              child: Text(!isLogin ? "Sign In" : "Sign Up"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
