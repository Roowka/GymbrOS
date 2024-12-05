import 'package:flutter/material.dart';
import 'package:gymbros/src/shared/widget/custom_button.dart';
import 'package:gymbros/src/shared/widget/custom_text_field.dart';
import 'package:gymbros/src/shared/utils/constants.dart';
import 'package:gymbros/src/features/auth/service/auth_service.dart';
import 'package:gymbros/src/features/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService loginService = AuthService();

  LoginPage({super.key});

  void _handleLogin(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    final result = await loginService.login(
      email: email,
      password: password,
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await userProvider.loadUser(email);
    final user = userProvider.user;
    if (user != null) {
      print("LOGIN : ${user.toMap()}");
    }
    ;

    if (result == 'Login successful!') {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: () => _handleLogin(context),
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
