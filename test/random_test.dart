import 'package:test/test.dart';
import 'package:text_gen/text_gen.dart';

void main() {
  group('Random', () {
    test('buildVariant returns a string with expected length', () {
      final randomGen = Random(
        possibilities: [
          Txt(text: 'foo'),
          Txt(text: 'bar'),
          Txt(text: 'baz'),
        ],
      );

      expect(randomGen.buildVariant(0), equals('foo'));
      expect(randomGen.buildVariant(1), equals('bar'));
      expect(randomGen.buildVariant(2), equals('baz'));
    });

    test('getDepth returns the correct depth', () {
      final randomGen = Random(
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

    test('getPathToUuid returns the correct path', () {
      final child1 = Txt(text: 'foo');
      final child2 = Txt(text: 'bar');
      final child3 = Txt(text: 'baz');
      final randomGen = Random(possibilities: [child1, child2, child3]);

      expect(randomGen.getPathToUuid(child1.uuid), equals([randomGen, child1]));
      expect(randomGen.getPathToUuid(child2.uuid), equals([randomGen, child2]));
      expect(randomGen.getPathToUuid(child3.uuid), equals([randomGen, child3]));
    });

    test('getByUuid returns the correct child', () {
      final child1 = Txt(text: 'foo');
      final child2 = Txt(text: 'bar');
      final child3 = Txt(text: 'baz');
      final randomGen = Random(possibilities: [child1, child2, child3]);

      expect(randomGen.getByUuid(child1.uuid), equals(child1));
      expect(randomGen.getByUuid(child2.uuid), equals(child2));
      expect(randomGen.getByUuid(child3.uuid), equals(child3));
    });

    test('replaceByUuid replaces the correct child', () {
      final child1 = Txt(text: 'foo');
      final child2 = Txt(text: 'bar');
      final child3 = Txt(text: 'baz');
      final randomGen = Random(possibilities: [child1, child2, child3]);
      final newTxt = Txt(text: 'qux');

      expect(randomGen.replaceByUuid(child2.uuid, newTxt), isTrue);
      expect(randomGen.possibilities, equals([child1, newTxt, child3]));
    });
  });
}
