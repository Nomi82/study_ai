import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:study_ai/app.dart';
import 'package:study_ai/core/di/injection_container.dart';
import 'package:study_ai/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initDependencies();

  runApp(const StudyAiApp());
}
