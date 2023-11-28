import 'package:test/test.dart';
import 'package:text_gen/text_gen.dart';

void main() {
  group('Random', () {
    test('buildVariant returns a string with expected length', () {
      final randomGen = EditableRandom(
        possibilities: [
          EditableTxt(text: 'foo'),
          EditableTxt(text: 'bar'),
          EditableTxt(text: 'baz'),
        ],
      );

      expect(randomGen.buildVariantNum(0), equals('foo'));
      expect(randomGen.buildVariantNum(1), equals('bar'));
      expect(randomGen.buildVariantNum(2), equals('baz'));
    });

    test('getDepth returns the correct depth', () {
      final randomGen = EditableRandom(
        possibilities: [
          EditableTxt(text: 'foo'),
          EditableCapsule(
            encapsulated: [
              EditableTxt(text: 'bar'),
              EditableTxt(text: 'baz'),
            ],
          ),
        ],
      );

      expect(randomGen.getDepth(), equals(2));
    });

    test('getPathToUuid returns the correct path', () {
      final child1 = EditableTxt(text: 'foo');
      final child2 = EditableTxt(text: 'bar');
      final child3 = EditableTxt(text: 'baz');
      final randomGen = EditableRandom(possibilities: [child1, child2, child3]);

      expect(randomGen.getPathToUuid(child1.uuid), equals([randomGen, child1]));
      expect(randomGen.getPathToUuid(child2.uuid), equals([randomGen, child2]));
      expect(randomGen.getPathToUuid(child3.uuid), equals([randomGen, child3]));
    });

    test('getByUuid returns the correct child', () {
      final child1 = EditableTxt(text: 'foo');
      final child2 = EditableTxt(text: 'bar');
      final child3 = EditableTxt(text: 'baz');
      final randomGen = EditableRandom(possibilities: [child1, child2, child3]);

      expect(randomGen.getByUuid(child1.uuid), equals(child1));
      expect(randomGen.getByUuid(child2.uuid), equals(child2));
      expect(randomGen.getByUuid(child3.uuid), equals(child3));
    });

    test('replaceByUuid replaces the correct child', () {
      final child1 = EditableTxt(text: 'foo');
      final child2 = EditableTxt(text: 'bar');
      final child3 = EditableTxt(text: 'baz');
      final randomGen = EditableRandom(possibilities: [child1, child2, child3]);
      final newTxt = EditableTxt(text: 'qux');

      expect(randomGen.replaceByUuid(child2.uuid, newTxt), isTrue);
      expect(randomGen.possibilities, equals([child1, newTxt, child3]));
    });
  });
}
