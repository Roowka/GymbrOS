import 'package:flutter/material.dart';
import 'package:gymbros/src/shared/widget/custom_button.dart';
import 'package:gymbros/src/shared/widget/custom_text_field.dart';
import 'package:gymbros/src/shared/utils/constants.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(
              image: AssetImage(
                  'lib/src/shared/assets/GYMBROS_LOGO_REMOVEDBG.png'),
              width: 350,
              height: 350,
            ),
            CustomTextField(
                hintText: 'Enter email address', controller: emailController),
            const SizedBox(height: 20),
            CustomTextField(
                hintText: 'Enter password',
                obscureText: true,
                controller: passwordController),
            const SizedBox(height: 30),
            Center(
              child: CustomButton(
                text: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text(
                  'Don\'t have an account? Create Account',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
