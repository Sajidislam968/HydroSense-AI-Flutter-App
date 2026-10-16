import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/status_pill.dart';
import 'nodes_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: [
          Text('Profile', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),

          DashboardCard(
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF2FD66D), AppColors.greenDark],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('RS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 19)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Rafi Sultana', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5)),
                      Text('rafi@hydrosense.ai', style: TextStyle(fontSize: 11.5, color: AppColors.ink500)),
                      SizedBox(height: 6),
                      StatusPill(label: 'Farm Admin', tone: PillTone.green),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const _SectionLabel('Preferences'),
          DashboardCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _ProfileTile(
                  icon: Icons.notifications_none_rounded,
                  iconColor: AppColors.blue,
                  iconBackground: AppColors.blueTint,
                  label: 'Notification Settings',
                  onTap: () {},
                ),
                const Divider(indent: 14, endIndent: 14, height: 1),
                _ProfileTile(
                  icon: Icons.palette_outlined,
                  iconColor: AppColors.purple,
                  iconBackground: AppColors.purpleTint,
                  label: 'Theme Settings',
                  trailing: 'Light',
                  onTap: () {},
                ),
                const Divider(indent: 14, endIndent: 14, height: 1),
                _ProfileTile(
                  icon: Icons.developer_board_rounded,
                  iconColor: AppColors.teal,
                  iconBackground: AppColors.tealTint,
                  label: 'Device Management',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ConnectedNodesScreen()),
                  ),
                ),
              ],
            ),
          ),

          const _SectionLabel('Account'),
          DashboardCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _ProfileTile(
                  icon: Icons.person_outline_rounded,
                  iconColor: AppColors.greenDark,
                  iconBackground: AppColors.greenLight,
                  label: 'Edit Profile',
                  onTap: () {},
                ),
                const Divider(indent: 14, endIndent: 14, height: 1),
                _ProfileTile(
                  icon: Icons.logout_rounded,
                  iconColor: AppColors.red,
                  iconBackground: AppColors.redTint,
                  label: 'Logout',
                  labelColor: AppColors.red,
                  showChevron: false,
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.ink500, letterSpacing: 0.5),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String label;
  final String? trailing;
  final Color? labelColor;
  final bool showChevron;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.label,
    required this.onTap,
    this.trailing,
    this.labelColor,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: iconBackground, borderRadius: BorderRadius.circular(9)),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: labelColor ?? AppColors.ink900),
              ),
            ),
            if (trailing != null)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(trailing!, style: const TextStyle(fontSize: 11, color: AppColors.ink500, fontWeight: FontWeight.w600)),
              ),
            if (showChevron) const Icon(Icons.chevron_right_rounded, color: AppColors.ink300, size: 20),
          ],
        ),
      ),
    );
  }
}
