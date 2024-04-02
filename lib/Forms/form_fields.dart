import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:piq/Forms/required_field_visibility.dart';

import '../Utils/app_colors.dart';
import 'Form_Widgets/checkbox.dart';
import 'Form_Widgets/header.dart';
import 'Form_Widgets/radio_grp.dart';
import 'Form_Widgets/text_area.dart';
import 'Form_Widgets/text_field.dart';
import 'label.dart';

class Checklist extends StatefulWidget {
  const Checklist({Key? key});

  @override
  State<Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  late var formResponse;
  Map<String?, dynamic> formValues = {};
  bool isLoading = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      final uri = Uri.parse('https://piq.cccm.app/api/forms/1');
      var response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        setState(() {
          formResponse = json.decode(response.body);
          isLoading = false;
        });
      }
    } catch (err) {
      throw Exception('Failed to fetch data');
    }
  }

  Map<String?, bool> ruleBased = {};
  setRules() {
    for (var field in formResponse['data']['formConfigData'][0]) {
      ruleBased[field['name']] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> formFields = [];

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('PIQ Form'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    for (var field in formResponse['data']['formConfigData'][0]) {
      if (ruleBased.isEmpty) {
        setRules();
      }
      if (field['type'] == 'header') {
        formFields.add(
          HeaderWidget(
            label: field['label'],
            subtype: field['subtype'],
          ),
        );
      } else if (field['type'] == 'text' || field['type'] == 'number') {
        formFields.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Card(
              elevation: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: AppColors.primaryBackgroundColor,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: RichTextFieldWidget(
                          label: field['label'],
                          requiredField: field['required'],
                        ),
                      ),
                      TextFieldWidget(
                        field: field,
                        onChanged: (name, value) {
                          setState(() {
                            formValues[name] = value;
                          });
                        },
                        // initialValue:
                        // _getCurrentFieldValueFromState(field['name']),
                      ),
                      RequiredFieldMessage(
                        isVisible: field['required'] &&
                            !formValues.containsKey(field['name']),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      } else if (field['type'] == 'textarea') {
        formFields.add(
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Card(
              elevation: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: AppColors.primaryBackgroundColor,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: RichTextFieldWidget(
                          label: field['label'],
                          requiredField: field['required'],
                        ),
                      ),
                      TextAreaField(
                        field: field,
                        onChanged: (name, value) {
                          setState(() {
                            formValues[name] = value;
                          });
                        },
                        // initialValue:
                        // _getCurrentFieldValueFromState(field['name']),
                      ),
                      RequiredFieldMessage(
                        isVisible: field['required'] &&
                            !formValues.containsKey(field['name']),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      } else if (field['type'] == 'checkbox-group') {
        var items = field['values'] as List<dynamic>?;
        if (items != null) {
          var checkboxItems = items.map((item) {
            var itemValue = item['value'].toString();
            // var isChecked =
            // _getSelectedCheckboxValuesFromState(field['name'], itemValue);

            return {
              "label": item['label'].toString(),
              "value": itemValue,
              // "checked": isChecked,
            };
          }).toList();

          formFields.add(
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Card(
                elevation: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: AppColors.primaryBackgroundColor,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: RichTextFieldWidget(
                            label: field['label'],
                            requiredField: field['required'],
                          ),
                        ),
                        CheckboxGroupWidget(
                          items: checkboxItems,
                          requiredField: field['required'],
                          onChanged: (selectedValues) {
                            setState(() {
                              formValues[field['name']] = selectedValues;
                            });
                          },
                        ),
                        RequiredFieldMessage(
                          isVisible: field['required'] &&
                              !formValues.containsKey(field['name']),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          formFields.add(Text('Checkbox items are not available.'));
        }
      } else if (field['type'] == 'radio-group') {
        formFields.add(
          Visibility(
            visible: ruleBased[field['name']] ?? true,
            child: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Card(
                elevation: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: AppColors.primaryBackgroundColor,
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichTextFieldWidget(
                          label: field['label'],
                          requiredField: field['required'],
                        ),
                        RadioGroupWidget(
                          label: field['label'],
                          items: field['values'],
                          selectedValue: formValues[field['name']],
                          onChanged: (String? newValue) {
                            setState(() {
                              formValues[field['name']] = newValue;
                              if (newValue?.toLowerCase() == 'yes' ||
                                  newValue?.toLowerCase() == 'yes ') {
                                for (var checkRule in formResponse['data']
                                    ['rules']) {
                                  if (checkRule['ifData'][0]['if_field_name'] ==
                                          field['name'] &&
                                      checkRule['thenValue'][0]
                                              ['else_rule_type'] ==
                                          'hide') {
                                    for (var removeWidgets
                                        in checkRule['thenValue'][0]
                                            ['else_field_name']) {
                                      setState(() {
                                        ruleBased[removeWidgets] = false;
                                      });
                                    }
                                  }
                                }
                              } else {
                                for (var checkRule in formResponse['data']
                                    ['rules']) {
                                  if (checkRule['ifData'][0]['if_field_name'] ==
                                          field['name'] &&
                                      checkRule['thenValue'][0]
                                              ['else_rule_type'] ==
                                          'hide') {
                                    for (var removeWidgets
                                        in checkRule['thenValue'][0]
                                            ['else_field_name']) {
                                      setState(() {
                                        ruleBased[removeWidgets] = true;
                                      });
                                    }
                                  }
                                }
                              }
                            });
                          },
                          requiredField: field['required'],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        String capitalizedType =
            '${field['type'][0].toUpperCase()}${field['type'].substring(1)}';
        formFields.add(Text('$capitalizedType field is not available' ?? ''));
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'PIQ Form',
            style: GoogleFonts.lato(
              color: HexColor.fromHex("bf3a4a"),
              fontSize: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                ...formFields,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
