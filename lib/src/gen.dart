part of '../text_gen.dart';

abstract class Gen {
  const Gen();

  String buildArguments();

  String? buildVariant([int? i]);

  int getDepth();
}

abstract class StaticGen extends Gen {
  const StaticGen();
}

abstract class EditableGen<T extends StaticGen> extends Gen {
  void add(EditableGen i);

  String? _uuid;

  String get uuid => _uuid ??= const Uuid().v4();

  EditableGen? getByUuid(String uuid);

  /// Replaces the existing element with [uuid] with [newGen].
  bool replaceByUuid(String uuid, EditableGen newGen);

  List<EditableGen>? getPathToUuid(String uuid);

  T toStaticGen();

  String buildArguments() => toStaticGen().buildArguments();

  String? buildVariant([int? i]) => toStaticGen().buildVariant(i);

  int getDepth() => toStaticGen().getDepth();

  @override
  String toString() => toStaticGen().toString();
}
