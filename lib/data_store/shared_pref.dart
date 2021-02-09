import 'package:ChatUI/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHandler {
  static const ID = 'id';
  static const SET_COOKIE = 'set-cookie';
  static const USER_NAME = 'username';
  static const PASSWORD = 'password';
  static const EMAIL = 'email';
  static const PROFILE_IMAGE = "imgurl";
  static const BIO = "bio";
  static const COOKIE = "Cookie";
  static const FILE_PATH = 'file_path';



  static StreamController<bool> onSyncController = StreamController();
  static StreamController<bool> onSyncSearchController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;
  Stream<bool> get onSyncSearch => onSyncSearchController.stream;




  final SharedPreferences _preferences;

  static SharedPrefHandler _handler;

  SharedPrefHandler(this._preferences);

  Future<String >  getFilePath( ) async {
     if (_handler == null) {
      await SharedPrefHandler.getInstance();
    }
     String filePath =
        _handler._preferences.getString(SharedPrefHandler.FILE_PATH);
    return filePath;
  }


  Future<void> setFilePath(String filePath ) async {
    if (_handler == null) {
      await SharedPrefHandler.getInstance();
    }
    _handler._preferences.setString(SharedPrefHandler.FILE_PATH, filePath );
    return;
  }



  static Future<SharedPrefHandler> getInstance() async {
    if (_handler == null) {
      SharedPreferences _sharedPreferences =
          await SharedPreferences.getInstance();
      _handler = new SharedPrefHandler(_sharedPreferences);
    }
    return _handler;
  }

  Future<void> saveCookie(String setCookie) async {
    if (_handler == null) {
      await SharedPrefHandler.getInstance();
    }
    _handler._preferences.setString(SharedPrefHandler.SET_COOKIE, setCookie);
    return;
  }

  Future<String> getCookieHeader() async {
    if (_handler == null) {
      await SharedPrefHandler.getInstance();
    }
    String cookie =
        _handler._preferences.getString(SharedPrefHandler.SET_COOKIE);
    return cookie;
  }

  Future<Alie> getUser() async {
    String id = _handler._preferences.getString(ID);
    String username = _handler._preferences.getString(USER_NAME);
    String email = _handler._preferences.getString(EMAIL);
    String imageurl = _handler._preferences.getString(PROFILE_IMAGE);
    String bio = _handler._preferences.getString(BIO);
    // String

    Alie user = Alie(
      id: id,
      bio: bio,
      email: email,
      imageUrl: imageurl,
      username: username,
    );
  }

  Future<void> setUser(Alie user) async {
    if (_handler == null) {
      await SharedPrefHandler.getInstance();
    }
    bool res = await _handler._preferences.setString(ID, user.id);
    if (!res) {
      return res;
    }
    res = await _handler._preferences.setString(USER_NAME, user.id);
    if (!res) {
      return res;
    }
    res = await _handler._preferences.setString(EMAIL, user.id);
    if (!res) {
      return res;
    }
    res = await _handler._preferences.setString(PROFILE_IMAGE, user.id);
    if (!res) {
      return res;
    }
    res = await _handler._preferences.setString(BIO, user.id);
    return res;
  }
}
