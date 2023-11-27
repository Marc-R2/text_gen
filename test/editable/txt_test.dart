import 'package:test/test.dart';
import 'package:text_gen/text_gen.dart';

void main() {
  group('Txt', () {
    test('buildArguments returns correct text', () {
      final txt = EditableTxt(text: 'Hello, world!');
      expect(txt.buildArguments(), equals('Hello, world!'));
    });

    test('toString returns correct string', () {
      final txt = EditableTxt(text: 'Hello, world!');
      expect(txt.toString(), equals('Txt(Hello, world!)'));
    });

    test('buildVariant returns correct text', () {
      final txt = EditableTxt(text: 'Hello, world!');
      expect(txt.buildVariant(), equals('Hello, world!'));
    });

    test('getDepth returns 1', () {
      final txt = EditableTxt(text: 'Hello, world!');
      expect(txt.getDepth(), equals(1));
    });

    test('getPathToUuid returns null if UUID does not match', () {
      final txt = EditableTxt(text: 'Hello, world!');
      expect(txt.getPathToUuid('invalid-uuid'), isNull);
    });

    test('getPathToUuid returns list with this object if UUID matches', () {
      final txt = EditableTxt(text: 'Hello, world!');
      expect(txt.getPathToUuid(txt.uuid), equals([txt]));
    });

    test('getByUuid returns null if UUID does not match', () {
      final txt = EditableTxt(text: 'Hello, world!');
      expect(txt.getByUuid('invalid-uuid'), isNull);
    });

    test('getByUuid returns this object if UUID matches', () {
      final txt = EditableTxt(text: 'Hello, world!');
      expect(txt.getByUuid(txt.uuid), equals(txt));
    });

    test('replaceByUuid always returns false', () {
      final txt = EditableTxt(text: 'Hello, world!');
      expect(txt.replaceByUuid(txt.uuid, txt), isFalse);
    });
  });
}
