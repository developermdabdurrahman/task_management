import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_management/ui/controllers/auth_controller.dart';
import 'package:task_management/ui/screens/sign_in_screen.dart';
import 'package:task_management/ui/screens/update_profile_screen.dart';

import '../utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromUpdateProfile = false});

  final bool fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: AppColors.themeColor,
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: MemoryImage(
              base64Decode(AuthController.userModel?.photo ?? ''),
            ),
            onBackgroundImageError: (_, __) => const Icon(Icons.person),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!fromUpdateProfile) {
                  Navigator.pushNamed(context, UpdateProfileScreen.name);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthController.userModel?.fullName ?? 'Guest User',
                    style: textStyle.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    AuthController.userModel?.email ??
                        'guest.example@gmail.com',
                    style: textStyle.bodySmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () async {
                await AuthController.clearUserData();
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInScreen.name, (predicate) => false);
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
