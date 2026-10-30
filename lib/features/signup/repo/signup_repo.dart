import 'package:dartz/dartz.dart';
import 'package:shoply_admin/core/usecase/signup/signup_usecase.dart';

class SignupRepo {
  final _signupUsecase = SignupUsecase();

  Future<Either<String, bool>> signup({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return await _signupUsecase.signup(
      fullName: fullName,
      email: email,
      password: password,
    );
  }
}
