part of '../../text_gen.dart';

class EditableTxt extends EditableGen<Txt> {
  EditableTxt({required this.text});

  String text;

  @override
  void add(EditableGen i) {
    if (i is EditableTxt) text += i.text;
  }

  @override
  List<EditableGen>? getPathToUuid(String uuid) {
    if (uuid == this.uuid) return [this];
    return null;
  }

  @override
  EditableGen? getByUuid(String uuid) {
    if (uuid == this.uuid) return this;
    return null;
  }

  @override
  bool replaceByUuid(String uuid, EditableGen newGen) => false;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditableTxt && runtimeType == other.runtimeType && text == other.text;

  @override
  int get hashCode => text.hashCode;

  @override
  Txt toStaticGen() => Txt(text: text);
}
