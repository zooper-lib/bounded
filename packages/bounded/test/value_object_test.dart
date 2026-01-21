import 'package:bounded/bounded.dart';
import 'package:test/test.dart';

// Test value object implementations
class Money with ValueObject {
  const Money(this.amount, this.currency);

  final num amount;
  final String currency;

  @override
  List<Object?> get props => [amount, currency];
}

class Address with ValueObject {
  const Address(this.street, this.city);

  final String street;
  final String city;

  @override
  List<Object?> get props => [street, city];
}

void main() {
  group('ValueObject', () {
    test('two value objects with same components are equal', () {
      final money1 = const Money(100, 'USD');
      final money2 = const Money(100, 'USD');

      expect(money1, equals(money2));
      expect(money1.hashCode, equals(money2.hashCode));
    });

    test('two value objects with different components are not equal', () {
      final money1 = const Money(100, 'USD');
      final money2 = const Money(100, 'EUR');

      expect(money1, isNot(equals(money2)));
    });

    test('value objects of different types are not equal', () {
      final money = const Money(100, 'USD');
      final address = const Address('100', 'USD'); // Same string values but different type

      expect(money, isNot(equals(address)));
    });

    test('value object equality uses only declared props', () {
      final money1 = const Money(100.0, 'USD');
      final money2 = const Money(100, 'USD'); // Different numeric types but equal values

      expect(money1, equals(money2));
    });

    test('value object has string representation with props', () {
      final money = const Money(100, 'USD');

      expect(money.toString(), contains('Money'));
      expect(money.toString(), contains('100'));
      expect(money.toString(), contains('USD'));
    });
  });
}
