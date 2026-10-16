import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Generic white rounded card container used across dashboard, alerts,
/// prediction, and profile screens for consistent elevation/spacing.
class DashboardCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Color? borderColor;
  final VoidCallback? onTap;
  final Gradient? gradient;

  const DashboardCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color,
    this.borderColor,
    this.onTap,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: gradient == null ? (color ?? AppColors.surface) : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: borderColor ?? AppColors.line),
            boxShadow: [
              BoxShadow(
                color: AppColors.ink900.withAlpha((0.04 * 255).round()),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
