class AppUser {
  final String uid;
  final String? email;
  final bool isPremium;
  final int credits;

  AppUser({
    required this.uid,
    this.email,
    required this.isPremium,
    required this.credits,
  });
}
