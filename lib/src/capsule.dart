part of '../text_gen.dart';

class Capsule extends Gen {
  Capsule({required this.encapsulated});

  List<Gen> encapsulated;

  @override
  void add(Gen i) => encapsulated.add(i);

  @override
  String buildArguments() {
    final buffer = StringBuffer();
    for (final element in encapsulated) {
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(element.buildArguments());
    }
    return '($buffer)';
  }

  @override
  String toString() => 'Capsule(${getDepth()})$encapsulated';

  final Map<int?, String?> _cache = {};

  @override

  /// Builds the ith variant of the encapsulated Gen and its children.
  String? buildVariant([int? i]) {
    final depth = getDepth();
    i ??= random.nextInt(depth);
    if (_cache.containsKey(i)) return _cache[i];

    if (i >= depth) return null;
    final buffer = StringBuffer();

    for (final element in encapsulated) {
      if (buffer.isNotEmpty) buffer.write(' ');
      final depth = element.getDepth();
      if (element is Txt) {
        buffer.write(element.buildVariant(1));
      } else if (element is Capsule) {
        buffer.write(element.buildVariant(i! % depth));
        i ~/= element.getDepth();
      } else if (element is Random) {
        final index = i! % depth;
        buffer.write(element.buildVariant(index));
        i ~/= depth;
      }
    }
    return buffer.toString();
  }

  /// Returns the nth permutation from multiple lists
  /// [lists] is the list of lists
  /// [i] is the index of the current list
  /// [n] is the number of the wanted permutation
  static List<T> permutation<T>(int n, List<List<T>> lists, [int i = 0]) {
    if (i == lists.length) return [];
    final list = lists[i];
    final length = list.length;
    final index = n % length;
    final result = list[index];
    final next = n ~/ length;
    return [result, ...permutation(next, lists, i + 1)];
  }

  @override
  int getDepth() {
    var depth = 1;
    for (final element in encapsulated) {
      depth *= element.getDepth();
    }
    return depth;
  }

  @override
  List<Gen>? getPathToUuid(String uuid) {
    if (uuid == this.uuid) return [this];
    for (final element in encapsulated) {
      final path = element.getPathToUuid(uuid);
      if (path != null) return [this, ...path];
    }
    return null;
  }

  @override
  Gen? getByUuid(String uuid) {
    for (final element in encapsulated) {
      if (element.uuid == uuid) return element;

      final uuFound = element.getByUuid(uuid);
      if (uuFound != null) return uuFound;
    }
    return null;
  }

  @override
  bool replaceByUuid(String uuid, Gen newGen) {
    for (final element in encapsulated) {
      if (element.uuid == uuid) {
        encapsulated[encapsulated.indexOf(element)] = newGen;
        return true;
      }
      if (element.replaceByUuid(uuid, newGen)) return true;
    }
    return false;
  }

  @override // ==
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Capsule &&
        encapsulated.length == other.encapsulated.length &&
        encapsulated.every((el) => other.encapsulated.contains(el));
  }

  @override // hashCode
  int get hashCode => encapsulated.fold(0, (hash, el) => hash ^ el.hashCode);
}
