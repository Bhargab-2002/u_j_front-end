import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F6),
      body: Column(
        children: [
          // 🔷 TOP DARK BLUE BAR
          Container(
            height: 70,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            color: const Color(0xFF1F2A37),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.white),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // 🔷 PAGE CONTENT
          Expanded(
            child: Center(
              child: Container(
                width: width > 900 ? 900 : width * 0.95,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFBFC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView(
                  children: [
                    _sectionTitle('Account'),
                    _settingTile(
                      icon: Icons.person,
                      title: 'Profile',
                      subtitle: 'Update personal details',
                      onTap: () {},
                    ),
                    _settingTile(
                      icon: Icons.lock,
                      title: 'Change Password',
                      subtitle: 'Update your login password',
                      onTap: () {},
                    ),

                    const SizedBox(height: 30),

                    _sectionTitle('Preferences'),
                    _settingTile(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      subtitle: 'Manage notification preferences',
                      onTap: () {},
                    ),
                    _settingTile(
                      icon: Icons.language,
                      title: 'Language',
                      subtitle: 'Change app language',
                      onTap: () {},
                    ),

                    const SizedBox(height: 30),

                    _sectionTitle('Security'),
                    _settingTile(
                      icon: Icons.security,
                      title: 'Privacy & Security',
                      subtitle: 'Control privacy settings',
                      onTap: () {},
                    ),

                    const SizedBox(height: 40),

                    // LOGOUT
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(
                            context,
                                (route) => route.isFirst,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔧 Helpers

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
