import 'package:analyzer/dart/element/element.dart';

bool hasSupertypeNamed(InterfaceElement? element, Set<String> names) {
  if (element == null) return false;

  for (final supertype in element.allSupertypes) {
    final name = supertype.element.name;
    if (names.contains(name)) return true;
  }

  return false;
}

bool mixesInNamed(InterfaceElement? element, String name) {
  if (element == null) return false;

  for (final mixinType in element.mixins) {
    if (mixinType.element.name == name) return true;
  }

  return false;
}
