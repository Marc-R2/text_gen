part of '../text_gen.dart';

class Capsule extends Gen {
  List<Gen> encapsulated;

  Capsule({required this.encapsulated});

  @override
  void add(Gen i) => encapsulated.add(i);

  @override
  String buildArguments() {
    // print(this);
    final buffer = StringBuffer();
    for (final element in encapsulated) {
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(element.buildArguments());
    }
    return '($buffer)';
  }

  @override
  String toString() => 'Capsule(${getDepth()})$encapsulated';

  Map<int?, String?> cache = {};

  @override
  /// Builds the ith variant of the encapsulated Gen and its children.
  String? buildVariant([int? i]) {

    // If [i] is null, then assign a random index. 0 to depth.
    i ??= random.nextInt(getDepth());

    // If the cache has the index, return the value.
    if (cache.containsKey(i)) return cache[i];

    if (i >= getDepth()) return null;
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
        int index = (i! % depth);
        buffer.write(element.buildVariant(index));
        i ~/= depth;
      }
    }
    // print('var($i): $this => $buffer');
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
    int depth = 1;
    for (final element in encapsulated) {
      depth *= element.getDepth();
    }
    return depth;
  }

  @override
  List<Gen>? getPathToUuid(String uuid) {
    if(uuid == this.uuid) return [this];
    for (final element in encapsulated) {
      final path = element.getPathToUuid(uuid);
      if (path != null) return [this, ...path];
    }
    return null;
  }

  @override
  Gen? getByUuid(String uuid) {
    Gen? res;
    for (final element in encapsulated) {
      if (element.uuid == uuid) {
        res = element;
        break;
      } else {
        final uuFound = element.getByUuid(uuid);
        if (uuFound != null) {
          res = uuFound;
          break;
        }
      }
    }
    return res;
  }

  @override
  bool replaceByUuid(String uuid, Gen newGen) {
    for (final element in encapsulated) {
      if (element.uuid == uuid) {
        encapsulated[encapsulated.indexOf(element)] = newGen;
        return true;
      } else {
        final uuFound = element.replaceByUuid(uuid, newGen);
        if (uuFound) return true;
      }
    }
    return false;
  }
}
