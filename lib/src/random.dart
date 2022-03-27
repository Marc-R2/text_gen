part of '../text_gen.dart';

class Random extends Gen {
  List<Gen> possibilities;

  Random({required this.possibilities});

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

  Map<int?, String?> cache = {};

  @override
  String? buildVariant([int? i]) {
    i ??= random.nextInt(getDepth());

    // If the cache has the index, return the value.
    if (cache.containsKey(i)) return cache[i];

    int depth = 0;
    for (final element in possibilities) {
      final lDepth = element.getDepth();
      depth += lDepth;
      if(depth > i) {
        // print('var($i): $this => ${element.buildVariant(i % lDepth)}');
        return element.buildVariant(i % lDepth);
      }
    }
    return null;
  }

  @override
  int getDepth() {
    int depth = 0;
    for (final element in possibilities) {
      depth += element.getDepth();
    }
    return depth;
  }

  @override
  List<Gen>? getPathToUuid(String uuid) {
    if(uuid == this.uuid) return [this];
    for (final element in possibilities) {
      final path = element.getPathToUuid(uuid);
      if (path != null) return [this, ...path];
    }
    return null;
  }

  @override
  Gen? getByUuid(String uuid) {
    Gen? res;
    for (final element in possibilities) {
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
  String toString() => 'Random(${getDepth()})$possibilities';

  @override
  bool replaceByUuid(String uuid, Gen newGen) {
    for (final element in possibilities) {
      if (element.uuid == uuid) {
        possibilities[possibilities.indexOf(element)] = newGen;
        return true;
      } else {
        final uuFound = element.replaceByUuid(uuid, newGen);
        if (uuFound) return true;
      }
    }
    return false;
  }
}
