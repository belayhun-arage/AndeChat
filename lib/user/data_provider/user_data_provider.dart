import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:ChatUI/libs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:async/async.dart';

/*
  Methods List 

  getInstance()
  Register()
  Login()
  getMyProfile()
  getProfileImage()
  getMyFriends()

*/
class UserDataProvider extends Service {
  static http.Client client;
  // Header Data Will be listed here ...
  static UserDataProvider _handler;
  static SessionHandler _sessHandler;

  static HttpCallHandler httpCallHandler;
  static const String HOST = StaticDataStore.HOST;

  static Future<UserDataProvider> getInstance() async {
    if (_handler == null) {
      _handler = new UserDataProvider();
      if (httpCallHandler == null) {
        httpCallHandler = await HttpCallHandler.getInstance();
        _sessHandler = await HttpCallHandler.sessionHandler;
        client = httpCallHandler.client;
      }
      if (_sessHandler == null) {
        _sessHandler = await HttpCallHandler.sessionHandler;
      }
    }
    return _handler;
  }

  Future<Alie> getLoggedInUser() async {
    while (true) {
      if (_sessHandler == null) {
        _sessHandler = SessionHandler(await () async {
          SharedPrefHandler hand = await SharedPrefHandler.getInstance();
          while (true) {
            if (hand == null) {
              hand = await SharedPrefHandler.getInstance();
            } else {
              break;
            }
          }
          return hand;
        }());
      } else {
        break;
      }
    }
    final user = await _sessHandler.getUser();
    return user;
  }

