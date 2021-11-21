part of 'forms.dart';

class DropDownFormQuestion extends StatelessWidget {
  final String question;
  final String category;
  final List<Object> items;
  final itemAsString;
  final onSaved;
  final onChanged;
  final validator;
  final selectedItem;
  final bool? enabled;

  DropDownFormQuestion({
    required this.question,
    required this.category,
    required this.items,
    required this.itemAsString,
    required this.onSaved,
    this.onChanged,
    required this.validator,
    this.selectedItem,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: DropdownSearch<Object>(
        enabled: enabled ?? true,
        validator: validator,
        onSaved: onSaved,
        itemAsString: itemAsString,
        items: items,
        onChanged: onChanged,
        selectedItem: selectedItem,
        showSearchBox: true,
        dropdownSearchDecoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          labelText: "Search a $category",
        ),
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            labelText: "Search a $category",
          ),
        ),
      ),
    );
  }
}
