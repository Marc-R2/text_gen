import 'package:test/test.dart';
import 'package:text_gen/text_gen.dart';

void main() {
  group('GeneratedParser', () {
    test('should parse simple text', () {
      const input = 'Hello';
      final expected = Capsule(encapsulated: [Txt(text: input)]);
      final parsed = GeneratedParser.parse(input);
      expect(parsed, equals(expected));
      expect(parsed.toString(), equals(expected.toString()));
      expect(parsed?.buildArguments(), equals('($input)'));
    });

    test('should parse encapsulated text', () {
      const input = '(Hello, world!)';
      final expected = Capsule(
        encapsulated: [Txt(text: 'Hello,'), Txt(text: 'world!')],
      );
      final parsed = GeneratedParser.parse(input);
      expect(parsed, equals(expected));
      expect(parsed.toString(), equals(expected.toString()));
      expect(parsed?.buildArguments(), equals(input));
    });

    test('should parse nested encapsulated text', () {
      const input = '(Hello, (beautiful) world!)';
      final expected = Capsule(
        encapsulated: [
          Txt(text: 'Hello,'),
          Capsule(encapsulated: [Txt(text: 'beautiful')]),
          Txt(text: 'world!'),
        ],
      );
      final parsed = GeneratedParser.parse(input);
      expect(parsed, equals(expected));
      expect(parsed.toString(), equals(expected.toString()));
      expect(parsed?.buildArguments(), equals(input));
    });

    test('should parse random text', () {
      const input = '{Hello Hi}, {world universe}!';
      final expected = Capsule(
        encapsulated: [
          Random(possibilities: [Txt(text: 'Hello'), Txt(text: 'Hi')]),
          Txt(text: ','),
          Random(possibilities: [Txt(text: 'world'), Txt(text: 'universe')]),
          Txt(text: '!'),
        ],
      );
      final parsed = GeneratedParser.parse(input);
      expect(parsed, equals(expected));
      expect(parsed.toString(), equals(expected.toString()));
    });
  });
}
