import 'package:test/test.dart';
import 'package:text_gen/text_gen.dart';

void main() {
  group('Txt', () {
    test('buildArguments returns correct text', () {
      const txt = Txt(text: 'Hello, world!');
      expect(txt.buildArguments(), equals('Hello, world!'));
    });

    test('toString returns correct string', () {
      const txt = Txt(text: 'Hello, world!');
      expect(txt.toString(), equals('Txt(Hello, world!)'));
    });

    test('buildVariant returns correct text', () {
      const txt = Txt(text: 'Hello, world!');
      expect(txt.buildVariant(), equals('Hello, world!'));
    });

    test('getDepth returns 1', () {
      const txt = Txt(text: 'Hello, world!');
      expect(txt.getDepth(), equals(1));
    });
  });
}
