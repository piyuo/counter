import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ref.watch inside callback causes rebuild', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // Use NotifierProvider instead of StateProvider as it might be deprecated/removed in v3
    final counterProvider = NotifierProvider<Counter, int>(Counter.new);

    int buildCount = 0;

    final dependentProvider = Provider<int Function()>((ref) {
      buildCount++;
      // We return a "callback"
      return () {
        // This callback accesses ref.watch(counterProvider)
        final val = ref.watch(counterProvider);
        return val;
      };
    });

    // 1. Force the first build of dependentProvider
    final callback = container.read(dependentProvider);
    expect(buildCount, equals(1));

    // 2. Trigger the callback (simulating GoRouter redirect)
    // This executes ref.watch(counterProvider) inside the callback.
    // The ref belongs to dependentProvider.
    // This should register a dependency on counterProvider for dependentProvider.
    final val1 = callback();
    expect(val1, 0);

    // 3. Change the counter
    // This should invalidate dependentProvider if listener was successfully registered.
    container.read(counterProvider.notifier).increment();

    // 4. Force a read of dependentProvider to trigger rebuild if it was invalidated
    container.read(dependentProvider);

    if (buildCount > 1) {
      //print('Provider REBUILT! buildCount: $buildCount');
    } else {
      //print('Provider DID NOT REBUILD. buildCount: $buildCount');
    }

    expect(
      buildCount,
      greaterThan(1),
      reason: "Provider SHOULD have rebuilt because ref.watch was called inside its callback using its ref",
    );
  });
}

class Counter extends Notifier<int> {
  @override
  int build() => 0;
  void increment() => state++;
}
