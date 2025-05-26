import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_guardian_v2_rebuild_complete/controllers/auth_controller.dart';
import 'package:pills_guardian_v2_rebuild_complete/routes.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/widgets/custom_button.dart';
import 'package:pills_guardian_v2_rebuild_complete/ui/widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bienvenido de nuevo 👋',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomTextField(
              controller: emailController,
              label: 'Correo electrónico',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: passwordController,
              label: 'Contraseña',
              icon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 32),
            Obx(
              () =>
                  _authController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                        label: 'Iniciar sesión',
                        onPressed: () {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            Get.snackbar(
                              'Campos requeridos',
                              'Por favor completa todos los campos',
                            );
                          } else {
                            _authController.login(email, password);
                          }
                        },
                      ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.register);
              },
              child: const Text('¿No tienes cuenta? Regístrate aquí'),
            ),
          ],
        ),
      ),
    );
  }
}
