import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/app_user.dart';

class AppUserModel extends AppUser {
  AppUserModel({
    required super.uid,
    super.email,
    required super.isPremium,
    required super.credits,
  });

  factory AppUserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return AppUserModel(
      uid: doc.id,
      email: data['email'],
      isPremium: data['isPremium'] ?? false,
      credits: data['credits'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'isPremium': isPremium,
      'credits': credits,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
