part of '../text_gen.dart';

/// A [Gen] that chooses a random [Gen] from a list of [possibilities].
class Random extends Gen {
  /// Creates a [Random] with a list of possible [Gen] to choose from.
  Random({required this.possibilities});

  /// The list of possible Gen to choose from.
  List<Gen> possibilities;

  @override
  void add(Gen i) => possibilities.add(i);

  @override
  String buildArguments() {
    final buffer = StringBuffer();
    for (final element in possibilities) {
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(element.buildArguments());
    }
    return '{$buffer}';
  }

  final Map<int?, String?> _cache = {};

  @override
  String? buildVariant([int? i]) {
    i ??= random.nextInt(getDepth());
    if (_cache.containsKey(i)) return _cache[i];

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
  List<Gen>? getPathToUuid(String uuid) {
    if (uuid == this.uuid) return [this];
    for (final element in possibilities) {
      final path = element.getPathToUuid(uuid);
      if (path != null) return [this, ...path];
    }
    return null;
  }

  @override
  Gen? getByUuid(String uuid) {
    for (final element in possibilities) {
      if (element.uuid == uuid) return element;

      final uuFound = element.getByUuid(uuid);
      if (uuFound != null) return uuFound;
    }
    return null;
  }

  @override
  String toString() => 'Random(${getDepth()})$possibilities';

  @override
  bool replaceByUuid(String uuid, Gen newGen) {
    for (final element in possibilities) {
      if (element.uuid == uuid) {
        possibilities[possibilities.indexOf(element)] = newGen;
        return true;
      }
      if (element.replaceByUuid(uuid, newGen)) return true;
    }
    return false;
  }
}
