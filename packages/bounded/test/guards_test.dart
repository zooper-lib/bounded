import 'package:bounded/bounded.dart';
import 'package:test/test.dart';

void main() {
  group('Guard.invariant', () {
    test('does nothing when condition holds', () {
      expect(() => Guard.invariant(true, 'should not throw'), returnsNormally);
    });

    test('throws StateError when condition is false', () {
      expect(
        () => Guard.invariant(false, 'invariant violated'),
        throwsA(
          isA<StateError>().having((e) => e.message, 'message', contains('invariant violated')),
        ),
      );
    });
  });
}
