import 'package:block_for_managing_state/third_example/model.dart';
import 'package:flutter/foundation.dart' show immutable;
 
@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();

  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

@immutable
class LoginApi implements LoginApiProtocol {
  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => email == 'foo@bar.com' && password == 'foobar',
      ).then((isLoggedIn) => isLoggedIn ? const LoginHandle.fooBar() : null);
}