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
  String? buildVariantNum(int i, StringBuffer buffer) {
    final depth = getDepth();
    if (i >= depth) return null;

    for (final element in encapsulated) {
      final depth = element.getDepth();
      if (element is Txt) {
        element.buildVariantNum(1, buffer);
      } else if (element is Capsule) {
        element.buildVariantNum(i % depth, buffer);
        i ~/= element.getDepth();
      } else if (element is Random) {
        final index = i % depth;
        element.buildVariantNum(index, buffer);
        i ~/= depth;
      }
    }
    return buffer.toString();
  }
}
