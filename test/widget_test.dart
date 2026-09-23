import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hardware_manufacturing/main.dart';

void main() {
  testWidgets('app opens on About Us screen and provides menu redirects', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('About Us'), findsWidgets);
    expect(find.byIcon(Icons.menu), findsWidgets);

    await tester.tap(find.byIcon(Icons.menu).first);
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
    expect(find.text('About Us'), findsWidgets);
    expect(find.text('Products'), findsWidgets);
    expect(find.text('Settings'), findsWidgets);
  });
}
