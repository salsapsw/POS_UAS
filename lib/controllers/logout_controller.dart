import 'package:pos_uas/helpers/user_info.dart';

class LogoutController {
  static Future logout() async {
    await UserInfo().logout();
  }
}
