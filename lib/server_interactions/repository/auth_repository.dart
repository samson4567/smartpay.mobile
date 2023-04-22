import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartpay_mobile/model/register_response_model.dart';
import 'package:smartpay_mobile/model/verify_token_model.dart';
import 'package:smartpay_mobile/utils/constants.dart';

import '../../model/get_email_token_model.dart';
import '../../utils/secure_storage.dart';
import '../datasource/auth_source.dart';

class AuthRepository {
  AuthRepository(this.auth, this.storage);
  final AuthDataSource auth;
  final SecureStorage storage;

  // Future<String> getEmailToken({
  //   required String email,
  // }) async {
  //   final res = await auth.getEmailToken(email: email);

  //   if (res.status == true) {
  //     print(res);
  //     print(GetEmailTokenModel.fromJson(res.data).token ?? '');
  //     return GetEmailTokenModel.fromJson(res.data).token ?? '';
  //   } else {
  //     return res.message ?? '';
  //   }
  // }

  Future<Either<String, GetEmailTokenModel>> getEmailToken({
    required String email,
  }) async {
    final res = await auth.getEmailToken(email: email);

    if (res.status == true) {
      print(GetEmailTokenModel.fromJson(res.data).token);
      return Right(GetEmailTokenModel.fromJson(res.data));
    } else {
      kToastMsgPopUp(res.message ?? '');
      return Left(res.message ?? '');
    }
  }

  Future<Either<String, VerifyTokenModel>> verifyEmailToken({
    required String email,
    required String token,
  }) async {
    final res = await auth.verifyEmailToken(email: email, token: token);

    if (res.status == true) {
      return Right(VerifyTokenModel.fromJson(res.data));
    } else {
      kToastMsgPopUp(res.message ?? '');
      return Left(res.message ?? '');
    }
  }

  Future<Either<String, User>> register({
    required String fullname,
    required String username,
    required String email,
    required String country,
    required String password,
  }) async {
    final res = await auth.register(
        fullname: fullname,
        username: username,
        email: email,
        country: country,
        password: password);

    if (res.status == true) {
      storage.writeSecureData(kUserToken, res.data['token']);
      return Right(User.fromJson(res.data['user']));
    } else {
      return Left(res.message ?? '');
    }
  }

  Future<Either<String, User>> login({
    required String email,
    required String password,
  }) async {
    final res = await auth.login(email: email, password: password);

    if (res.status == true) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(kUserToken, res.data['token']);
      // storage.writeSecureData(kUserToken, res.data['token']);
      return Right(User.fromJson(res.data['user']));
    } else {
      return Left(res.message ?? '');
    }
  }

  Future<bool> signOut() async {
    final res = await auth.logout();

    if (res.status == true) {
      return true;
    } else {
      kToastMsgPopUp(res.message ?? '');
      return false;
    }
  }

  Future<bool> dashboard() async {
    final res = await auth.dashboard();

    if (res.status == true) {
      return true;
    } else {
      return false;
    }
  }
}
