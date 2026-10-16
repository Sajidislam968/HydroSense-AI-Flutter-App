import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/status_pill.dart';
import '../models/models.dart';

class ConnectedNodesScreen extends StatelessWidget {
  const ConnectedNodesScreen({super.key});

  static const _nodes = [
    NodeInfo(
      name: 'Node-1 · Water Quality',
      code: 'ESP32-WQ01',
      icon: Icons.water_drop_rounded,
      color: AppColors.blue,
      background: AppColors.blueTint,
      online: true,
      sensors: ['pH 6.25', 'DO 7.8 mg/L'],
    ),
    NodeInfo(
      name: 'Node-2 · Nutrient',
      code: 'ESP32-NT02',
      icon: Icons.grass_rounded,
      color: AppColors.greenDark,
      background: AppColors.greenLight,
      online: true,
      sensors: ['NPK 120·45·190', 'EC/TDS 1.32'],
    ),
    NodeInfo(
      name: 'Node-3 · Environment',
      code: 'ESP32-EN03',
      icon: Icons.dashboard_rounded,
      color: Color(0xFFC17A09),
      background: AppColors.amberTint,
      online: true,
      sensors: ['DHT22', 'Water Level', 'PIR Motion', 'Pump Relay'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connected Nodes')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
          children: [
            const Text('3 of 3 ESP32 nodes online', style: TextStyle(fontSize: 12, color: AppColors.ink500)),
            const SizedBox(height: 16),
            ..._nodes.map((n) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _NodeCard(node: n),
                )),
            DashboardCard(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_rounded, size: 18, color: AppColors.ink500),
                  SizedBox(width: 8),
                  Text('Add New Node', style: TextStyle(color: AppColors.ink500, fontWeight: FontWeight.w700, fontSize: 12.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NodeCard extends StatelessWidget {
  final NodeInfo node;
  const _NodeCard({required this.node});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(color: node.background, borderRadius: BorderRadius.circular(11)),
                child: Icon(node.icon, size: 19, color: node.color),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(node.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                    Text(node.code, style: const TextStyle(fontSize: 10.5, color: AppColors.ink500)),
                  ],
                ),
              ),
              StatusPill(label: node.online ? 'Online' : 'Offline', tone: node.online ? PillTone.green : PillTone.red),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: node.sensors
                .map((s) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: const Color(0xFFF0F2F0), borderRadius: BorderRadius.circular(100)),
                      child: Text(s, style: const TextStyle(fontSize: 11, color: AppColors.ink700, fontWeight: FontWeight.w600)),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
