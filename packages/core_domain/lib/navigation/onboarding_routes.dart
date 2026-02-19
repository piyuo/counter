class OnboardingRoutes {
  const OnboardingRoutes._();

  // onboarding
  static const String onboarding = '/onboarding';
  static const String invitation = 'invitation'; // Note: this is a relative path segment, not an absolute path.
  static String get onboardingInvitation => '$onboarding/$invitation';
  static String onboardingInvitationPath({String? token}) {
    if (token == null) return onboardingInvitation;
    return '$onboardingInvitation?${Uri(queryParameters: {'token': token}).query}';
  }
}
