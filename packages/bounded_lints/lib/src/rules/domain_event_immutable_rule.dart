import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '_type_checks.dart';

class DomainEventImmutableRule extends DartLintRule {
  DomainEventImmutableRule() : super(code: _code);

  static const _code = LintCode(
    name: 'bounded_domain_event_immutable',
    problemMessage: 'Domain events should be immutable.',
    errorSeverity: DiagnosticSeverity.WARNING,
  );

  @override
  void run(CustomLintResolver resolver, DiagnosticReporter reporter, CustomLintContext context) {
    context.registry.addClassDeclaration((node) {
      final element = node.declaredFragment?.element;
      final isDomainEvent = hasSupertypeNamed(element, {'DomainEvent', 'BoundedDomainEvent'});
      if (!isDomainEvent) return;

      for (final member in node.members) {
        if (member is FieldDeclaration) {
          if (member.isStatic) continue;
          if (member.fields.isFinal) continue;

          for (final variable in member.fields.variables) {
            reporter.atToken(variable.name, code);
          }
        }

        if (member is MethodDeclaration) {
          if (member.isStatic) continue;
          if (!member.isSetter) continue;

          reporter.atToken(member.name, code);
        }
      }
    });
  }
}
