import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/screens/forgot_password_verify_otp_screen.dart';
import 'package:task_management/ui/utils/app_colors.dart';
import 'package:task_management/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/app.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  static const String name = '/forgot_password/verify_email';

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() =>
      _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState
    extends State<ForgotPasswordVerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _recoveryEmailInProgress = false;

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
                  Text('Your Email Address', style: textTheme.titleLarge),
                  Text(
                      'A 6 digit verification pin will send to your email address',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Visibility(
                    visible: _recoveryEmailInProgress == false,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapEmailRecovery,
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
                Navigator.pop(context);
              },
          ),
        ],
      ),
    );
  }

  void _onTapEmailRecovery() {
    if (_globalKey.currentState!.validate()) {
      _getRecoveryEmail();
    }
  }

  Future<void> _getRecoveryEmail() async {
    _recoveryEmailInProgress = true;
    setState(() {});
    final email = _emailTEController.text;
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.recoveryVerifyEmailUrl(email));
    if (response.isSuccess) {
      Navigator.pushNamed(context, ForgotPasswordVerifyOtpScreen.name,
          arguments: email);
      showSnackBarMessage(context, 'Email verify successful');
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
    _recoveryEmailInProgress = false;
    setState(() {});
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
