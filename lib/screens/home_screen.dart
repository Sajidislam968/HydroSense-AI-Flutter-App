import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/sensor_card.dart';
import '../widgets/status_pill.dart';
import '../widgets/dashboard_card.dart';
import 'analytics_screen.dart';
import 'prediction_screen.dart';
import 'alerts_screen.dart';
import 'profile_screen.dart';
import 'sensor_detail_screen.dart';

/// Hosts the 5 primary tabs (Home, Analytics, Prediction, Alerts, Profile)
/// behind a single [BottomNavBar], preserving state via [IndexedStack].
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _screens = [
    HomeDashboardScreen(),
    AnalyticsScreen(),
    PredictionScreen(),
    AlertsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _index,
        alertCount: 3,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _HeaderCard()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 4),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Text('🌿  Live Sensor Overview', style: Theme.of(context).textTheme.titleMedium),
                  const Spacer(),
                  const Text('Real-time ●', style: TextStyle(fontSize: 11, color: AppColors.ink500, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.35,
              ),
              delegate: SliverChildListDelegate(_buildSensorCards(context)),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            sliver: SliverToBoxAdapter(child: _HealthScoreCard()),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            sliver: SliverToBoxAdapter(
              child: Text('🥬  Plant Status', style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(child: _PlantStatusCard()),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 30),
            sliver: SliverToBoxAdapter(child: _RecommendationCard()),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSensorCards(BuildContext context) {
    void openDetail(String name) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SensorDetailScreen(sensorName: name)),
      );
    }

    return [
      SensorCard(
        label: 'Temperature',
        value: '28.4',
        unit: '°C',
        icon: Icons.thermostat_rounded,
        iconColor: const Color(0xFFE35B4F),
        iconBackground: AppColors.redTint,
        statusLabel: 'Normal',
        onTap: () => openDetail('Temperature'),
      ),
      SensorCard(
        label: 'Humidity',
        value: '65',
        unit: '%',
        icon: Icons.water_drop_rounded,
        iconColor: AppColors.blue,
        iconBackground: AppColors.blueTint,
        statusLabel: 'Normal',
        onTap: () => openDetail('Humidity'),
      ),
      SensorCard(
        label: 'pH Level',
        value: '6.25',
        icon: Icons.science_rounded,
        iconColor: AppColors.purple,
        iconBackground: AppColors.purpleTint,
        statusLabel: 'Optimal',
        onTap: () => openDetail('pH Level'),
      ),
      SensorCard(
        label: 'Dissolved O₂',
        value: '7.8',
        unit: 'mg/L',
        icon: Icons.bubble_chart_rounded,
        iconColor: AppColors.teal,
        iconBackground: AppColors.tealTint,
        statusLabel: 'Optimal',
        onTap: () => openDetail('Dissolved Oxygen'),
      ),
      SensorCard(
        label: 'EC / TDS',
        value: '1.32',
        unit: 'mS/cm',
        icon: Icons.speed_rounded,
        iconColor: AppColors.amber,
        iconBackground: AppColors.amberTint,
        statusLabel: 'Normal',
        onTap: () => openDetail('EC / TDS'),
      ),
      SensorCard(
        label: 'NPK (N-P-K)',
        value: '120·45·190',
        icon: Icons.grass_rounded,
        iconColor: AppColors.greenDark,
        iconBackground: AppColors.greenLight,
        statusLabel: 'Optimal',
        onTap: () => openDetail('NPK'),
      ),
      SensorCard(
        label: 'Water Level',
        value: '72',
        unit: '%',
        icon: Icons.opacity_rounded,
        iconColor: AppColors.blue,
        iconBackground: AppColors.blueTint,
        statusLabel: 'Normal',
        onTap: () => openDetail('Water Level'),
      ),
      SensorCard(
        label: 'Pump Status',
        value: 'ON',
        icon: Icons.settings_input_component_rounded,
        iconColor: AppColors.greenDark,
        iconBackground: AppColors.greenLight,
        subtitle: 'Since 10:15 AM',
        onTap: () => openDetail('Pump Status'),
      ),
    ];
  }
}

class _HeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.greenLight, AppColors.background],
        ),
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tuesday, 22 July', style: TextStyle(fontSize: 11.5, color: AppColors.ink500, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text('10:30 AM', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                const StatusPill(label: 'System Online', tone: PillTone.green),
              ],
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.wb_cloudy_rounded, color: AppColors.ink700, size: 24),
              SizedBox(height: 2),
              Text('28°C', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              Text('Partly Cloudy', style: TextStyle(fontSize: 10, color: AppColors.ink500)),
            ],
          ),
        ],
      ),
    );
  }
}

class _HealthScoreCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Row(
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 0.91,
                  strokeWidth: 5,
                  backgroundColor: AppColors.line,
                  valueColor: const AlwaysStoppedAnimation(AppColors.green),
                ),
                const Text('91', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('System Health Score', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                SizedBox(height: 2),
                Text('Excellent condition · 3 nodes online', style: TextStyle(fontSize: 11.5, color: AppColors.ink500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlantStatusCard extends StatelessWidget {
  const _PlantStatusCard();

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(color: AppColors.greenLight, shape: BoxShape.circle),
            child: const Icon(Icons.eco_rounded, color: AppColors.greenDark, size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Expanded(
                      child: Text('Vegetative Stage', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                    ),
                    StatusPill(label: '72%', tone: PillTone.blue, showDot: false),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const LinearProgressIndicator(
                    value: 0.72,
                    minHeight: 6,
                    backgroundColor: AppColors.line,
                    valueColor: AlwaysStoppedAnimation(AppColors.greenDark),
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Est. harvest in 11 days · Health 91/100',
                  style: TextStyle(fontSize: 10.5, color: AppColors.ink300, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard();

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      color: AppColors.greenTint,
      borderColor: const Color(0xFFDCF3E4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Icon(Icons.lightbulb_rounded, size: 18, color: AppColors.amber),
              SizedBox(width: 7),
              Text('Current Recommendation', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
            ],
          ),
          SizedBox(height: 10),
          _RecoLine('Increase nutrient solution'),
          SizedBox(height: 6),
          _RecoLine('Reduce water temperature'),
          SizedBox(height: 6),
          _RecoLine('Maintain DO above 6 mg/L'),
        ],
      ),
    );
  }
}

class _RecoLine extends StatelessWidget {
  final String text;
  const _RecoLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('•  ', style: TextStyle(color: AppColors.greenDark, fontWeight: FontWeight.w800)),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 12, color: AppColors.ink700))),
      ],
    );
  }
}
