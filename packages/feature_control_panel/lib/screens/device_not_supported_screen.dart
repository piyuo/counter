import 'package:flutter/material.dart';
import 'package:shared_l10n/shared_l10n.dart';

class DeviceNotSupportedScreen extends StatelessWidget {
  const DeviceNotSupportedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon in circle
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(color: colorScheme.errorContainer, shape: BoxShape.circle),
                    child: Icon(Icons.videocam_off_rounded, size: 32, color: colorScheme.onErrorContainer),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  Text(
                    context.l.device_not_supported_screen_title,
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // Body
                  SelectableText(
                    context.l.device_not_supported_screen_body.replaceAll("\\'", "'"),
                    style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // "What you need" card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l.device_not_supported_screen_requirements_title,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _RequirementRow(
                          text: context.l.device_not_supported_screen_requirement_camera,
                          colorScheme: colorScheme,
                        ),
                        const SizedBox(height: 8),
                        _RequirementRow(
                          text: context.l.device_not_supported_screen_requirement_platform,
                          colorScheme: colorScheme,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Footer hint
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.smartphone_rounded,
                        size: 14,
                        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        context.l.device_not_supported_screen_footer_hint,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RequirementRow extends StatelessWidget {
  const _RequirementRow({required this.text, required this.colorScheme});

  final String text;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_rounded, size: 16, color: colorScheme.primary),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
      ],
    );
  }
}
