import 'package:ChatUI/libs.dart';
import 'package:http/http.dart';

class SessionHandler {
  SessionHandler(this._pref);

  final SharedPrefHandler _pref;
  Map<String, String> headers = {"content-type": "text/json"};
  Map<String, String> cookies = {};

  Future<Map<String, String>> getHeader() async {
    var cookie = await this._pref.getCookieHeader();
    return {SharedPrefHandler.COOKIE: cookie};
  }

  Future<void> saveCookie(String newCookieHeader) async {
    await this._pref.saveCookie(newCookieHeader);
    return;
  }

  Future<bool> updateCookie(Response response) async {
    if (response == null) {
      return false;
    }
    _updateCookie(response);
    String cookieString = _generateCookieHeader();
    if (cookieString == '') {
      return false;
    }
    await saveCookie(cookieString);
    return true;
  }

  void _updateCookie(Response response) {
    String allSetCookie = response.headers['set-cookie'];

    if (allSetCookie != null) {
      var setCookies = allSetCookie.split(',');

      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }

      headers['cookie'] = _generateCookieHeader();
    }
  }

  void _setCookie(String rawCookie) {
    if (rawCookie.length > 0) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires') return;

        this.cookies[key] = value;
      }
    }
  }

  String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.length > 0) cookie += ";";
      cookie += key + "=" + cookies[key];
    }

    return cookie;
  }

  Future<Alie> getUser() async {
    await this._pref.getUser();
  }
}
