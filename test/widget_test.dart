// Basic Flutter widget test for MyApp with a minimal router.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:study_ai/main.dart';

void main() {
  testWidgets('App loads with router', (WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const Material(child: Text('Test')),
        ),
      ],
    );

    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Test'), findsOneWidget);
  });
}
