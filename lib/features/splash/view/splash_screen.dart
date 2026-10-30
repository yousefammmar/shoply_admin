import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/routes/app_pages.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';
import 'package:shoply_admin/features/splash/view_model/cubit.dart';
import 'package:shoply_admin/features/splash/view_model/state.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..goNextPage(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashLoginPageState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.loginScreen,
                (route) => false,
              );
            } else if (state is SplashHomePageState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.homeScreen,
                (route) => false,
              );
            }
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: AppColors.onPrimary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 65,
                    color: AppColors.onPrimary,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Shoply',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onPrimary,
                  ),
                ),
                Text(
                  context.l10n.sellerApp,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
