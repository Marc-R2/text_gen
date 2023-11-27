part of '../../text_gen.dart';

/// A [EditableGen] that chooses a random [EditableGen] from a list of [possibilities].
class Random extends StaticGen {
  /// Creates a [Random] with a list of possible [EditableGen] to choose from.
  const Random({required this.possibilities});

  /// The list of possible Gen to choose from.
  final List<StaticGen> possibilities;

  @override
  String buildArguments() {
    final buffer = StringBuffer();
    for (final element in possibilities) {
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(element.buildArguments());
    }
    return '{$buffer}';
  }

  @override
  String? buildVariant([int? i]) {
    i ??= random.nextInt(getDepth());

    var depth = 0;
    for (final element in possibilities) {
      final lDepth = element.getDepth();
      depth += lDepth;
      if (depth > i) return element.buildVariant(i % lDepth);
    }
    return null;
  }

  @override
  int getDepth() => possibilities.fold(0, (depth, el) => depth + el.getDepth());

  @override
  String toString() => 'Random(${getDepth()})$possibilities';
}
