import 'package:flutter/material.dart';

import 'pip_panel.dart';

class PipHeader extends StatelessWidget {
  const PipHeader({required this.title, required this.icon, this.children = const [], this.subtitle, super.key});

  final List<Widget> children;

  final String title;

  final String? subtitle;

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return PipPanel(
      padding: const EdgeInsets.symmetric(vertical: 24),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        children: [
          Icon(icon, size: 64),
          const SizedBox(height: 8),
          // title
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          // subtitle
          if (subtitle != null)
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          if (subtitle != null) const SizedBox(height: 4),
          ...children,
        ],
      ),
    );
  }
}
