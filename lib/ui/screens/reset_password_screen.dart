import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/screens/forgot_password_verify_otp_screen.dart';
import 'package:task_management/ui/screens/sign_in_screen.dart';
import 'package:task_management/ui/utils/app_colors.dart';
import 'package:task_management/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen(
      {super.key, required this.otp, required this.email});

  final String otp;
  final String email;

  static const String name = '/forgot_password/reset_password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _resetPasswordInProgress = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text('Set Password', style: textTheme.titleLarge),
                  Text(
                      'Minimum length password 8 character with Letter and number combination',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Password'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your password';
                      }else if(value!.length<6){
                        return 'Password must be more then 6 letters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(hintText: 'Confirm Password'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your confirm password';
                      }else if(value!.length<6){
                        return 'Password must be more then 6 letters';
                      }else if(value != _passwordTEController.text){
                        return 'Password do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Visibility(
                    visible: _resetPasswordInProgress == false,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapResetPassword,
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Center(
                    child: _buildSignInSection(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInSection() {
    return RichText(
      text: TextSpan(
        text: "Already have an account?",
        style: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(
              color: AppColors.themeColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInScreen.name, (predicate) => false);
              },
          ),
        ],
      ),
    );
  }

  void _onTapResetPassword() {
    if (_globalKey.currentState!.validate()) {
      _resetPassword();
    }
  }

  Future<void> _resetPassword() async {
    _resetPasswordInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _passwordTEController.text,
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.recoverPasswordUrl, body: requestBody);
    if (response.isSuccess) {
      showSnackBarMessage(context, 'password reset successful');
      Navigator.pushNamedAndRemoveUntil(
          context, SignInScreen.name, (predicate) => false);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _resetPasswordInProgress = false;
    setState(() {});
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
