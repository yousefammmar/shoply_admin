import 'package:dartz/dartz.dart';
import 'package:shoply_admin/core/model/login/request_login.dart';
import 'package:shoply_admin/core/model/login/response_login.dart';
import 'package:shoply_admin/core/usecase/login/login_usecase.dart';

class LoginRepo {
  final _loginUsecase = LoginUsecase();

  Future<Either<String, ResponseLogin>> login({
    required RequestLogin requestLogin,
  }) async {
    return await _loginUsecase.login(requestLogin: requestLogin);
  }

  Future<Either<String, ResponseLogin>> loginWithGoogle() async {
    return await _loginUsecase.loginWithGoogle();
  }
}
