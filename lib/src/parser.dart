part of '../text_gen.dart';

class GeneratedParser {
  static Gen? parse(String txt) {
    final chars = txt.split('');
    if (chars.isEmpty) return null;

    if(chars.first != '(') chars.insert(0, '(');
    if(chars.last != ')') chars.add(')');

    Gen? current;
    final stack = <Gen>[];

    for (final i in chars) {
      if (i == ' ') {
        if (current is Txt) {
          final tmp = stack.last;
          if (tmp is Capsule) tmp.add(current);
          if (tmp is Random) tmp.add(current);
          current = stack.removeLast();
        }
      } else if (i == '(') {
        if (current is Txt) {
          final tmp = stack.last;
          if (tmp is Capsule) tmp.add(current);
          if (tmp is Random) tmp.add(current);
          current = stack.removeLast();
        }
        if (current != null) stack.add(current);
        current = Capsule(encapsulated: []);
      } else if (i == ')') {
        if (current is Txt) {
          final tmp = stack.last;
          if (tmp is Capsule) tmp.add(current);
          if (tmp is Random) tmp.add(current);
          current = stack.removeLast();
        }
        if (stack.isNotEmpty && current != null) {
          stack.last.add(current);
          current = stack.removeLast();
        }
      } else if (i == '{') {
        if (current is Txt) {
          final tmp = stack.last;
          if (tmp is Capsule) tmp.add(current);
          if (tmp is Random) tmp.add(current);
          current = stack.removeLast();
        }
        if (current != null) stack.add(current);
        current = Random(possibilities: []);
      } else if (i == '}') {
        if (current is Txt) {
          final tmp = stack.last;
          if (tmp is Capsule) tmp.add(current);
          if (tmp is Random) tmp.add(current);
          current = stack.removeLast();
        }
        if (stack.isNotEmpty && current != null) {
          stack.last.add(current);
          current = stack.removeLast();
        }
      } else {
        if (current is Txt) {
          current.add(Txt(text: i));
        } else {
          if (current != null) stack.add(current);
          current = Txt(text: i);
        }
      }
    }
    return current;
  }
}
