import 'package:easy_localization/easy_localization.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/constraints/app_images.dart';
import 'package:en_tube/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary,

      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.drawerBg),
                fit: BoxFit.fill,
              ),
              color: AppColors.darkBackground,
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomLeft,
              child: Text(
                tr('drawer.menu'),
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppColor.white),
            title: Text(
              tr('drawer.home'),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context); // Drawer yopiladi
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: AppColor.white),
            title: Text(
              tr('drawer.settings'),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
