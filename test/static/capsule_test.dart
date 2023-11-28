import 'package:test/test.dart';
import 'package:text_gen/text_gen.dart';

void main() {
  group('Capsule', () {
    test('buildArguments', () {
      const c = Capsule(
        encapsulated: [Txt(text: 'Hello,'), Txt(text: 'world!')],
      );
      expect(c.buildArguments(), equals('(Hello, world!)'));
    });

    test('getDepth', () {
      const c = Capsule(
        encapsulated: [
          Txt(text: 'Hello,'),
          Capsule(encapsulated: [Txt(text: 'world!'), Txt(text: 'Goodbye,')]),
          Txt(text: 'cruel world.'),
        ],
      );
      expect(c.getDepth(), equals(1));
    });

    test('buildVariant', () {
      const c = Capsule(
        encapsulated: [
          Txt(text: 'A'),
          Capsule(encapsulated: [Txt(text: 'B'), Txt(text: 'C')]),
          Txt(text: 'D'),
        ],
      );

      // Variant 0
      expect(c.buildVariant(0), equals('A B C D'));

      // Variant 1
      expect(c.buildVariant(1), equals(null));
    });
  });
}
