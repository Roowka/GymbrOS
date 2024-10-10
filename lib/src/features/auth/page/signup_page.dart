import 'package:flutter/material.dart';
import 'package:gymbros/src/shared/widget/custom_button.dart';
import 'package:gymbros/src/shared/widget/custom_text_field.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Name', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            CustomTextField(
                hintText: 'Enter full name', controller: nameController),
            const SizedBox(height: 20),
            const Text('Email Address', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            CustomTextField(
                hintText: 'Enter email address', controller: emailController),
            const SizedBox(height: 20),
            const Text('Password', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            CustomTextField(
                hintText: 'New password',
                obscureText: true,
                controller: passwordController),
            const SizedBox(height: 20),
            const Text('Confirm Password', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            CustomTextField(
                hintText: 'Confirm password',
                obscureText: true,
                controller: confirmPasswordController),
            const SizedBox(height: 40),
            Center(
              child: CustomButton(
                text: 'Continue',
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
