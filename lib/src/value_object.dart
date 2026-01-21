/// Mixin that provides structural equality for value objects.
///
/// Value objects are immutable objects whose equality is determined
/// by their component values rather than their identity. Classes that
/// use this mixin must implement [props] to declare which components
/// participate in equality comparisons.
///
/// Example:
/// ```dart
/// class Money with ValueObject {
///   const Money(this.amount, this.currency);
///
///   final num amount;
///   final String currency;
///
///   @override
///   List<Object?> get props => [amount, currency];
/// }
/// ```
mixin ValueObject {
  /// The list of properties that will be used to determine whether
  /// two instances are equal.
  List<Object?> get props;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ValueObject && runtimeType == other.runtimeType && _equals(props, other.props);

  @override
  int get hashCode => Object.hashAll(props);

  @override
  String toString() {
    return '$runtimeType(${props.join(', ')})';
  }

  bool _equals(List<Object?> list1, List<Object?> list2) {
    if (list1.length != list2.length) return false;
    for (var i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }
}
