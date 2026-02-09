import 'package:flutter/material.dart';
import 'package:study_ai/core/theme/app_theme.dart';

class StudyAiApp extends StatelessWidget {
  const StudyAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: Center(
          child: Text('Study AI'),
        ),
      ),
    );
  }
}
