part of '../../text_gen.dart';

class Txt extends StaticGen {
  const Txt({required this.text});

  final String text;

  @override
  String buildArguments() => text;

  @override
  String toString() => 'Txt($text)';

  @override
  String buildVariant([int? i]) => text;

  @override
  int getDepth() => 1;
}