  Future<RegistrationRes> Register(RegistrationInput input) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    headers["Content-Type"] = "application/json";
    final response = await client.post(
      "${HOST}api/user/new/",
      body: jsonEncode({
        "username": input.username,
        "password": input.password,
        "confirmpassword": input.confirmpassword,
        "email": input.email,
      }),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body == null) {
        _sessHandler.updateCookie(response);
        return null;
      } else {
        _sessHandler.updateCookie(response);
        // _sessHandler.updateCookie(response);
        return RegistrationRes.fromJSON(body);
      }
    }
    return null;
  }

  Future<LoginRes> Login(String email, String password) async {
    var response = await client.post("${HOST}api/user/login/",
        body: jsonEncode({"email": email, "password": password}),
        headers: {
          "Content-Type": "application/json",
        });
    if (response != null && response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        _sessHandler.updateCookie(response);
        return LoginRes.fromJson(body);
      } catch (e, a) {
        print(e.toString());
        return null;
      }
    }
    return null;
  }

  Future<Alie> updateMyProfile(String username, String bio) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await client.put(
      "${HOST}api/user/",
      headers: headers,
      body: jsonEncode({
        "username": username,
        "bio": bio,
      }),
    );
    if (response == null) {
      return null;
    }
    if (response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        print(body);
        _sessHandler.updateCookie(response);

        if (!(body['success'] as bool)) {
          return null;
        }
        return Alie.fromJson(body["user"] as Map<String, dynamic>);
      } catch (e, a) {
        return null;
      }
    } else {
      print("======================++++++++++++++++++++");
      return null;
    }
  }

  Future<Alie> getMyProfile() async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await client.get(
      "${HOST}api/user/myprofile/",
      headers: headers,
    );
    if (response == null) {
      return null;
    }
    if (response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        print(body);
        _sessHandler.updateCookie(response);
        if (!(body['success'] as bool)) {
          return null;
        }
        final alie = Alie.fromJson(body["user"] as Map<String, dynamic>);
        _sessHandler.saveUser(alie);
        return alie;
      } catch (e, a) {
        return null;
      }
    }
  }

  Future<Uint8List> getProfileImage(String imageurl) async {
    print(imageurl.replaceFirst(
        new RegExp(
          "/",
        ),
        ""));
    print("I AM nnnnnk");
    var response = await client.get("${HOST}$imageurl");
    if (response != null) {
      return response.bodyBytes;
    }
    return null;
  }

  // db.user.createIndex( { username: "text",email: "text"})

  Future<List<Alie>> getMyFriends() async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    print("$headers");
    headers["content-Type"] = "application/json";
    var response = await client.get(
      "${HOST}api/user/friends/",
      headers: headers,
    );
    if (response != null && response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        if (body["success"] as bool) {
          _sessHandler.updateCookie(response);
          List<Map<String, dynamic>> friendsMap = List<Map<String, dynamic>>();
          for (var a in body['alies']) {
            print(a);
            final singleFriendMap = a as Map<String, dynamic>;
            if (singleFriendMap != null) {
              friendsMap.add(singleFriendMap);
            }
          }
          return Alie.AllUsers(friendsMap);
        } else {
          print(body["message"]);
          return null;
        }
      } catch (e, a) {
        print(e.toString());
        return null;
      }
    }
    print(response.statusCode);
    print("What just happened ...");
    return null;
  }

  /// deleteMyAccount to delete my account and Log out
  /// this method returns a boolean value signifying the
  /// deletion of the account
  /// the session header will be removed and the caller will not be authorized any more
  Future<bool> deleteMyAccount() async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await client.delete(
      "${HOST}api/user/",
      headers: headers,
    );
    print("\n\n\n\n\n${response.body}\n\n\n\n\n\n\n");
    if (response != null && response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        _sessHandler.updateCookie(response);
        print(body);
        if (body['success'] as bool) {
          return true;
        } else {
          return false;
        }
      } catch (e, a) {
        return false;
      }
    }
    return false;
  }

  /// searchUsers to search a user in the home appbar
  ///
  /// using username
  Future<List<Alie>> searchUsers(String username) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await client.get(
      "${HOST}api/user/search/?username=$username",
      headers: headers,
    );
    if (response != null && response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        _sessHandler.updateCookie(response);
        print(body);
        if (body['success'] as bool) {
          List<Map<String, dynamic>> vals = [];
          List<Map<String, dynamic>> newmapListUser = [];
          for (int a = 0; a < body['users'].length; a++) {
            newmapListUser.add(body['users'][a] as Map<String, dynamic>);
          }
          final users = Alie.AllUsers(newmapListUser);
          return users;
        } else {
          print(body['message']);
          return [];
        }
      } catch (e, a) {
        print(e.toString());
        return null;
      }
    }
    return null;
  }

  Future<bool> logout() async {
    _sessHandler.saveCookie("");
    _sessHandler.saveUser(Alie(id: ""));
    return true;
  }

  Future<String> changeProfilePicture(File _image) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }

    headers["Accept"] = "application/json";
    var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
    var length = await _image.length();
    // string to uri
    var uri = Uri.parse("${HOST}api/user/img/");
    var request = new http.MultipartRequest("PUT", uri);

    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: "frmMoile.jpg");
    // add file to multipart
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    final response = await request.send();

    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(await response.stream.bytesToString());
      print(jsonBody);
      if (jsonBody["success"] as bool) {
        print(jsonBody);
        print(jsonBody["imgurl"]);
        return jsonBody["imgurl"] as String;
      } else {
        return "";
      }
    }
    return "";
  }
}
// headers["Content-Type"] = "multipart/form-data";
// final files = new FileUploadInputElement();
// files.files=image;
// files.name="image";
// final formData = {
//   "image":files ,
// };
// Dio dio = Dio();
// var request = new client.MultipartRequest( "POST" , "${HOST}api/user/img/" );
// request.fields[ 'user' ] = 'someone@somewhere.com' ;
// request.files.add(http.MultipartFile.fromPath(
// 'package' ,
// 'build/package.tar.gz' ,
// contentType: new MediaType( 'application' , 'x-tar' ),
// ));
// request.send().then((response) {
// if (response.statusCode == 200 ) print ( "Uploaded!" );
// });
// dio.post("${HOST}api/user/img/" , data:  ( new File( "./upload.jpg" ), "upload1.jpg" ) );
// final response =
//     await client.post("${HOST}api/user/img/", body: formData, headers: headers);
// if (response != null && response.statusCode == 200) {
//   final jsonBody = jsonDecode(response.body);
//   if (jsonBody['success'] as bool) {
//     return jsonBody["imgurl"] as String;
//   } else {
//     print(jsonBody["message"]);
//     return "";
//   }
// }
// return "";
// open a byteStream
