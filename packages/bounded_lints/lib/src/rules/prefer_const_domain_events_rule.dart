import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '_type_checks.dart';

class PreferConstDomainEventsRule extends DartLintRule {
  PreferConstDomainEventsRule() : super(code: _code);

  static const _code = LintCode(
    name: 'bounded_prefer_const_domain_events',
    problemMessage: 'Prefer const constructors for domain events when possible.',
    errorSeverity: DiagnosticSeverity.WARNING,
  );

  @override
  void run(CustomLintResolver resolver, DiagnosticReporter reporter, CustomLintContext context) {
    context.registry.addClassDeclaration((node) {
      final element = node.declaredFragment?.element;
      final isDomainEvent = hasSupertypeNamed(element, {'DomainEvent', 'BoundedDomainEvent'});
      if (!isDomainEvent) return;

      var hasConstCtor = false;
      var hasNonConstGenerativeCtor = false;

      for (final member in node.members) {
        if (member is ConstructorDeclaration) {
          if (member.factoryKeyword != null) continue;
          if (member.constKeyword != null) {
            hasConstCtor = true;
          } else {
            hasNonConstGenerativeCtor = true;
          }
        }
      }

      if (hasConstCtor) return;
      if (!hasNonConstGenerativeCtor) return;

      final hasMutableFieldOrSetter = node.members.any((member) {
        if (member is FieldDeclaration) {
          if (member.isStatic) return false;
          return !member.fields.isFinal;
        }
        if (member is MethodDeclaration) {
          if (member.isStatic) return false;
          return member.isSetter;
        }
        return false;
      });

      if (hasMutableFieldOrSetter) return;

      reporter.atToken(node.name, code);
    });
  }
}
