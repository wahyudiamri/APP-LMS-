import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../data/models/login_request.dart';
import '../widgets/login_form.dart';
import '../widgets/help_bottom_sheet.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Help',
            onSelected: (language) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => HelpBottomSheet(language: language),
              );
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'id',
                child: Text('Bantuan (ID)'),
              ),
              const PopupMenuItem<String>(
                value: 'en',
                child: Text('Help (EN)'),
              ),
            ],
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigate to home page or dashboard
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                const Text(
                  'Welcome to LMS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Demo Credentials: ADMIN / 12345678',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),
                LoginForm(
                  onLogin: (email, password) {
                    context.read<AuthBloc>().add(
                          LoginRequested(
                            LoginRequest(email: email, password: password),
                          ),
                        );
                  },
                ),
              ],
          ),
        ),
      ),
    );
  }
}