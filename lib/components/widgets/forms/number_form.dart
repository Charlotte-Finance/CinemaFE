part of 'forms.dart';

class NumberFormQuestion extends StatelessWidget {
  final String question;
  final String? initialValue;
  final onSaved;
  final bool autofocus;
  final onChanged;
  final bool? acceptEmpty;
  final bool? acceptComma;

  const NumberFormQuestion({
    required this.question,
    this.initialValue,
    required this.onSaved,
    this.acceptComma = false,
    this.autofocus = false,
    this.onChanged,
    this.acceptEmpty,
  });

  @override
  //ToDO : ALLOW OR NOT DOUBLE NUMBERS
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        autofocus: autofocus,
        inputFormatters: (acceptComma == true)
            ? [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+'))]
            : [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        initialValue: initialValue == "null" ? "" : initialValue,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          labelText: question,
        ),
        validator: (answer) {
          if (acceptEmpty == true) {
            return null;
          } else {
            if (answer == null || answer.isEmpty) {
              return 'Please enter a value for the field $question';
            }
            return null;
          }
        },
        onSaved: onSaved,
        onChanged: onChanged,
      ),
    );
  }
}
