import 'dart:async';

import 'package:flutter/material.dart';

import '../../login_model.dart';

/// Bkav DucLQ cac trang thai xac thuc cua tai khoan
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

///
/// Bkav HoangLD cac trang thai khi lay mat khau dang nhap tai khoan bang biometric
enum GetPasswordBiometricStatus { successful, failure, moreThan3, none }
abstract class Repository {

  Future<void> login(LoginRequest request, BuildContext context, String auth);
}