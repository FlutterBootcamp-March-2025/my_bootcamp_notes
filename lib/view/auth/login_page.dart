import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import 'forgot_password_page.dart';
import 'signup_page.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
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
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              authController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed:
                        () => authController.login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        ),
                    child: Text('Login'),
                  ),
              TextButton(
                onPressed: () => Get.to(() => SignupPage()),
                child: Text('Don’t have an account? Sign Up'),
              ),
              TextButton(
                onPressed: () => Get.to(() => ForgotPasswordPage()),
                child: Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
