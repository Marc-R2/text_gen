part of '../../text_gen.dart';

enum Space {
  none(false, false),
  before(true, false),
  after(false, true),
  both(true, true);

  const Space(this.spaceBefore, this.spaceAfter);

  final bool spaceBefore;
  final bool spaceAfter;
}

class Txt extends StaticGen {
  const Txt({required this.text, this.space = Space.before});

  final String text;

  final Space space;

  @override
  String buildArguments() => text;

  @override
  String toString() => 'Txt($text)';

  @override
  void buildVariantNum(int i, StringBuffer buffer) {
    if (space.spaceBefore && buffer.isNotEmpty) buffer.write(' ');
    buffer.write(text);
    if (space.spaceAfter && text.isNotEmpty) buffer.write(' ');
  }

  @override
  int getDepth() => 1;
}
