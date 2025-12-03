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
        String errorMessage = 'Aniqlamagan xatolik';

        if (e.code == 'user-not-found') {
          errorMessage = 'Foydalanuvchi topilmadi!';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Parol noto\'g\'ri!';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Email noto\'g\'ri formatda!';
        } else if (e.code == 'user-disabled') {
          errorMessage = 'Bu akkaunt o\'chirilgan!';
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
              const Text(
                "Welcome Back",
                style: TextStyle(
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
                  labelText: "Email",
                  labelStyle: TextStyle(color: AppColor.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
      
                    borderSide: BorderSide(color: AppColor.white),
                  ),
      
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                validator: (v) {
                  if (v!.isEmpty) return "Email kiriting";
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
                  labelText: "Password",
                  labelStyle: TextStyle(color: AppColor.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
      
                    borderSide: BorderSide(color: AppColor.white),
                  ),
      
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                validator: (v) {
                  if (v!.isEmpty) return "Parol kiriting";
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

                                valueColor:
                                    AlwaysStoppedAnimation<Color>(AppColor.generalColor),
                            )
                            : const Text(
                                "Login",
                                style: TextStyle(
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
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
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
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
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
