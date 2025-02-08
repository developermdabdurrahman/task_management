import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

void showSnackBarMessage(BuildContext context, String message, bool status) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: status == true ? AppColors.themColor : Colors.redAccent,
      duration: Duration(milliseconds: 1500),
      content: Text(message),
    ),
  );
}
