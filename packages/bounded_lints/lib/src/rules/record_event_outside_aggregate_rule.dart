import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '_type_checks.dart';

class RecordEventOutsideAggregateRule extends DartLintRule {
  RecordEventOutsideAggregateRule() : super(code: _code);

  static const _code = LintCode(
    name: 'bounded_record_event_outside_aggregate',
    problemMessage: 'Record domain events inside aggregate root instance methods.',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(CustomLintResolver resolver, ErrorReporter reporter, CustomLintContext context) {
    context.registry.addMethodInvocation((node) {
      if (node.methodName.name != 'recordEvent') return;

      final enclosingClass = node.thisOrAncestorOfType<ClassDeclaration>();
      final enclosingMethod = node.thisOrAncestorOfType<MethodDeclaration>();

      final isInsideAggregateType = hasSupertypeNamed(enclosingClass?.declaredFragment?.element, {'AggregateRoot'});
      final isInInstanceMethod = enclosingMethod != null && !enclosingMethod.isStatic;

      final target = node.target;
      final isThisCall = target == null || target is ThisExpression;

      if (isInsideAggregateType && isInInstanceMethod && isThisCall) {
        return;
      }

      reporter.atNode(node.methodName, code);
    });
  }
}
