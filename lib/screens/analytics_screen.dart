import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/dashboard_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int _rangeIndex = 0;
  String _sensor = 'Temperature';
  bool _compare = false;

  final _ranges = const ['24 Hours', '7 Days', '30 Days'];
  final _sensors = const ['Temperature', 'Humidity', 'pH', 'DO', 'EC'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Analytics',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 2),
                  const Text('Trends across your growhouse sensors',
                      style: TextStyle(fontSize: 12, color: AppColors.ink500)),
                  const SizedBox(height: 16),
                  _RangeToggle(
                    ranges: _ranges,
                    selected: _rangeIndex,
                    onChanged: (i) => setState(() => _rangeIndex = i),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 34,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _sensors.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        final selected = _sensors[i] == _sensor;
                        return ChoiceChip(
                          label: Text(_sensors[i]),
                          selected: selected,
                          onSelected: (_) =>
                              setState(() => _sensor = _sensors[i]),
                          selectedColor: AppColors.greenLight,
                          labelStyle: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: selected
                                ? AppColors.greenDark
                                : AppColors.ink500,
                          ),
                          backgroundColor: const Color(0xFFF0F2F0),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: DashboardCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(_sensor,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 13)),
                        const Spacer(),
                        const Text('28.4°C ',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 16)),
                        const Text('▲1.2%',
                            style: TextStyle(
                                color: AppColors.greenDark,
                                fontSize: 11,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 110,
                      child: CustomPaint(
                        size: const Size(double.infinity, 110),
                        painter: _LineChartPainter(
                          points: const [70, 55, 60, 40, 48, 30, 38, 20, 28],
                          color: AppColors.greenDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _AxisLabel('12AM'),
                        _AxisLabel('6AM'),
                        _AxisLabel('12PM'),
                        _AxisLabel('6PM'),
                        _AxisLabel('Now'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            sliver: SliverToBoxAdapter(
              child: DashboardCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('NPK Composition',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 13)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 80,
                      child: CustomPaint(
                        size: const Size(double.infinity, 80),
                        painter: _BarChartPainter(),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _AxisLabel('N · 120ppm'),
                        _AxisLabel('P · 45ppm'),
                        _AxisLabel('K · 190ppm'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            sliver: SliverToBoxAdapter(
              child: DashboardCard(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    const Text('Compare sensors',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12.5)),
                    const Spacer(),
                    Switch(
                      value: _compare,
                      activeThumbColor: Colors.white,
                      activeTrackColor: AppColors.green,
                      onChanged: (v) => setState(() => _compare = v),
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
}

class _RangeToggle extends StatelessWidget {
  final List<String> ranges;
  final int selected;
  final ValueChanged<int> onChanged;
  const _RangeToggle(
      {required this.ranges, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: const Color(0xFFF0F2F0),
          borderRadius: BorderRadius.circular(100)),
      child: Row(
        children: List.generate(ranges.length, (i) {
          final active = i == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: active ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: active
                      ? [
                          BoxShadow(
                              color: AppColors.ink900
                                  .withAlpha((0.06 * 255).round()),
                              blurRadius: 8,
                              offset: const Offset(0, 2))
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  ranges[i],
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: active ? AppColors.ink900 : AppColors.ink500,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _AxisLabel extends StatelessWidget {
  final String text;
  const _AxisLabel(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(
          fontSize: 9.5, color: AppColors.ink300, fontWeight: FontWeight.w600));
}

class _LineChartPainter extends CustomPainter {
  final List<double> points;
  final Color color;
  _LineChartPainter({required this.points, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final dx = size.width / (points.length - 1);
    final path = Path();
    final fillPath = Path();
    for (var i = 0; i < points.length; i++) {
      final x = dx * i;
      final y = points[i];
      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withAlpha((0.28 * 255).round()), color.withAlpha(0)],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..strokeWidth = 2.6
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    canvas.drawCircle(
        Offset(size.width, points.last), 4, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) =>
      oldDelegate.points != points;
}

class _BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final heights = [50.0, 65.0, 40.0, 60.0, 45.0, 70.0, 52.0, 62.0];
    final colors = [
      AppColors.greenDark,
      AppColors.greenDark,
      AppColors.greenDark,
      AppColors.green,
      AppColors.green,
      AppColors.green,
      const Color(0xFF86EFAC),
      const Color(0xFF86EFAC),
    ];
    final barWidth = size.width / (heights.length * 1.6);
    final gap = barWidth * 0.6;
    double x = gap / 2;
    for (var i = 0; i < heights.length; i++) {
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, size.height - heights[i], barWidth, heights[i]),
        const Radius.circular(4),
      );
      canvas.drawRRect(rect, Paint()..color = colors[i]);
      x += barWidth + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
