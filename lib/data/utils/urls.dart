class Urls{
  static const String _baseUrls = 'https://task.teamrabbil.com/api/v1';
  static const String registrationUrl = '$_baseUrls/registration';
  static const String loginUrl = '$_baseUrls/login';
  static const String createTaskUrl = '$_baseUrls/createTask';
  static const String taskCountByStatusUrl = '$_baseUrls/taskStatusCount';
  static  String taskListByStatusUrl(String status) => '$_baseUrls/listTaskByStatus/$status';
  static const String updateProfileUrl = '$_baseUrls/profileUpdate';
  static  String recoveryVerifyEmailUrl(String email) => '$_baseUrls/RecoverVerifyEmail/$email';
  static  String otpVerificationUrl(String email, String otp) => '$_baseUrls/RecoverVerifyOTP/$email/$otp';
  static const String recoverPasswordUrl = '$_baseUrls/RecoverResetPass';
  static  String deleteTaskUrl(String id) => '$_baseUrls/deleteTask/$id';


}