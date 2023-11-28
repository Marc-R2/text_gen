part of '../../text_gen.dart';

class EditableCapsule extends EditableGen<Capsule> {
  EditableCapsule({required this.encapsulated});

  final List<EditableGen> encapsulated;

  @override
  void add(EditableGen i) => encapsulated.add(i);

  @override
  List<EditableGen>? getPathToUuid(String uuid) {
    if (uuid == this.uuid) return [this];
    for (final element in encapsulated) {
      final path = element.getPathToUuid(uuid);
      if (path != null) return [this, ...path];
    }
    return null;
  }

  @override
  EditableGen? getByUuid(String uuid) {
    for (final element in encapsulated) {
      if (element.uuid == uuid) return element;

      final uuFound = element.getByUuid(uuid);
      if (uuFound != null) return uuFound;
    }
    return null;
  }

  @override
  bool replaceByUuid(String uuid, EditableGen newGen) {
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
    return other is EditableCapsule &&
        encapsulated.length == other.encapsulated.length &&
        encapsulated.every((el) => other.encapsulated.contains(el));
  }

  @override // hashCode
  int get hashCode => encapsulated.fold(0, (hash, el) => hash ^ el.hashCode);

  @override
  Capsule toStaticGen() {
    return Capsule(
      encapsulated: encapsulated.map((e) => e.toStaticGen()).toList(),
    );
  }
}
