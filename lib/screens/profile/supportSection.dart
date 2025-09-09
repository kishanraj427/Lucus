import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucus/screens/profile/settingItem.dart';

class SupportSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Support',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          SettingsItem(
            icon: Icons.help_center,
            label: 'Help Center',
            onTap: () => context.go('/profile/help'),
          ),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          SettingsItem(
            icon: Icons.contact_support,
            label: 'Contact Us',
            onTap: () => context.go('/profile/contact'),
          ),
        ],
      ),
    );
  }
}
