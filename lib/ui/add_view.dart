import 'package:flutter/material.dart';
import 'package:practise/net/flutterfire.dart';

class AddView extends StatefulWidget {
  final String uid;
  final String type;
  final String weight;
  final bool isUpdate;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  AddView({
    required this.type,
    required this.weight,
    required this.isUpdate,
    required this.uid,
  });

  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> measure = ["kg", "lbs", "pound"];
  String dropdownValue = "kg";
  TextEditingController _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextFormField(
                  controller: _weightController = TextEditingController(
                    text: widget.weight == "-0" ? null : widget.weight,
                  ),
                  decoration: const InputDecoration(labelText: "Weight"),
                ),
              ),
              DropdownButton(
                value: widget.type == "-0" ? dropdownValue : widget.type,
                items: measure.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 35,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.blueAccent,
            ),
            child: MaterialButton(
              onPressed: () async {
                widget.isUpdate
                    ? await updateWeight(
                        widget.uid, widget.type, _weightController.text)
                    : await addCoin(dropdownValue, _weightController.text);
                Navigator.of(context).pop();
              },
              child: Text(
                widget.isUpdate == false ? "Add" : "Update",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
