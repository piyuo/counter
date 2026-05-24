// TOC:
//  - NativeAppLinkService ignores cold-start when no initial link
//  - NativeAppLinkService handles cold-start link with a code
//  - NativeAppLinkService ignores cold-start link without a code query param
//  - NativeAppLinkService handles live stream link with a code
//  - NativeAppLinkService ignores live stream link without a code query param
//  - NativeAppLinkService handles multiple live stream links in sequence

import 'dart:async';

import 'package:core_domain/core_domain.dart' as core_domain;
import 'package:core_runtime/runtime/native_app_link_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Bootstraps [serviceBuilder] inside a real Riverpod [Ref] and returns the container
/// so tests can inspect provider state afterwards.
Future<ProviderContainer> _boot(Future<NativeAppLinkService> Function(Ref ref) serviceBuilder) async {
  final container = ProviderContainer();
  final bootstrap = FutureProvider<void>((ref) async {
    final service = await serviceBuilder(ref);
    await service.init();
  });
  await container.read(bootstrap.future);
  return container;
}

void main() {
  group('NativeAppLinkService', () {
    test('ignores cold-start when no initial link', () async {
      final container = await _boot((ref) async {
        return NativeAppLinkService(
          ref.read(core_domain.appFlowProvider.notifier),
          ref.read(core_domain.invitationCodeProvider.notifier),
          initialLinkResolver: () async => null,
          linkStream: const Stream.empty(),
        );
      });
      addTearDown(container.dispose);

      expect(container.read(core_domain.invitationCodeProvider), isNull);
    });

    test('handles cold-start link with a code', () async {
      final uri = Uri.parse('https://example.com/invite?code=COLD01');
      final container = await _boot((ref) async {
        return NativeAppLinkService(
          ref.read(core_domain.appFlowProvider.notifier),
          ref.read(core_domain.invitationCodeProvider.notifier),
          initialLinkResolver: () async => uri,
          linkStream: const Stream.empty(),
        );
      });
      addTearDown(container.dispose);

      expect(container.read(core_domain.invitationCodeProvider), 'COLD01');
    });

    test('ignores cold-start link without a code query param', () async {
      final uri = Uri.parse('https://example.com/invite');
      final container = await _boot((ref) async {
        return NativeAppLinkService(
          ref.read(core_domain.appFlowProvider.notifier),
          ref.read(core_domain.invitationCodeProvider.notifier),
          initialLinkResolver: () async => uri,
          linkStream: const Stream.empty(),
        );
      });
      addTearDown(container.dispose);

      expect(container.read(core_domain.invitationCodeProvider), isNull);
    });

    test('handles live stream link with a code', () async {
      final controller = StreamController<Uri>();
      addTearDown(controller.close);

      final container = await _boot((ref) async {
        return NativeAppLinkService(
          ref.read(core_domain.appFlowProvider.notifier),
          ref.read(core_domain.invitationCodeProvider.notifier),
          initialLinkResolver: () async => null,
          linkStream: controller.stream,
        );
      });
      addTearDown(container.dispose);

      controller.add(Uri.parse('https://example.com/invite?code=LIVE01'));
      await Future<void>.delayed(Duration.zero);

      expect(container.read(core_domain.invitationCodeProvider), 'LIVE01');
    });

    test('ignores live stream link without a code query param', () async {
      final controller = StreamController<Uri>();
      addTearDown(controller.close);

      final container = await _boot((ref) async {
        return NativeAppLinkService(
          ref.read(core_domain.appFlowProvider.notifier),
          ref.read(core_domain.invitationCodeProvider.notifier),
          initialLinkResolver: () async => null,
          linkStream: controller.stream,
        );
      });
      addTearDown(container.dispose);

      controller.add(Uri.parse('https://example.com/invite'));
      await Future<void>.delayed(Duration.zero);

      expect(container.read(core_domain.invitationCodeProvider), isNull);
    });

    test('handles multiple live stream links in sequence', () async {
      final controller = StreamController<Uri>();
      addTearDown(controller.close);

      final container = await _boot((ref) async {
        return NativeAppLinkService(
          ref.read(core_domain.appFlowProvider.notifier),
          ref.read(core_domain.invitationCodeProvider.notifier),
          initialLinkResolver: () async => null,
          linkStream: controller.stream,
        );
      });
      addTearDown(container.dispose);

      controller.add(Uri.parse('https://example.com/invite?code=FIRST'));
      await Future<void>.delayed(Duration.zero);
      expect(container.read(core_domain.invitationCodeProvider), 'FIRST');

      controller.add(Uri.parse('https://example.com/invite?code=SECOND'));
      await Future<void>.delayed(Duration.zero);
      expect(container.read(core_domain.invitationCodeProvider), 'SECOND');
    });
  });
}
