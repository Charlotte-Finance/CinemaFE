part of 'forms.dart';

Map<dynamic, bool> computeMap(List<dynamic> elements, [List<dynamic>? checkedElements]) {
  Map<dynamic, bool> map = {};
  elements.forEach((element) => map[element] = false);
  if (checkedElements != null) {
    checkedElements.forEach((checkedElement) => map[checkedElement] = true);
  }
  return map;

}

class CheckBoxForm extends StatefulWidget {
  final List<dynamic> elements;
  final Map<dynamic, bool> elementMap;
  final Function textFromKey;
  final List selectedElements;
  final bool empty;
  final function;
  final int maximum;
  final List<dynamic>? checkedElements;

  CheckBoxForm({
    required this.elements,
    required this.elementMap,
    required this.textFromKey,
    required this.selectedElements,
    required this.function,
    required this.maximum,
    required this.empty,
    this.checkedElements,
  });

  @override
  _CheckBoxFormState createState() => _CheckBoxFormState(
        elements: elements,
        elementMap: computeMap(elements, checkedElements),
        textFromKey: textFromKey,
        selectedElements: selectedElements,
        function: function,
        maximum: maximum,
        empty: empty,
      );
}

class _CheckBoxFormState extends State<CheckBoxForm> {
  final List<dynamic> elements;
  final Map<dynamic, bool> elementMap;
  final Function textFromKey;
  final List selectedElements;
  final function;
  final int maximum;
  bool empty;

  _CheckBoxFormState({
    required this.elements,
    required this.elementMap,
    required this.textFromKey,
    required this.selectedElements,
    required this.function,
    required this.maximum,
    required this.empty,
  });

  void onCategorySelected(
      bool selected, elementMap, boxIndex, function, elements, maximum) {
    function(selected, elementMap, boxIndex, elements, maximum);
  }

  @override
  Widget build(BuildContext context) {
    empty = widget.empty;
    return Stack(
      children: [
        ListView.builder(
          itemCount: elements.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                if (index == 0 && empty) ...[
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Please check at least one element",
                    style: TextStyle(color: Colors.red),
                  )
                ],
                SizedBox(height: 15),
                Card(
                  child: Container(
                    height: 50,
                    color: elementMap[elements[index]] ?? false
                        ? Colors.lightBlue[900]!
                        : Colors.white,
                    child: CheckboxListTile(
                      checkColor: Colors.lightBlue[900]!,
                      // color of tick Mark
                      activeColor: Colors.white,
                      value: elementMap[elements[index]],
                      onChanged: (bool? selected) {
                        onCategorySelected(selected!, elementMap, index,
                            function, elements, maximum);
                      },
                      title: Text(
                        textFromKey(elements[index]),
                        maxLines: 2,
                        style: TextStyle(
                          color: elementMap[elements[index]] ?? false
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            );
          },
        )
      ],
    );
  }
}


String textStringCheckBox(String string) {
  return string;
}
