part of '../../text_gen.dart';

class GeneratedParser {
  static EditableGen? parse(String txt) {
    final chars = txt.split('');
    if (chars.isEmpty) return null;

    if (chars.first != '(') chars.insert(0, '(');
    if (chars.last != ')') chars.add(')');

    EditableGen? current;
    final stack = <EditableGen>[];

    for (final i in chars) {
      switch (i) {
        case ' ':
          if (current is EditableTxt) {
            final tmp = stack.last;
            if (tmp is EditableCapsule) tmp.add(current);
            if (tmp is EditableRandom) tmp.add(current);
            current = stack.removeLast();
          }
          break;
        case '(':
          if (current is EditableTxt) {
            final tmp = stack.last;
            if (tmp is EditableCapsule) tmp.add(current);
            if (tmp is EditableRandom) tmp.add(current);
            current = stack.removeLast();
          }
          if (current != null) stack.add(current);
          current = EditableCapsule(encapsulated: []);
          break;
        case ')':
          if (current is EditableTxt) {
            final tmp = stack.last;
            if (tmp is EditableCapsule) tmp.add(current);
            if (tmp is EditableRandom) tmp.add(current);
            current = stack.removeLast();
          }
          if (stack.isNotEmpty && current != null) {
            stack.last.add(current);
            current = stack.removeLast();
          }
          break;
        case '{':
          if (current is EditableTxt) {
            final tmp = stack.last;
            if (tmp is EditableCapsule) tmp.add(current);
            if (tmp is EditableRandom) tmp.add(current);
            current = stack.removeLast();
          }
          if (current != null) stack.add(current);
          current = EditableRandom(possibilities: []);
          break;
        case '}':
          if (current is EditableTxt) {
            final tmp = stack.last;
            if (tmp is EditableCapsule) tmp.add(current);
            if (tmp is EditableRandom) tmp.add(current);
            current = stack.removeLast();
          }
          if (stack.isNotEmpty && current != null) {
            stack.last.add(current);
            current = stack.removeLast();
          }
          break;
        default:
          if (current is EditableTxt) {
            current.addString(i);
          } else {
            if (current != null) stack.add(current);
            current = EditableTxt(text: i);
          }
      }
    }
    return current;
  }
}
