part of '../text_gen.dart';

abstract class Gen {
  void add(Gen i);

  String buildArguments();

  String? buildVariant([int? i]);

  int getDepth();

  String? _uuid;

  String get uuid => _uuid ??= const Uuid().v4();

  Gen? getByUuid(String uuid);

  /// Replaces the existing element with [uuid] with [newGen].
  bool replaceByUuid(String uuid, Gen newGen);

  List<Gen>? getPathToUuid(String uuid);
}
