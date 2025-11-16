import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/login/signup_screen.dart';
import 'package:en_tube/src/ui/menu/main_screen.dart';
import 'package:en_tube/src/ui/menu/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();

    // Saqlangan user ma'lumotlarini olish
    final savedEmail = prefs.getString("user_email");
    final savedPassword = prefs.getString("user_password");

    setState(() => isLoading = false);

    // Agar account mavjud bo'lmasa
    if (savedEmail == null || savedPassword == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account topilmadi! Iltimos, avval ro'yxatdan o'ting."),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    // Email va parolni tekshirish
    if (email.text != savedEmail || password.text != savedPassword) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email yoki parol noto'g'ri!"),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    // Login muvaffaqiyatli
    await prefs.setString("token", "sample_token_123");

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.geeralColor,

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
                                    AlwaysStoppedAnimation<Color>(AppColor.geeralColor),
                            )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  color: AppColor.geeralColor,
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
