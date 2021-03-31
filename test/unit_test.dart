import 'package:ChatUI/admin/screens/admin_page.dart';
import 'package:ChatUI/home/datas/shared_pref.dart';
import 'package:ChatUI/user/widgets/auth_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ChatUI/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('empty email returns error string', () {
    final result = EmailFieldValidator.validate('');
    expect(result, 'Email Can Not Be Empty');
  });

  test('non-empty email returns null', () {
    final result = EmailFieldValidator.validate('email');
    expect(result, null);
  });

  test('empty password returns error string', () {
    final result = PasswordFieldValidator.validate('');
    expect(result, 'Password Can Not Be Empty');
  });

  test('non-empty password returns null', () {
    final result = PasswordFieldValidator.validate('password');
    expect(result, null);
  });

  test('non-empty index returns index', () {
    //Indexe Passed For Navigation Drawer
    final result = OnSelectedValidator.validate(1);
    expect(result, 1);
  });

  test('empty index returns zero', () {
    final result = OnSelectedValidator.validate(0);
    expect(result, 0);
  });
  test('get file path', () {
    //  final SharedPreferences _preferences;
    SharedPrefHandler _handler;
    Future<String> filepathh = "/home" as Future<String>;

    SharedPreferences _preferences;
    SharedPrefHandler shr = new SharedPrefHandler(_preferences);
    var filePath = shr.getFilePath();
    final result = filePath;
    expect(result, filepathh);
  });

  test('get file path', () {
    //  final SharedPreferences _preferences;
    SharedPrefHandler _handler;
    Future<String> filepathh = "/home" as Future<String>;
    String filepathhh = '/home';

    SharedPreferences _preferences;
    SharedPrefHandler shr = new SharedPrefHandler(_preferences);
    var filePath = shr.setFilePath(filepathhh);
    // final result = SharedPrefHandler.FILE_PATH = filepathhh;
    //  expect(result, filepathh);
   
  });
}
