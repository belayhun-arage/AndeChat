import 'package:ChatUI/user/widgets/auth_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ChatUI/main.dart';

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
}
