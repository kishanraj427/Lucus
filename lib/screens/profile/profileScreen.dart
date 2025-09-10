import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucus/models/user.dart';
import 'package:lucus/screens/profile/settingsSection.dart';
import 'package:lucus/screens/profile/supportSection.dart';
import 'package:lucus/utility/appColor.dart';
import 'package:lucus/screens/profile/profileCard.dart';
import 'package:lucus/notifier/authNotifier.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {
              // Navigate to chat or show placeholder
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Chat feature coming soon!')),
              );
            },
          ),
        ],
      ),
      body: authState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : authState.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: ${authState.error}'),
                      ElevatedButton(
                        onPressed: () =>
                            ref.read(authNotifier.notifier).fetchUserProfile(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      ProfileCard(
                        user: authState.user ??
                            const User(
                              id: '1',
                              name: 'Ethan Carter',
                              email: 'ethan.carter@email.com',
                              avatarUrl:
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCZEn-zcjreXKytJSCBafrLYOvsZ_PrCOzG1_z7Cee6n6IlNT_VwhqlBogF3a__WKhtbSzklMJdjbM5tVz8A7iNt5EMmQkpHo5om9F1KnROXL4gDga9ocJhun4N4GuxKjVGxevg_sQND-IjVerFBipx3sYVKMNw_zIb7eaPdNgu3hq6XZTufaraMzm-hO4qcZhPCvYfXUBRC9D15_HPRHVdXNXtFOnWG7FRNyvOBhZDMDB44O-wilCZpHebM1bb7WpKnYaEneu_Ox8',
                            ),
                        onEdit: () {
                          // Navigate to edit profile
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Edit profile coming soon!')),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      SettingsSection(),
                      const SizedBox(height: 24),
                      SupportSection(),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: () async {
                          await ref.read(authNotifier.notifier).logout();
                          // Navigate to login or home
                          context.go('/');
                        },
                        child: const Text(
                          'Log Out',
                          style: TextStyle(
                            color: AppColors.primary600,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
    );
  }
}
