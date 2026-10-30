import 'package:flutter/material.dart';
import 'package:shoply_admin/core/dependencies/main/main_dependency.dart';
import 'package:shoply_admin/features/app/view/shoply_admin_app.dart';

void main() async {
  await MainDependency.mainInitDependency();

  runApp(const ShoplyAdminApp());
}
