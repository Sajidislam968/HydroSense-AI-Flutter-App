import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/status_pill.dart';

class SensorDetailScreen extends StatelessWidget {
  final String sensorName;
  const SensorDetailScreen({super.key, required this.sensorName});

  @override
  Widget build(BuildContext context) {
    final sensor = _sensorDetails[sensorName] ?? _unavailableSensor;
    return Scaffold(
      appBar: AppBar(title: Text(sensorName)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
          children: [
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _SensorTab('Temp', active: sensorName == 'Temperature'),
                  SizedBox(width: 8),
                  _SensorTab('Humidity', active: sensorName == 'Humidity'),
                  SizedBox(width: 8),
                  _SensorTab('pH', active: sensorName == 'pH Level'),
                  SizedBox(width: 8),
                  _SensorTab('DO', active: sensorName == 'Dissolved Oxygen'),
                  SizedBox(width: 8),
                  _SensorTab('EC', active: sensorName == 'EC / TDS'),
                  SizedBox(width: 8),
                  _SensorTab('NPK', active: sensorName == 'NPK'),
                  SizedBox(width: 8),
                  _SensorTab('Water', active: sensorName == 'Water Level'),
                  SizedBox(width: 8),
                  _SensorTab('Pump', active: sensorName == 'Pump Status'),
                ],
              ),
            ),
            DashboardCard(
              padding: const EdgeInsets.all(22),
              color: sensor.color.withAlpha((0.08 * 255).round()),
              borderColor: sensor.color.withAlpha((0.2 * 255).round()),
              child: Column(
                children: [
                  const Text('Current Reading',
                      style: TextStyle(
                          fontSize: 11,
                          color: AppColors.ink500,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(
                    sensor.reading,
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: sensor.color),
                  ),
                  const SizedBox(height: 8),
                  StatusPill(label: sensor.status, tone: sensor.statusTone),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 18,
                    child: CustomPaint(
                      size: const Size(double.infinity, 18),
                      painter: _RangeGaugePainter(
                        trackColor: AppColors.line,
                        targetBandStart: sensor.targetBandStart,
                        targetBandEnd: sensor.targetBandEnd,
                        targetBandColor:
                            sensor.color.withAlpha((0.28 * 255).round()),
                        markerPosition: sensor.markerPosition,
                        markerColor: sensor.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(sensor.rangeMin,
                          style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.ink300,
                              fontWeight: FontWeight.w600)),
                      Text(sensor.target,
                          style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.ink300,
                              fontWeight: FontWeight.w600)),
                      Text(sensor.rangeMax,
                          style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.ink300,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            DashboardCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('7-Day Trend',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 86,
                    child: CustomPaint(
                      size: const Size(double.infinity, 86),
                      painter: _TrendPainter(color: sensor.color),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.9,
              children: [
                _StatTile(label: 'Min (24h)', value: sensor.min),
                _StatTile(label: 'Max (24h)', value: sensor.max),
                _StatTile(label: 'Average', value: sensor.average),
                _StatTile(label: 'Sensor Node', value: sensor.node),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SensorDetailData {
  final String reading;
  final String status;
  final PillTone statusTone;
  final String target;
  final String rangeMin;
  final String rangeMax;
  final double targetBandStart;
  final double targetBandEnd;
  final double markerPosition;
  final String min;
  final String max;
  final String average;
  final String node;
  final Color color;

  const _SensorDetailData({
    required this.reading,
    required this.status,
    required this.statusTone,
    required this.target,
    required this.rangeMin,
    required this.rangeMax,
    required this.targetBandStart,
    required this.targetBandEnd,
    required this.markerPosition,
    required this.min,
    required this.max,
    required this.average,
    required this.node,
    required this.color,
  });
}

const _sensorDetails = <String, _SensorDetailData>{
  'Temperature': _SensorDetailData(
    reading: '28.4°C',
    status: 'Above optimal',
    statusTone: PillTone.amber,
    target: 'Target 18–28°C',
    rangeMin: '10°C',
    rangeMax: '40°C',
    targetBandStart: 0.27,
    targetBandEnd: 0.60,
    markerPosition: 0.61,
    min: '24.1°C',
    max: '28.4°C',
    average: '26.7°C',
    node: 'Node-3',
    color: Color(0xFFE35B4F),
  ),
  'Humidity': _SensorDetailData(
    reading: '65%',
    status: 'Optimal Range',
    statusTone: PillTone.green,
    target: 'Target 50–70%',
    rangeMin: '0%',
    rangeMax: '100%',
    targetBandStart: 0.50,
    targetBandEnd: 0.70,
    markerPosition: 0.65,
    min: '58%',
    max: '70%',
    average: '64%',
    node: 'Node-3',
    color: AppColors.blue,
  ),
  'pH Level': _SensorDetailData(
    reading: '6.25',
    status: 'Optimal Range',
    statusTone: PillTone.green,
    target: 'Target 5.5–6.5',
    rangeMin: '0',
    rangeMax: '14',
    targetBandStart: 0.39,
    targetBandEnd: 0.46,
    markerPosition: 0.45,
    min: '5.98',
    max: '6.42',
    average: '6.18',
    node: 'Node-1',
    color: Color(0xFF7C3AED),
  ),
  'Dissolved Oxygen': _SensorDetailData(
    reading: '7.8 mg/L',
    status: 'Optimal Range',
    statusTone: PillTone.green,
    target: 'Target 6–10 mg/L',
    rangeMin: '0',
    rangeMax: '14',
    targetBandStart: 0.43,
    targetBandEnd: 0.71,
    markerPosition: 0.56,
    min: '7.1 mg/L',
    max: '8.2 mg/L',
    average: '7.8 mg/L',
    node: 'Node-1',
    color: AppColors.teal,
  ),
  'EC / TDS': _SensorDetailData(
    reading: '1.32 mS/cm',
    status: 'Optimal Range',
    statusTone: PillTone.green,
    target: 'Target 1.2–1.8 mS/cm',
    rangeMin: '0',
    rangeMax: '3.0',
    targetBandStart: 0.40,
    targetBandEnd: 0.60,
    markerPosition: 0.44,
    min: '1.28',
    max: '1.36',
    average: '1.32',
    node: 'Node-2',
    color: AppColors.amber,
  ),
  'NPK': _SensorDetailData(
    reading: '120·45·190 ppm',
    status: 'Optimal Range',
    statusTone: PillTone.green,
    target: 'N · P · K (ppm)',
    rangeMin: 'Low',
    rangeMax: 'High',
    targetBandStart: 0.30,
    targetBandEnd: 0.70,
    markerPosition: 0.55,
    min: '110·40·180',
    max: '125·50·195',
    average: '120·45·190',
    node: 'Node-2',
    color: AppColors.greenDark,
  ),
  'Water Level': _SensorDetailData(
    reading: '72%',
    status: 'Normal',
    statusTone: PillTone.green,
    target: 'Target 30–80%',
    rangeMin: '0%',
    rangeMax: '100%',
    targetBandStart: 0.30,
    targetBandEnd: 0.80,
    markerPosition: 0.72,
    min: '68%',
    max: '76%',
    average: '72%',
    node: 'Node-3',
    color: AppColors.blue,
  ),
  'Pump Status': _SensorDetailData(
    reading: 'ON',
    status: 'Running',
    statusTone: PillTone.green,
    target: 'Pump operating status',
    rangeMin: 'Off',
    rangeMax: 'On',
    targetBandStart: 0.35,
    targetBandEnd: 0.75,
    markerPosition: 0.75,
    min: 'Off',
    max: 'On',
    average: '98% uptime',
    node: 'Node-3',
    color: AppColors.greenDark,
  ),
};

const _unavailableSensor = _SensorDetailData(
  reading: '—',
  status: 'No data',
  statusTone: PillTone.neutral,
  target: 'No reference range',
  rangeMin: '—',
  rangeMax: '—',
  targetBandStart: 0.3,
  targetBandEnd: 0.7,
  markerPosition: 0.5,
  min: '—',
  max: '—',
  average: '—',
  node: '—',
  color: AppColors.ink500,
);

class _SensorTab extends StatelessWidget {
  final String label;
  final bool active;
  const _SensorTab(this.label, {this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: active ? AppColors.purpleTint : const Color(0xFFF0F2F0),
        borderRadius: BorderRadius.circular(100),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: active ? const Color(0xFF7C3AED) : AppColors.ink500,
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.ink500,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

/// Paints a horizontal range gauge: a background track, a highlighted
/// "target band", and a circular marker showing the current reading.
class _RangeGaugePainter extends CustomPainter {
  final Color trackColor;
  final double targetBandStart;
  final double targetBandEnd;
  final Color targetBandColor;
  final double markerPosition;
  final Color markerColor;

  _RangeGaugePainter({
    required this.trackColor,
    required this.targetBandStart,
    required this.targetBandEnd,
    required this.targetBandColor,
    required this.markerPosition,
    required this.markerColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final trackY = size.height / 2;
    final trackRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, trackY - 4, size.width, 8),
      const Radius.circular(5),
    );
    canvas.drawRRect(trackRect, Paint()..color = trackColor);

    final bandRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * targetBandStart, trackY - 4,
          size.width * (targetBandEnd - targetBandStart), 8),
      const Radius.circular(5),
    );
    canvas.drawRRect(bandRect, Paint()..color = targetBandColor);

    final markerX = size.width * markerPosition;
    canvas.drawCircle(
        Offset(markerX, trackY), 8, Paint()..color = Colors.white);
    canvas.drawCircle(
        Offset(markerX, trackY),
        8,
        Paint()
          ..color = Colors.black.withAlpha((0.15 * 255).round())
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);
    canvas.drawCircle(
        Offset(markerX, trackY), 5.5, Paint()..color = markerColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrendPainter extends CustomPainter {
  final Color color;

  const _TrendPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final points = [50.0, 45.0, 55.0, 35.0, 42.0, 30.0, 38.0, 25.0, 32.0];
    final dx = size.width / (points.length - 1);
    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final p = Offset(dx * i, points[i]);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..strokeWidth = 2.4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    final dashPaint = Paint()
      ..color = const Color(0xFFE9DCFF)
      ..strokeWidth = 1;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 30), Offset(x + 3, 30), dashPaint);
      x += 6;
    }
  }

  @override
  bool shouldRepaint(covariant _TrendPainter oldDelegate) =>
      oldDelegate.color != color;
}
