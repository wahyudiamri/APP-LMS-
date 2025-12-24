import 'package:flutter/material.dart';
import '../../core/constants';

class HelpBottomSheet extends StatelessWidget {
  final String language;

  const HelpBottomSheet({
    super.key,
    this.language = 'id', // 'id' for Indonesian, 'en' for English
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.help_outline,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _getLocalizedText('title'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Help Content
          _buildHelpSection(
            icon: Icons.login,
            title: _getLocalizedText('login_title'),
            content: _getLocalizedText('login_content'),
          ),
          const SizedBox(height: 16),

          _buildHelpSection(
            icon: Icons.dashboard,
            title: _getLocalizedText('dashboard_title'),
            content: _getLocalizedText('dashboard_content'),
          ),
          const SizedBox(height: 16),

          _buildHelpSection(
            icon: Icons.logout,
            title: _getLocalizedText('logout_title'),
            content: _getLocalizedText('logout_content'),
          ),
          const SizedBox(height: 16),

          _buildHelpSection(
            icon: Icons.info,
            title: _getLocalizedText('about_title'),
            content: _getLocalizedText('about_content'),
          ),
          const SizedBox(height: 24),

          // Contact Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.contact_support,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _getLocalizedText('contact_title'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _getLocalizedText('contact_content'),
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Close Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _getLocalizedText('close_button'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getLocalizedText(String key) {
    final Map<String, Map<String, String>> localizedTexts = {
      'id': {
        'title': 'Bantuan',
        'login_title': 'Login ke Aplikasi',
        'login_content': 'Masukkan username "ADMIN" dan password "12345678" untuk masuk ke aplikasi LMS.',
        'dashboard_title': 'Dashboard',
        'dashboard_content': 'Setelah login, Anda akan diarahkan ke dashboard utama yang menampilkan ringkasan kursus dan aktivitas belajar.',
        'logout_title': 'Logout',
        'logout_content': 'Klik ikon logout di pojok kanan atas untuk keluar dari aplikasi.',
        'about_title': 'Tentang Aplikasi',
        'about_content': 'Aplikasi Learning Management System (LMS) ini dirancang untuk membantu proses belajar mengajar secara digital.',
        'contact_title': 'Butuh Bantuan Lebih Lanjut?',
        'contact_content': 'Hubungi tim support kami untuk mendapatkan bantuan teknis atau informasi lebih detail tentang penggunaan aplikasi.',
        'close_button': 'Tutup',
      },
      'en': {
        'title': 'Help',
        'login_title': 'Login to Application',
        'login_content': 'Enter username "ADMIN" and password "12345678" to access the LMS application.',
        'dashboard_title': 'Dashboard',
        'dashboard_content': 'After logging in, you will be directed to the main dashboard that displays course summaries and learning activities.',
        'logout_title': 'Logout',
        'logout_content': 'Click the logout icon in the top right corner to exit the application.',
        'about_title': 'About Application',
        'about_content': 'This Learning Management System (LMS) application is designed to help the digital teaching and learning process.',
        'contact_title': 'Need More Help?',
        'contact_content': 'Contact our support team to get technical assistance or more detailed information about using the application.',
        'close_button': 'Close',
      },
    };

    return localizedTexts[language]?[key] ?? key;
  }
}