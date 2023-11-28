import 'package:test/test.dart';
import 'package:text_gen/text_gen.dart';

void main() {
  group('GeneratedParser', () {
    test('should parse simple text', () {
      const input = 'Hello';
      final expected = EditableCapsule(encapsulated: [EditableTxt(text: input)]);
      final parsed = GeneratedParser.parse(input);
      expect(parsed, equals(expected));
      expect(parsed.toString(), equals(expected.toString()));
      expect(parsed?.buildArguments(), equals('($input)'));

      final rebuild = parsed?.buildArguments() ?? '';
      final reParsed = GeneratedParser.parse(rebuild);
      expect(reParsed, equals(expected));
      expect(reParsed.toString(), equals(expected.toString()));
    });

    test('should parse encapsulated text', () {
      const input = '(Hello, world!)';
      final expected = EditableCapsule(
        encapsulated: [EditableTxt(text: 'Hello,'), EditableTxt(text: 'world!')],
      );
      final parsed = GeneratedParser.parse(input);
      expect(parsed, equals(expected));
      expect(parsed.toString(), equals(expected.toString()));
      expect(parsed?.buildArguments(), equals(input));

      final rebuild = parsed?.buildArguments() ?? '';
      final reParsed = GeneratedParser.parse(rebuild);
      expect(reParsed, equals(expected));
      expect(reParsed.toString(), equals(expected.toString()));
    });

    test('should parse nested encapsulated text', () {
      const input = '(Hello, (beautiful) world!)';
      final expected = EditableCapsule(
        encapsulated: [
          EditableTxt(text: 'Hello,'),
          EditableCapsule(encapsulated: [EditableTxt(text: 'beautiful')]),
          EditableTxt(text: 'world!'),
        ],
      );
      final parsed = GeneratedParser.parse(input);
      expect(parsed, equals(expected));
      expect(parsed.toString(), equals(expected.toString()));
      expect(parsed?.buildArguments(), equals(input));

      final rebuild = parsed?.buildArguments() ?? '';
      final reParsed = GeneratedParser.parse(rebuild);
      expect(reParsed, equals(expected));
      expect(reParsed.toString(), equals(expected.toString()));
    });

    test('should parse random text', () {
      const input = '{Hello Hi}, {world universe}!';
      final expected = EditableCapsule(
        encapsulated: [
          EditableRandom(possibilities: [EditableTxt(text: 'Hello'), EditableTxt(text: 'Hi')]),
          EditableTxt(text: ','),
          EditableRandom(possibilities: [EditableTxt(text: 'world'), EditableTxt(text: 'universe')]),
          EditableTxt(text: '!'),
        ],
      );
      final parsed = GeneratedParser.parse(input);
      expect(parsed, equals(expected));
      expect(parsed.toString(), equals(expected.toString()));

      final rebuild = parsed?.buildArguments() ?? '';
      final reParsed = GeneratedParser.parse(rebuild);
      expect(reParsed, equals(expected));
      expect(reParsed.toString(), equals(expected.toString()));
    });
  });
}
