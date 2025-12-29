import 'package:easy_localization/easy_localization.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/service/firebase_auth_service.dart';
import 'package:en_tube/src/ui/login/signup_screen.dart';
import 'package:en_tube/src/ui/menu/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isObscured = true;
  bool isLoading = false;

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await authService.value.signIn(
        email: email.text,  
        password: password.text,
      );

      setState(() => isLoading = false);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);

      if (mounted) {
        String errorMessage = 'auth.unknown_error'.tr();

        if (e.code == 'user-not-found') {
          errorMessage = 'auth.user_not_found'.tr();
        } else if (e.code == 'wrong-password') {
          errorMessage = 'auth.wrong_password'.tr();
        } else if (e.code == 'invalid-email') {
          errorMessage = 'auth.invalid_email'.tr();
        } else if (e.code == 'user-disabled') {
          errorMessage = 'auth.account_deleted'.tr();
        } else if (e.message != null) {
          errorMessage = e.message!;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.generalColor,

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'auth.welcome_back'.tr(),
                style: const TextStyle(
                  color: AppColor.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
      
              // Email
              TextFormField(
                style: TextStyle(color: AppColor.white),
                cursorColor: AppColor.white,
                controller: email,

                decoration: InputDecoration(
                  filled: false,
                  labelText: 'auth.email'.tr(),
                  labelStyle: const TextStyle(color: AppColor.white),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),

                    borderSide: BorderSide(color: AppColor.white),
                  ),

                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                validator: (v) {
                  if (v!.isEmpty) return 'auth.enter_email'.tr();
                  return null;
                },
              ),
      
              const SizedBox(height: 20),
      
              // Password
              TextFormField(
                style: TextStyle(color: AppColor.white),
                cursorColor: AppColor.white,
                controller: password,
                obscureText:isObscured? true:false,
                decoration: InputDecoration(
                  filled: false,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                    child: Icon(
                      isObscured ? Icons.visibility : Icons.visibility_off,
                      color: AppColor.white,
                    ),
                  ),
                  labelText: 'auth.password'.tr(),
                  labelStyle: const TextStyle(color: AppColor.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),

                    borderSide: BorderSide(color: AppColor.white),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                validator: (v) {
                  if (v!.isEmpty) return 'auth.enter_password'.tr();
                  return null;
                },
              ),
      
              const SizedBox(height: 30),
      
              // Login button
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: AppColor.white,
                          disabledBackgroundColor: AppColor.white,
                        ),

                        onPressed: isLoading ? null : login,
                        child: isLoading
                            ? const CircularProgressIndicator(
                      strokeWidth: 3,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(AppColor.generalColor),
                            )
                            : Text(
                                'auth.login'.tr(),
                                style: const TextStyle(
                                  color: AppColor.generalColor,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // SignUp link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${'auth.dont_have_account'.tr()} ',
                    style: const TextStyle(
                      color: AppColor.white,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      );
                    },
                    child: Text(
                      'auth.sign_up'.tr(),
                      style: const TextStyle(
                        color: AppColor.white,
                        fontSize: 14,
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
    );
  }
}
