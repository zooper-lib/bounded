import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '_type_checks.dart';

class ValueObjectImmutableRule extends DartLintRule {
  ValueObjectImmutableRule()
      : super(
          code: _code,
        );

  static const _code = LintCode(
    name: 'bounded_value_object_immutable',
    problemMessage: 'Value objects should be immutable.',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addClassDeclaration((node) {
      final element = node.declaredFragment?.element;
      if (!mixesInNamed(element, 'ValueObject')) return;

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
