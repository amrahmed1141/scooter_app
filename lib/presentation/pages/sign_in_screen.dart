import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scooter_app/application/cubit/auth/auth_cubit.dart';
import 'package:scooter_app/application/cubit/auth/auth_state.dart';
import 'package:scooter_app/bottom_navigation.dart';
import 'package:scooter_app/presentation/pages/sign_up_screen.dart';
import 'package:scooter_app/presentation/pages/widgets/my_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNav()));
                }
                if (state is AuthError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                final bool isLoading = state is AuthLoading;
                return Column(
                  children: [
                    Image.asset('assets/icons/Logo (1).png',
                        height: 200, width: 200),
                    const SizedBox(height: 30),
                    const Center(
                        child: Text('Welcome to Scooter App',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 22,
                            ))),
                    const SizedBox(
                      height: 30,
                    ),
                    MyTextfield(
                      hintText: 'Email',
                      obscureText: false,
                      prefixIcon: Icons.mail,
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextfield(
                      hintText: 'Password',
                      obscureText: true,
                      prefixIcon: Icons.lock,
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthCubit>().signIn(
                                    emailController.text.trim(),
                                    passwordController.text.trim());
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade500,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Text(
                              'Sign In',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
