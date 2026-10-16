import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum PillTone { green, amber, red, blue, neutral }

/// Small color-coded status pill, e.g. "Normal", "Optimal", "High".
/// Used across sensor cards, alerts, and node status indicators.
class StatusPill extends StatelessWidget {
  final String label;
  final PillTone tone;
  final bool showDot;

  const StatusPill({
    super.key,
    required this.label,
    this.tone = PillTone.green,
    this.showDot = true,
  });

  _ToneColors get _colors {
    switch (tone) {
      case PillTone.green:
        return _ToneColors(AppColors.greenLight, AppColors.greenDark, AppColors.green);
      case PillTone.amber:
        return _ToneColors(AppColors.amberTint, const Color(0xFFA5610A), AppColors.amber);
      case PillTone.red:
        return _ToneColors(AppColors.redTint, const Color(0xFFC62828), AppColors.red);
      case PillTone.blue:
        return _ToneColors(AppColors.blueTint, const Color(0xFF1D4ED8), AppColors.blue);
      case PillTone.neutral:
        return _ToneColors(const Color(0xFFF0F2F0), AppColors.ink500, AppColors.ink300);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: c.background,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(color: c.dot, shape: BoxShape.circle),
            ),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              color: c.text,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ToneColors {
  final Color background;
  final Color text;
  final Color dot;
  _ToneColors(this.background, this.text, this.dot);
}
