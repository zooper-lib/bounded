import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  test('custom_lint reports bounded lints', () async {
    final exampleDir = p.normalize(p.join(Directory.current.path, 'example'));

    final pubGetResult = await Process.run(
      Platform.resolvedExecutable,
      const ['pub', 'get'],
      workingDirectory: exampleDir,
    );

    expect(
      pubGetResult.exitCode,
      0,
      reason: 'Expected `dart pub get` to succeed in the example package. stdout:\n${pubGetResult.stdout}\nstderr:\n${pubGetResult.stderr}',
    );

    final result = await Process.run(
      Platform.resolvedExecutable,
      const ['run', 'custom_lint'],
      workingDirectory: exampleDir,
    );

    final stdoutText = result.stdout.toString();
    final stderrText = result.stderr.toString();
    final combinedOutput = '$stdoutText\n$stderrText';

    expect(
      combinedOutput,
      contains('bounded_value_object_immutable'),
      reason: 'Expected lints to be reported. Output:\n$combinedOutput',
    );
    expect(combinedOutput, contains('bounded_domain_event_immutable'));
    expect(combinedOutput, contains('bounded_prefer_const_domain_events'));
    expect(combinedOutput, contains('bounded_record_event_outside_aggregate'));
  });
}
