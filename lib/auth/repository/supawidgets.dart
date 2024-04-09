import 'package:session1_new/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> sendOtp(email) async {
  await supabase.auth.resetPasswordForEmail(email);
}

Future<User?> Verifyotp(String otp, String email) async {
  var res = await supabase.auth
      .verifyOTP(token: otp, type: OtpType.email, email: email);
  var user = res.user;
  return user;
}

Future<void> newpassword(newpass) async {
  await supabase.auth.updateUser(UserAttributes(password: newpass));
}

