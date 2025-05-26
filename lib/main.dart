import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pills_guardian_v2_rebuild_complete/app_theme.dart';
import 'package:pills_guardian_v2_rebuild_complete/controllers/auth_controller.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/hive_service.dart'; // 👈 Importación necesaria
import 'package:pills_guardian_v2_rebuild_complete/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveService().init(); // 👈 Inicialización de HiveService

  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pills Guardian',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.pages,
    );
  }
}
