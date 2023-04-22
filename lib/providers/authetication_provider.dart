import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smartpay_mobile/server_interactions/datasource/auth_source.dart';

import '../server_interactions/repository/auth_repository.dart';
import '../utils/helper.dart';
import '../utils/secure_storage.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authDataSource = getIt.get<AuthDataSource>();
  final storageSource = getIt.get<SecureStorage>();
  return AuthRepository(authDataSource, storageSource);
});

final emaillCheckingButtonProvider = StateProvider<bool>((ref) => false);

final verifyEmaillCheckingButtonProvider = StateProvider<bool>((ref) => false);

final loginCheckingButtonProvider = StateProvider<bool>((ref) => false);

final registerCheckingButtonProvider = StateProvider<bool>((ref) => false);
// class RepositoryProviderCalls {
//   static Future<String> getEmailToken(AuthRepository ref, String email) async {
//     //final repository = ref.read(authRepositoryProvider);
//     final response = await ref.getEmailToken(email: email);

//     return response;
//   }
// }

// final emailTokenProvider = FutureProvider<String>((ref) async {
//   final repository = ref.read(authRepositoryProvider);
//   final email = ref.read(emailProvider);

//   final response = await repository.getEmailToken(email: email);
//   // final String? token;
//   return response.fold((err) => err, (data) {
//     return data;
//   });
// });

final emaillCheckingProvider =
    StateNotifierProvider<EmailCheckProvider, bool>((ref) {
  return EmailCheckProvider(ref);
});

class EmailCheckProvider extends StateNotifier<bool> {
  EmailCheckProvider(this.ref) : super(false);

  final Ref ref;

  Future<bool> getEmailToken(String email) async {
    // Counter can use the "ref" to read other providers
    final repository = ref.read(authRepositoryProvider);

    final response = await repository.getEmailToken(email: email);

    return response.isRight();
  }

  Future<bool> verifyEmailToken(String email, String token) async {
    // Counter can use the "ref" to read other providers
    final repository = ref.read(authRepositoryProvider);

    final response =
        await repository.verifyEmailToken(email: email, token: token);

    return response.isRight();
  }

  Future<bool> login(String email, String password) async {
    // Counter can use the "ref" to read other providers
    final repository = ref.read(authRepositoryProvider);

    final response = await repository.login(email: email, password: password);

    return response.isRight();
  }

  Future<bool> register(
    String email,
    String password,
    String fullName,
    String username,
    String country,
  ) async {
    // Counter can use the "ref" to read other providers
    final repository = ref.read(authRepositoryProvider);

    final response = await repository.register(
      fullname: fullName,
      username: username,
      email: email,
      country: country,
      password: password,
    );

    return response.isRight();
  }
}
