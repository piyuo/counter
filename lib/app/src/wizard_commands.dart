/// The wizard commands
enum WizardCommands {
  showVideoSettings,
}

/// The wizard command will send to wizard screen
class WizardCommand {
  WizardCommand(
    this.wizardCommands, {
    this.arguments,
  });

  /// The wizard commands
  final WizardCommands wizardCommands;

  /// The arguments
  final Object? arguments;
}
