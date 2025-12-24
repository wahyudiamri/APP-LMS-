import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../widgets/help_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LMS Dashboard'),
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
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to Learning Management System!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}