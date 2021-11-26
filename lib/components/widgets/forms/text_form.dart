part of 'forms.dart';

class TextFormQuestion extends StatelessWidget {
  final String question;
  final String? initialValue;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool autofocus;
  final bool obscureText;
  final int? numberLine;
  final bool? acceptEmpty;

  const TextFormQuestion({
    Key? key,
    required this.question,
    required this.onSaved,
    this.initialValue,
    this.onChanged,
    this.onTap,
    this.autofocus = false,
    this.obscureText = false,
    this.numberLine = 1,
    this.acceptEmpty,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        maxLines: numberLine,
        obscureText: obscureText,
        onTap: onTap,
        autofocus: autofocus,
        initialValue: initialValue,
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
        onChanged: onChanged!,
      ),
    );
  }
}
