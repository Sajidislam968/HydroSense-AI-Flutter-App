import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/sensor_card.dart';

class PredictionScreen extends StatelessWidget {
  const PredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: [
          Text('AI Prediction',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 2),
          const Text('Powered by HydroSense Prediction Engine',
              style: TextStyle(fontSize: 12, color: AppColors.ink500)),
          const SizedBox(height: 16),
          DashboardCard(
            padding: const EdgeInsets.all(22),
            color: const Color(0xFF0E2C19),
            borderColor: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: 0.95,
                        strokeWidth: 10,
                        backgroundColor:
                            Colors.white.withAlpha((0.12 * 255).round()),
                        valueColor:
                            const AlwaysStoppedAnimation(Color(0xFF4ADE80)),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('95%',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30,
                                  color: Colors.white)),
                          Text('Predicted Growth',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFFA7C4AF),
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Final yield projection · Confidence 88%',
                  style: TextStyle(color: Color(0xFFC9DCCF), fontSize: 11.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: SensorCard(
                  label: 'Est. Harvest',
                  value: '11',
                  unit: 'days',
                  icon: Icons.calendar_month_rounded,
                  iconColor: AppColors.blue,
                  iconBackground: AppColors.blueTint,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SensorCard(
                  label: 'Disease Risk',
                  value: 'Low',
                  icon: Icons.shield_rounded,
                  iconColor: AppColors.greenDark,
                  iconBackground: AppColors.greenLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DashboardCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Confidence Score',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: const LinearProgressIndicator(
                    value: 0.88,
                    minHeight: 8,
                    backgroundColor: AppColors.line,
                    valueColor: AlwaysStoppedAnimation(AppColors.greenDark),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Model trained on 42k readings',
                        style:
                            TextStyle(fontSize: 10.5, color: AppColors.ink500)),
                    Text('88%',
                        style: TextStyle(
                            fontSize: 11.5, fontWeight: FontWeight.w800)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          DashboardCard(
            color: AppColors.greenTint,
            borderColor: const Color(0xFFDCF3E4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.smart_toy_rounded,
                        size: 18, color: AppColors.greenDark),
                    SizedBox(width: 7),
                    Text('AI Recommendation',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 9),
                const Text(
                  'Increase nutrient concentration by 8% and lower water temperature by 1.5°C to keep dissolved oxygen stable through the next growth phase.',
                  style: TextStyle(
                      fontSize: 12, color: AppColors.ink700, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          DashboardCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.menu_book_rounded,
                        size: 18, color: AppColors.ink700),
                    SizedBox(width: 7),
                    Text('Why this prediction?',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Growth trajectory, EC stability, and 72-hour DO trend were weighted most heavily. NPK ratios remain within the optimal band for the vegetative stage.',
                  style: TextStyle(
                      fontSize: 11.5, color: AppColors.ink500, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
