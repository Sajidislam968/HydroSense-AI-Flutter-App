import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrosense_ai/screens/sensor_detail_screen.dart';

void main() {
  testWidgets('shows readings for the selected sensor', (tester) async {
    const readings = {
      'Temperature': '28.4°C',
      'Humidity': '65%',
      'pH Level': '6.25',
      'Dissolved Oxygen': '7.8 mg/L',
      'EC / TDS': '1.32 mS/cm',
      'NPK': '120·45·190 ppm',
      'Water Level': '72%',
      'Pump Status': 'ON',
    };

    for (final entry in readings.entries) {
      await tester.pumpWidget(
        MaterialApp(
          home: SensorDetailScreen(sensorName: entry.key),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(entry.value), findsAtLeastNWidgets(1),
          reason: entry.key);
    }
  });

  testWidgets('shows an unavailable state for an unknown sensor', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SensorDetailScreen(sensorName: 'Unknown sensor'),
      ),
    );

    expect(find.text('No data'), findsOneWidget);
    expect(find.text('6.25'), findsNothing);
  });
}
