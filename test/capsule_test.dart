import 'package:test/test.dart';
import 'package:text_gen/text_gen.dart';

void main() {
  group('Capsule', () {
    test('buildArguments', () {
      final c = Capsule(
        encapsulated: [Txt(text: 'Hello,'), Txt(text: 'world!')],
      );
      expect(c.buildArguments(), equals('(Hello, world!)'));
    });

    test('getDepth', () {
      final c = Capsule(
        encapsulated: [
          Txt(text: 'Hello,'),
          Capsule(encapsulated: [Txt(text: 'world!'), Txt(text: 'Goodbye,')]),
          Txt(text: 'cruel world.'),
        ],
      );
      expect(c.getDepth(), equals(1));
    });

    test('buildVariant', () {
      final c = Capsule(
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

    test('getByUuid', () {
      final c = Capsule(
        encapsulated: [
          Txt(text: 'A'),
          Capsule(encapsulated: [Txt(text: 'B'), Txt(text: 'C')]),
          Txt(text: 'D'),
        ],
      );

      expect(c.getByUuid(c.encapsulated[1].uuid), equals(c.encapsulated[1]));
      expect(c.getByUuid('nonexistent-uuid'), equals(null));
    });

    test('getPathToUuid', () {
      final c = Capsule(
        encapsulated: [
          Txt(text: 'A'),
          Capsule(encapsulated: [Txt(text: 'B'), Txt(text: 'C')]),
          Txt(text: 'D'),
        ],
      );

      expect(
        c.getPathToUuid(c.encapsulated[1].uuid),
        equals([c, c.encapsulated[1]]),
      );
      expect(c.getPathToUuid('nonexistent-uuid'), equals(null));
    });

    test('replaceByUuid', () {
      final c = Capsule(
        encapsulated: [
          Txt(text: 'A'),
          Capsule(encapsulated: [Txt(text: 'B'), Txt(text: 'C')]),
          Txt(text: 'D'),
        ],
      );

      final newGen = Txt(text: 'E');
      expect(c.replaceByUuid(c.encapsulated[1].uuid, newGen), equals(true));
      expect(c.encapsulated[1], equals(newGen));
      expect(c.replaceByUuid('nonexistent-uuid', newGen), equals(false));
    });
  });
}
