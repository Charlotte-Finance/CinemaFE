part of 'forms.dart';

class DateFormQuestion extends StatelessWidget {
  final String question;
  final initialValue;
  final onSaved;
  final onChanged;
  final VoidCallback? onTap;
  final bool autofocus;
  final bool obscureText;
  final int? numberLine;
  final bool? acceptEmpty;
  final TextEditingController controller;

  DateFormQuestion({
    required this.question,
    this.initialValue,
    required this.onSaved,
    required this.controller,
    this.onChanged,
    this.onTap,
    this.autofocus = false,
    this.obscureText = false,
    this.numberLine = 1,
    this.acceptEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        autofocus: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          labelText: question,
        ),
        controller: controller,
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          controller.text = date!.toIso8601String();
        },
        onSaved: onSaved,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter chose the start date';
          }
          return null;
        },
      ),
    );

  }
}
