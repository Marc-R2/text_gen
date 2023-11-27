part of '../../text_gen.dart';

class GeneratedParser {
  static EditableGen? parse(String txt) {
    final chars = txt.split('');
    if (chars.isEmpty) return null;

    if(chars.first != '(') chars.insert(0, '(');
    if(chars.last != ')') chars.add(')');

    EditableGen? current;
    final stack = <EditableGen>[];

    for (final i in chars) {
      if (i == ' ') {
        if (current is EditableTxt) {
          final tmp = stack.last;
          if (tmp is EditableCapsule) tmp.add(current);
          if (tmp is EditableRandom) tmp.add(current);
          current = stack.removeLast();
        }
      } else if (i == '(') {
        if (current is EditableTxt) {
          final tmp = stack.last;
          if (tmp is EditableCapsule) tmp.add(current);
          if (tmp is EditableRandom) tmp.add(current);
          current = stack.removeLast();
        }
        if (current != null) stack.add(current);
        current = EditableCapsule(encapsulated: []);
      } else if (i == ')') {
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
      } else if (i == '{') {
        if (current is EditableTxt) {
          final tmp = stack.last;
          if (tmp is EditableCapsule) tmp.add(current);
          if (tmp is EditableRandom) tmp.add(current);
          current = stack.removeLast();
        }
        if (current != null) stack.add(current);
        current = EditableRandom(possibilities: []);
      } else if (i == '}') {
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
      } else {
        if (current is EditableTxt) {
          current.add(EditableTxt(text: i));
        } else {
          if (current != null) stack.add(current);
          current = EditableTxt(text: i);
        }
      }
    }
    return current;
  }
}
