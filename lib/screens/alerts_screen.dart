import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/status_pill.dart';
import '../models/models.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  Severity? _filter;

  static const _alerts = [
    AlertItem(
      title: 'High Temperature Alert',
      description: 'Temperature is 28.4°C — above optimal range',
      time: '10:20 AM · Node-3',
      node: 'Node-3',
      severity: Severity.high,
      icon: Icons.warning_rounded,
    ),
    AlertItem(
      title: 'Low Water Level',
      description: 'Reservoir dropped below 30% capacity',
      time: '09:45 AM · Node-3',
      node: 'Node-3',
      severity: Severity.medium,
      icon: Icons.water_drop_rounded,
    ),
    AlertItem(
      title: 'Pump Performance',
      description: 'Running longer than normal duty cycle',
      time: '08:50 AM · Node-3',
      node: 'Node-3',
      severity: Severity.high,
      icon: Icons.error_rounded,
    ),
    AlertItem(
      title: 'Motion Detected',
      description: 'Movement logged in growing area',
      time: '09:30 AM · Node-3',
      node: 'Node-3',
      severity: Severity.low,
      icon: Icons.directions_walk_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final visible = _filter == null ? _alerts : _alerts.where((a) => a.severity == _filter).toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: [
          Text('Alerts', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 2),
          const Text('4 events in the last 24 hours', style: TextStyle(fontSize: 12, color: AppColors.ink500)),
          const SizedBox(height: 14),

          SizedBox(
            height: 34,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _FilterChip(label: 'All', selected: _filter == null, onTap: () => setState(() => _filter = null)),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'High',
                  tone: PillTone.red,
                  selected: _filter == Severity.high,
                  onTap: () => setState(() => _filter = Severity.high),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Medium',
                  tone: PillTone.amber,
                  selected: _filter == Severity.medium,
                  onTap: () => setState(() => _filter = Severity.medium),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Low',
                  tone: PillTone.blue,
                  selected: _filter == Severity.low,
                  onTap: () => setState(() => _filter = Severity.low),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          ...visible.map((a) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _AlertCard(alert: a),
              )),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final PillTone? tone;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({required this.label, this.tone, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Color fg;
    if (!selected) {
      bg = const Color(0xFFF0F2F0);
      fg = AppColors.ink500;
    } else if (tone == null) {
      bg = AppColors.ink900;
      fg = Colors.white;
    } else {
      switch (tone!) {
        case PillTone.red:
          bg = AppColors.redTint; fg = const Color(0xFFC62828); break;
        case PillTone.amber:
          bg = AppColors.amberTint; fg = const Color(0xFFA5610A); break;
        case PillTone.blue:
          bg = AppColors.blueTint; fg = const Color(0xFF1D4ED8); break;
        default:
          bg = AppColors.greenLight; fg = AppColors.greenDark;
      }
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(100)),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(color: fg, fontSize: 11.5, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final AlertItem alert;
  const _AlertCard({required this.alert});

  ({Color bg, Color fg, PillTone tone, String label}) get _severityStyle {
    switch (alert.severity) {
      case Severity.high:
        return (bg: AppColors.redTint, fg: const Color(0xFFE04438), tone: PillTone.red, label: 'High');
      case Severity.medium:
        return (bg: AppColors.amberTint, fg: const Color(0xFFC17A09), tone: PillTone.amber, label: 'Medium');
      case Severity.low:
        return (bg: AppColors.blueTint, fg: AppColors.blue, tone: PillTone.blue, label: 'Low');
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _severityStyle;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border(
          left: BorderSide(color: s.fg, width: 4),
          top: const BorderSide(color: AppColors.line),
          right: const BorderSide(color: AppColors.line),
          bottom: const BorderSide(color: AppColors.line),
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(color: s.bg, borderRadius: BorderRadius.circular(10)),
                child: Icon(alert.icon, size: 17, color: s.fg),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(alert.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
                    const SizedBox(height: 2),
                    Text(alert.description, style: const TextStyle(fontSize: 11, color: AppColors.ink500)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              StatusPill(label: s.label, tone: s.tone, showDot: false),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 44),
            child: Text(alert.time, style: const TextStyle(fontSize: 10, color: AppColors.ink300, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
