import 'package:test/test.dart';
import 'package:text_gen/text_gen.dart';

void main() {
  group('Capsule', () {
    test('buildArguments', () {
      final c = EditableCapsule(
        encapsulated: [EditableTxt(text: 'Hello,'), EditableTxt(text: 'world!')],
      );
      expect(c.buildArguments(), equals('(Hello, world!)'));
    });

    test('getDepth', () {
      final c = EditableCapsule(
        encapsulated: [
          EditableTxt(text: 'Hello,'),
          EditableCapsule(encapsulated: [EditableTxt(text: 'world!'), EditableTxt(text: 'Goodbye,')]),
          EditableTxt(text: 'cruel world.'),
        ],
      );
      expect(c.getDepth(), equals(1));
    });

    test('buildVariant', () {
      final c = EditableCapsule(
        encapsulated: [
          EditableTxt(text: 'A'),
          EditableCapsule(encapsulated: [EditableTxt(text: 'B'), EditableTxt(text: 'C')]),
          EditableTxt(text: 'D'),
        ],
      );

      // Variant 0
      expect(c.buildVariant(0), equals('A B C D'));

      // Variant 1
      expect(c.buildVariant(1), equals(null));
    });

    test('getByUuid', () {
      final c = EditableCapsule(
        encapsulated: [
          EditableTxt(text: 'A'),
          EditableCapsule(encapsulated: [EditableTxt(text: 'B'), EditableTxt(text: 'C')]),
          EditableTxt(text: 'D'),
        ],
      );

      expect(c.getByUuid(c.encapsulated[1].uuid), equals(c.encapsulated[1]));
      expect(c.getByUuid('nonexistent-uuid'), equals(null));
    });

    test('getPathToUuid', () {
      final c = EditableCapsule(
        encapsulated: [
          EditableTxt(text: 'A'),
          EditableCapsule(encapsulated: [EditableTxt(text: 'B'), EditableTxt(text: 'C')]),
          EditableTxt(text: 'D'),
        ],
      );

      expect(
        c.getPathToUuid(c.encapsulated[1].uuid),
        equals([c, c.encapsulated[1]]),
      );
      expect(c.getPathToUuid('nonexistent-uuid'), equals(null));
    });

    test('replaceByUuid', () {
      final c = EditableCapsule(
        encapsulated: [
          EditableTxt(text: 'A'),
          EditableCapsule(encapsulated: [EditableTxt(text: 'B'), EditableTxt(text: 'C')]),
          EditableTxt(text: 'D'),
        ],
      );

      final newGen = EditableTxt(text: 'E');
      expect(c.replaceByUuid(c.encapsulated[1].uuid, newGen), equals(true));
      expect(c.encapsulated[1], equals(newGen));
      expect(c.replaceByUuid('nonexistent-uuid', newGen), equals(false));
    });
  });
}
