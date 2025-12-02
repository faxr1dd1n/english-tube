import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/service/firebase_auth_service.dart';
import 'package:en_tube/src/ui/login/login_screen.dart';
import 'package:en_tube/src/widgets/app_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Reload user to get latest data
    await authService.value.currentUser?.reload();
    final user = authService.value.currentUser;
    if (user != null) {
      print("Loading user data...");
      print("Display Name: ${user.displayName}");
      print("Email: ${user.email}");
      setState(() {
        userName = user.displayName ?? "User";
        userEmail = user.email ?? "No email";
      });
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await authService.value.signOut();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Aniqlamagan xatolik'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "$label:",
            style: TextStyle(
              color: AppColor.white.withValues(alpha: 0.7),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              color: AppColor.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.geeralColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: 'Profile'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.network(
                  "https://thumbs.dreamstime.com/b/d-icon-avatar-student-man-reading-book-school-concept-education-learning-isolated-transparent-png-background-cartoon-352289965.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // User ma'lumotlari kartasi
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "User Information",
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Display Name
                  _buildInfoRow(
                    "Display Name",
                    authService.value.currentUser?.displayName ?? "Unknown",
                  ),
                  const SizedBox(height: 15),

                  // Email
                  _buildInfoRow("Email", authService.value.currentUser?.email ?? "N/A"),
                  const SizedBox(height: 15),

                  // User ID
                  _buildInfoRow(
                    "User ID",
                    authService.value.currentUser?.uid ?? "N/A",
                  ),
                  const SizedBox(height: 15),

                  // Email Verified
                  _buildInfoRow(
                    "Email Verified",
                    authService.value.currentUser?.emailVerified == true
                        ? "Yes"
                        : "No",
                  ),
                  const SizedBox(height: 15),

                  // Created At
                  _buildInfoRow(
                    "Account Created",
                    authService.value.currentUser?.metadata.creationTime != null
                        ? _formatDate(
                            authService
                                .value
                                .currentUser!
                                .metadata
                                .creationTime!,
                          )
                        : "N/A",
                  ),
                  const SizedBox(height: 15),

                  // Last Sign In
                  _buildInfoRow(
                    "Last Sign In",
                    authService.value.currentUser?.metadata.lastSignInTime !=
                            null
                        ? _formatDate(
                            authService
                                .value
                                .currentUser!
                                .metadata
                                .lastSignInTime!,
                          )
                        : "N/A",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Logout button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color.fromARGB(191, 254, 17, 0),
                  ),
                  onPressed: () => logout(context),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
