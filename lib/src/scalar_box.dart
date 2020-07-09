abstract class ScalarBox<T> {
  final T value;

  ScalarBox(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScalarBox &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
