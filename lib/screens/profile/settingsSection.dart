import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucus/screens/profile/settingItem.dart';

class SettingsSection extends StatelessWidget {
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
              'Account Settings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937), // text-gray-800
              ),
            ),
          ),
          SettingsItem(
            icon: Icons.person,
            label: 'Personal Information',
            onTap: () => context.go('/profile/personal-info'),
          ),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          SettingsItem(
            icon: Icons.payment,
            label: 'Payment Methods',
            onTap: () => context.go('/profile/payments'),
          ),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          SettingsItem(
            icon: Icons.notifications,
            label: 'Notifications',
            onTap: () => context.go('/profile/notifications'),
          ),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          SettingsItem(
            icon: Icons.security,
            label: 'Security',
            onTap: () => context.go('/profile/security'),
          ),
        ],
      ),
    );
  }
}
