class OnboardingRoutes {
  const OnboardingRoutes._();

  // onboarding
  static const String onboarding = '/onboarding';

  // invitation
  static const String invitation = 'invitation'; // Note: this is a relative path segment, not an absolute path.
  static String get onboardingInvitation => '$onboarding/$invitation';
  static String onboardingInvitationPath({String? token}) {
    if (token == null) return onboardingInvitation;
    return '$onboardingInvitation?${Uri(queryParameters: {'token': token}).query}';
  }

  // sign-up the backend server (piyuo cloud/self-hosted)
  static String get onboardingSignup => '$onboarding/signup';

  // demo mode (no backend)
  static String get onboardingDemo => '$onboarding/demo';

  // call to action
  static const String cta = 'cta'; // Note: this is a relative path segment, not an absolute path.
  static String get onboardingCTA => '$onboarding/$cta'; // call to action
}
