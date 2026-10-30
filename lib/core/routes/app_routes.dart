import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/navigation/cubit/main_cubit.dart';
import 'package:shoply_admin/core/navigation/main_screen.dart';
import 'package:shoply_admin/core/routes/app_pages.dart';
import 'package:shoply_admin/features/customers/repo/customers_repo.dart';
import 'package:shoply_admin/features/customers/view/customers_screen.dart';
import 'package:shoply_admin/features/customers/view_model/customers_cubit.dart';
import 'package:shoply_admin/features/forgot_password/view/forgot_password_screen.dart';
import 'package:shoply_admin/features/login/view/login_screen.dart';
import 'package:shoply_admin/features/orders/repo/orders_repo.dart';
import 'package:shoply_admin/features/signup/view/signup_screen.dart';
import 'package:shoply_admin/features/splash/view/splash_screen.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppPages.splashScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );

      case AppPages.loginScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        );

      case AppPages.signupScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const SignupScreen();
          },
        );

      case AppPages.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const ForgotPasswordScreen();
          },
        );

      case AppPages.homeScreen:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<MainCubit>(
              create: (_) => MainCubit(),
              child: const MainScreen(),
            );
          },
        );

      case AppPages.customersScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => CustomersCubit(
              customersRepo: CustomersRepo(),
              ordersRepo: OrdersRepo(),
            )..loadCustomers(),
            child: const CustomersScreen(),
          ),
        );
    }
    return null;
  }
}
