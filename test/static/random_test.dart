import 'package:test/test.dart';
import 'package:text_gen/text_gen.dart';

void main() {
  group('Random', () {
    test('buildVariant returns a string with expected length', () {
      const randomGen = Random(
        possibilities: [
          Txt(text: 'foo'),
          Txt(text: 'bar'),
          Txt(text: 'baz'),
        ],
      );

      expect(randomGen.buildVariantNum(0), equals('foo'));
      expect(randomGen.buildVariantNum(1), equals('bar'));
      expect(randomGen.buildVariantNum(2), equals('baz'));
    });

    test('getDepth returns the correct depth', () {
      const randomGen = Random(
        possibilities: [
          Txt(text: 'foo'),
          Capsule(
            encapsulated: [
              Txt(text: 'bar'),
              Txt(text: 'baz'),
            ],
          ),
        ],
      );

      expect(randomGen.getDepth(), equals(2));
    });
  });
}
