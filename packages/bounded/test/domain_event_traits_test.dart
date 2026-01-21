import 'package:bounded/bounded.dart';
import 'package:test/test.dart';

// Test implementations
class EventId extends TypedIdentity<String> {
  const EventId(super.value);
}

class ExampleEvent with ValueObject implements BoundedDomainEvent<EventId> {
  const ExampleEvent({required this.id, required this.occurredOn, required this.metadata});

  @override
  final EventId id;

  @override
  final DateTime occurredOn;

  @override
  final Map<String, Object?> metadata;

  @override
  List<Object?> get props => [id, occurredOn, metadata];
}

void main() {
  group('DomainEvent traits', () {
    test('BoundedDomainEvent composes all trait interfaces', () {
      final event = ExampleEvent(
        id: const EventId('evt-1'),
        occurredOn: DateTime(2026, 1, 21),
        metadata: const {'correlationId': 'c-1', 'attempt': 1},
      );

      expect(event, isA<DomainEvent>());
      expect(event, isA<IdentifiedDomainEvent<EventId>>());
      expect(event, isA<TimestampedDomainEvent>());
      expect(event, isA<MetadataDomainEvent>());

      expect(event.id, equals(const EventId('evt-1')));
      expect(event.occurredOn, equals(DateTime(2026, 1, 21)));
      expect(event.metadata['correlationId'], equals('c-1'));
      expect(event.metadata['attempt'], equals(1));
    });
  });
}
