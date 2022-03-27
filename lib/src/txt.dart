part of '../text_gen.dart';

class Txt extends Gen {
  String text;

  Txt({required this.text});

  @override
  void add(Gen i) {
    if (i is Txt) text += i.text;
  }

  @override
  String buildArguments() {
    return text;
  }

  @override
  String toString() => 'Txt($text)';

  @override
  String buildVariant([int? i]) => text;

  @override
  int getDepth() => 1;

  @override
  List<Gen>? getPathToUuid(String uuid) {
    if (uuid == this.uuid) return [this];
    return null;
  }

  @override
  Gen? getByUuid(String uuid) {
    if (uuid == this.uuid) return this;
    return null;
  }

  @override
  bool replaceByUuid(String uuid, Gen newGen) => false;
}
