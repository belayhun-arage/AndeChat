import 'package:ChatUI/libs.dart';
import 'dart:async';

// @Summary 登录
// @Description 登录
// @Produce json
// @Param body body controllers.LoginParams true "body参数"
// @Success 200 {string} string "ok" "返回用户信息"
// @Failure 400 {string} string "err_code：10002 参数错误； err_code：10003 校验错误"
// @Failure 401 {string} string "err_code：10001 登录失败"
// @Failure 500 {string} string "err_code：20001 服务错误；err_code：20002 接口错误；err_code：20003 无数据错误；err_code：20004 数据库异常；err_code：20005 缓存异常"
// @Router /user/person/login [post]
class UserRepository {
  UserRepository() {
    UserDataProvider.getInstance().then((prov) {
      this.provider = prov;
    });
  }

  UserDataProvider provider;

  Future<Alie> getMyProfile() async {
    return this.provider.getMyProfile();
  }

  Future<LoginRes> logUserIn(String email, String password) async {
    return await this.provider.Login(email, password);
  }

  Future<RegistrationRes> registerUser(
      RegistrationInput registrationInput) async {
    return await this.provider.Register(registrationInput);
  }

  Future<List<Alie>> getMyFriends() async {
    final friends = await this.provider.getMyFriends();
    MessagingDataProvider provide = await MessagingDataProvider.getInstance();
    for (int a = 0; a < friends.length; a++) {
      final friend = friends[a];
      try {
        if (friend != null) {
          friend.populateChats(provide);
        }
      } catch (e, a) {
        continue;
      }
    }
    print(friends == null ? "Erre Lash They are null " : friends.length);
    return friends;
  }
}
