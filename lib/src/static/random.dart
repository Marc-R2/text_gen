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
  void buildVariantNum(int i, StringBuffer buffer) {
    var depth = 0;
    for (final element in possibilities) {
      final lDepth = element.getDepth();
      depth += lDepth;
      if (depth > i) {
        element.buildVariantNum(i % lDepth, buffer);
        return;
      }
    }
  }

  @override
  int getDepth() {
    final cacheHit = getCacheHit();
    if (cacheHit != null) return cacheHit;
    final depth = possibilities.fold(0, (depth, el) => depth + el.getDepth());
    setCacheHit(depth);
    return depth;
  }

  @override
  String toString() => 'Random(${getDepth()})$possibilities';
}
