import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/controllers/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  final AuthController _authController = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrarse'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Crear una cuenta 📝',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomTextField(
              controller: emailController,
              label: 'Correo electrónico',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: passwordController,
              label: 'Contraseña',
              icon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: confirmPasswordController,
              label: 'Confirmar Contraseña',
              icon: Icons.lock_outline,
              obscureText: true,
            ),
            const SizedBox(height: 32),
            Obx(
              () =>
                  _authController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                        label: 'Registrarse',
                        onPressed: () {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();
                          final confirmPassword =
                              confirmPasswordController.text.trim();

                          if (email.isEmpty ||
                              password.isEmpty ||
                              confirmPassword.isEmpty) {
                            Get.snackbar(
                              'Campos requeridos',
                              'Por favor completa todos los campos',
                            );
                            return;
                          }

                          if (password != confirmPassword) {
                            Get.snackbar(
                              'Error de contraseña',
                              'Las contraseñas no coinciden',
                            );
                            return;
                          }

                          _authController.register(email, password);
                        },
                      ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('¿Ya tienes cuenta? Inicia sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
