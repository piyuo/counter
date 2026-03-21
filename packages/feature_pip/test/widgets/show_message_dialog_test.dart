import 'package:feature_pip/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appkit/flutter_appkit.dart' as appkit;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('messageBox shows message and closes after tapping OK', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: appkit.GlobalContext(
          child: Builder(
            builder: (context) {
              return TextButton(onPressed: () => showMessageDialog('Test message'), child: const Text('Open'));
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('Test message'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Test message'), findsNothing);
  });

  testWidgets('showYesNoMessageDialog returns true when tapping Yes', (tester) async {
    Future<bool?>? resultFuture;

    await tester.pumpWidget(
      MaterialApp(
        home: appkit.GlobalContext(
          child: Builder(
            builder: (context) {
              return TextButton(
                onPressed: () {
                  resultFuture = showYesNoMessageDialog(
                    'Proceed?',
                    title: 'Confirmation',
                    noLabel: 'Nope',
                    yesLabel: 'Yep',
                  );
                },
                child: const Text('Open YesNo'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open YesNo'));
    await tester.pumpAndSettle();

    expect(find.text('Proceed?'), findsOneWidget);
    expect(find.text('Nope'), findsOneWidget);
    expect(find.text('Yep'), findsOneWidget);

    await tester.tap(find.text('Yep'));
    await tester.pumpAndSettle();

    expect(await resultFuture, isTrue);
    expect(find.text('Proceed?'), findsNothing);
  });

  testWidgets('showYesNoMessageDialog returns false when tapping No', (tester) async {
    Future<bool?>? resultFuture;

    await tester.pumpWidget(
      MaterialApp(
        home: appkit.GlobalContext(
          child: Builder(
            builder: (context) {
              return TextButton(
                onPressed: () {
                  resultFuture = showYesNoMessageDialog('Continue?');
                },
                child: const Text('Open Default YesNo'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open Default YesNo'));
    await tester.pumpAndSettle();

    expect(find.text('Continue?'), findsOneWidget);
    expect(find.text('No'), findsOneWidget);
    expect(find.text('Yes'), findsOneWidget);

    await tester.tap(find.text('No'));
    await tester.pumpAndSettle();

    expect(await resultFuture, isFalse);
    expect(find.text('Continue?'), findsNothing);
  });
}
