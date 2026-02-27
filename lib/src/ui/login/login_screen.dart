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
        String errorMessage = tr('auth.unknown_error');

        if (e.code == 'user-not-found') {
          errorMessage = tr('auth.user_not_found');
        } else if (e.code == 'wrong-password') {
          errorMessage = tr('auth.wrong_password');
        } else if (e.code == 'invalid-email') {
          errorMessage = tr('auth.invalid_email');
        } else if (e.code == 'user-disabled') {
          errorMessage = tr('auth.account_deleted');
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
                tr('auth.welcome_back'),
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
                  labelText: tr('auth.email'),
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
                  if (v!.isEmpty) return tr('auth.enter_email');
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
                  labelText: tr('auth.password'),
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
                  if (v!.isEmpty) return tr('auth.enter_password');
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
                                tr('auth.login'),
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
                    '${tr('auth.dont_have_account')} ',
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
                      tr('auth.sign_up'),
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
