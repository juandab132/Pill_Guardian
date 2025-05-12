import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/data/services/appwrite_service.dart';
import 'package:pills_guardian_v2_rebuild_complete/routes.dart';

class AuthController extends GetxController {
  final AppwriteService _appwriteService = AppwriteService();
  var isLoading = false.obs;

  Future<void> register(String email, String password) async {
    try {
      isLoading.value = true;
      await _appwriteService.registerUser(email: email, password: password);
      Get.snackbar('Registro exitoso', 'Ahora puedes iniciar sesión');
      Get.offNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await _appwriteService.loginUser(email: email, password: password);
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar('Error al iniciar sesión', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _appwriteService.logoutUser();
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar('Error al cerrar sesión', e.toString());
    }
  }
}
