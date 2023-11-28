part of '../../text_gen.dart';

class Capsule extends StaticGen {
  const Capsule({required this.encapsulated});

  final List<StaticGen> encapsulated;

  @override
  String buildArguments() {
    final buffer = StringBuffer();
    for (final element in encapsulated) {
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(element.buildArguments());
    }
    return '($buffer)';
  }

  @override
  String toString() => 'Capsule(${getDepth()})$encapsulated';

  @override
  int getDepth() {
    var depth = 1;
    for (final element in encapsulated) {
      depth *= element.getDepth();
    }
    return depth;
  }

  @override

  /// Builds the ith variant of the encapsulated Gen and its children.
  String? buildVariantNum(int i) {
    final depth = getDepth();
    if (i >= depth) return null;

    final buffer = StringBuffer();

    for (final element in encapsulated) {
      if (buffer.isNotEmpty) buffer.write(' ');
      final depth = element.getDepth();
      if (element is Txt) {
        buffer.write(element.buildVariantNum(1));
      } else if (element is Capsule) {
        buffer.write(element.buildVariantNum(i % depth));
        i ~/= element.getDepth();
      } else if (element is Random) {
        final index = i % depth;
        buffer.write(element.buildVariantNum(index));
        i ~/= depth;
      }
    }
    return buffer.toString();
  }
}
