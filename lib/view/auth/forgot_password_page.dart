import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';

class ForgotPasswordPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              authController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed:
                        () => authController.resetPassword(
                          emailController.text.trim(),
                        ),
                    child: Text('Send Reset Email'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
