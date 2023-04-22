import 'package:smartpay_mobile/utils/constants.dart';
import 'package:smartpay_mobile/utils/helper.dart';

import '../../api/abstract_api.dart';
import '../../api/api_client.dart';
import '../../utils/endpoints.dart';
import '../../utils/error_handler.dart';

class AuthDataSource {
  AuthDataSource(this.client);
  final ApiClient client;

  Future<AbstractApiResponse> getEmailToken({
    required String email,
  }) async {
    try {
      final data = {'email': email};

      //client.header = {'Accept': 'application/json'};
      final result = await client.post('http://146.190.74.11/api/v1/auth/email',
          params: data);
      final output = handleResponse(result);
      return output;
    } catch (e) {
      kToastMsgPopUp(NetworkExceptions.getDioException(e));
      return AbstractApiResponse();
    }
  }

  Future<AbstractApiResponse> verifyEmailToken({
    required String email,
    required String token,
  }) async {
    try {
      final data = {'email': email, 'token': token};

      client.header = {'Accept': 'application/json'};
      final result = await client
          .post('http://146.190.74.11/api/v1/auth/email/verify', params: data);
      final output = handleResponse(result);
      return output;
    } catch (e) {
      NetworkExceptions.getDioException(e);
      kToastMsgPopUp(NetworkExceptions.getDioException(e));
      return AbstractApiResponse();
    }
  }

  Future<AbstractApiResponse> register({
    required String fullname,
    required String username,
    required String email,
    required String country,
    required String password,
  }) async {
    //final String deviceName = await Helper.deviveName;
    try {
      final data = {
        'full_name': fullname,
        'username': username,
        'email': email,
        'country': country,
        'password': password,
        'device_name': 'app'
      };

      client.header = {'Accept': 'application/json'};
      final result = await client
          .post('http://146.190.74.11/api/v1/auth/register', params: data);
      final output = handleResponse(result);
      return output;
    } catch (e) {
      kToastMsgPopUp(NetworkExceptions.getDioException(e));
      return AbstractApiResponse();
    }
  }

  Future<AbstractApiResponse> login({
    required String email,
    required String password,
  }) async {
    // final String deviceName = await Helper.deviveName;
    try {
      final data = {'email': email, 'password': password, 'device_name': 'app'};

      client.header = {'Accept': 'application/json'};
      final result = await client.post(
        'http://146.190.74.11/api/v1/auth/login',
        params: data,
      );
      final output = handleResponse(result);
      return output;
    } catch (e) {
      kToastMsgPopUp(NetworkExceptions.getDioException(e));
      return AbstractApiResponse();
    }
  }

  Future<AbstractApiResponse> dashboard() async {
    try {
      final token = await Helper.token;
      client.header = {'Authorization': 'Bearer $token'};
      final result = await client.get(Endpoints.dashboard);
      final output = handleResponse(result);
      return output;
    } catch (e) {
      kToastMsgPopUp(NetworkExceptions.getDioException(e));
      return AbstractApiResponse();
    }
  }

  Future<AbstractApiResponse> logout() async {
    try {
      client.header = {'Accept': 'application/json'};
      final result = await client.post(Endpoints.register);
      final output = handleResponse(result);
      return output;
    } catch (e) {
      kToastMsgPopUp(NetworkExceptions.getDioException(e));
      return AbstractApiResponse();
    }
  }
}
