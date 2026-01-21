import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'src/rules/domain_event_immutable_rule.dart';
import 'src/rules/prefer_const_domain_events_rule.dart';
import 'src/rules/record_event_outside_aggregate_rule.dart';
import 'src/rules/value_object_immutable_rule.dart';

PluginBase createPlugin() => _BoundedLintsPlugin();

class _BoundedLintsPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    return [
      ValueObjectImmutableRule(),
      DomainEventImmutableRule(),
      PreferConstDomainEventsRule(),
      RecordEventOutsideAggregateRule(),
    ];
  }
}
