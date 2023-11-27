part of '../../text_gen.dart';

/// A [EditableGen] that chooses a random [EditableGen] from a list of [possibilities].
class EditableRandom extends EditableGen<Random> {
  /// Creates a [EditableRandom] with a list of possible [EditableGen] to choose from.
  EditableRandom({required this.possibilities});

  /// The list of possible Gen to choose from.
  List<EditableGen> possibilities;

  @override
  void add(EditableGen i) => possibilities.add(i);

  @override
  List<EditableGen>? getPathToUuid(String uuid) {
    if (uuid == this.uuid) return [this];
    for (final element in possibilities) {
      final path = element.getPathToUuid(uuid);
      if (path != null) return [this, ...path];
    }
    return null;
  }

  @override
  EditableGen? getByUuid(String uuid) {
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
  bool replaceByUuid(String uuid, EditableGen newGen) {
    for (final element in possibilities) {
      if (element.uuid == uuid) {
        possibilities[possibilities.indexOf(element)] = newGen;
        return true;
      }
      if (element.replaceByUuid(uuid, newGen)) return true;
    }
    return false;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditableRandom &&
          runtimeType == other.runtimeType &&
          possibilities.length == other.possibilities.length &&
          possibilities
              .every((element) => other.possibilities.contains(element));

  @override
  int get hashCode => possibilities.fold(0, (hash, el) => hash + el.hashCode);

  @override
  Random toStaticGen() {
    return Random(
      possibilities: possibilities.map((e) => e.toStaticGen()).toList(),
    );
  }
}
