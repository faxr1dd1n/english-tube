import 'package:easy_localization/easy_localization.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/service/firebase_auth_service.dart';
import 'package:en_tube/src/ui/login/login_screen.dart';
import 'package:en_tube/src/ui/menu/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isObscured = true;
  bool isLoading = false;

  // Future<void> signUp() async {
  //   if (!_formKey.currentState!.validate()) return;

  //   if (passwordController.text != confirmPasswordController.text) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Parollar bir xil emas!"),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   setState(() => isLoading = true);

  //   // ❗ API yo'qligi uchun local saqlash
  //   await Future.delayed(const Duration(seconds: 1));

  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString("token", "sample_token_123");
  //   await prefs.setString("user_name", nameController.text);
  //   await prefs.setString("user_email", emailController.text);
  //   await prefs.setString("user_password", passwordController.text);

  //   setState(() => isLoading = false);

  //   if (mounted) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => const MainScreen()),
  //     );
  //   }
  // }

  void register() async {
    if (!_formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr('auth.passwords_dont_match')),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await authService.value.createAccount(
        email: emailController.text,
        password: passwordController.text,
      );

      // User name'ni Firebase'ga saqlash
      print("Saving username: ${nameController.text}");
      await authService.value.updateUsername(userName: nameController.text);
      print(
        "Username after update: ${authService.value.currentUser?.displayName}",
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? tr('auth.unknown_error')),
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  tr('auth.create_account'),
                  style: const TextStyle(
                    color: AppColor.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  tr('auth.sign_up_subtitle'),
                  style: const TextStyle(color: AppColor.white, fontSize: 16),
                ),
                const SizedBox(height: 30),

                // Name
                TextFormField(
                  style: const TextStyle(color: AppColor.white),
                  cursorColor: AppColor.white,
                  controller: nameController,
                  decoration: InputDecoration(
                    filled: false,
                    labelText: tr('auth.full_name'),
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
                    if (v!.isEmpty) return tr('auth.enter_name');
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Email
                TextFormField(
                  style: const TextStyle(color: AppColor.white),
                  cursorColor: AppColor.white,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                    if (!v.contains('@')) return tr('auth.enter_valid_email');
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Password
                TextFormField(
                  style: const TextStyle(color: AppColor.white),
                  cursorColor: AppColor.white,
                  controller: passwordController,
                  obscureText: isObscured,
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
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: AppColor.white),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  validator: (v) {
                    if (v!.isEmpty) return tr('auth.enter_password');
                    if (v.length < 6) {
                      return tr('auth.password_min_length');
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Confirm Password
                TextFormField(
                  style: const TextStyle(color: AppColor.white),
                  cursorColor: AppColor.white,
                  controller: confirmPasswordController,
                  obscureText: isObscured,
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
                    labelText: tr('auth.confirm_password'),
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
                    if (v!.isEmpty) return tr('auth.confirm_password_hint');
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // SignUp button
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
                          onPressed: isLoading ? null : register,
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColor.generalColor,
                                  ),
                                )
                              : Text(
                                  tr('auth.sign_up'),
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

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${tr('auth.already_have_account')} ',
                      style: const TextStyle(color: AppColor.white, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        tr('auth.login'),
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
      ),
    );
  }
}
