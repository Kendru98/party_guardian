import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:party_guardian/models/alcohol_model.dart';
import 'package:party_guardian/models/userdata.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dateRange;
  final controllerpercent = TextEditingController();
  final controllervolume = TextEditingController();
  final userinfo = UserData;

  var select;
  String dropdownvalue = 'Custom';
  String from = 'Od';
  String until = 'Do';

  @override
  Widget build(BuildContext context) {
    List gender = ['women', 'men'];
    TextEditingController controllerweight = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xff3f51b5), Color(0xff9c27b0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 80)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text('Kobieta'),
                    Radio(
                      value: gender[0],
                      groupValue: select,
                      onChanged: (value) {
                        setState(() {
                          select = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Mężczyzna'),
                    Radio(
                      value: gender[1],
                      groupValue: select,
                      onChanged: (value) {
                        setState(() {
                          select = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            //Columna
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 17, 94, 131),
                ),
              ),
              height: 50,
              margin: const EdgeInsets.only(bottom: 10),
              width: 100,
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Waga',
                    labelStyle: TextStyle(color: Colors.white)),
                controller: controllerweight,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(
                      context,
                      onConfirm: (time) {
                        setState(() {
                          from = DateFormat('dd-MM hh:mm').format(time);
                        });
                      },
                    );
                  },
                  child: Text(from),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.white),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(
                      context,
                      onConfirm: (time) {
                        setState(() {
                          until = DateFormat('dd-MM hh:mm').format(time);
                        });
                      },
                    );
                  },
                  child: Text(until),
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () async {},
              child: const Text('Przelicz'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  DropdownButton(
                      value: dropdownvalue,
                      onChanged: (String? newvalue) {
                        setState(() {
                          dropdownvalue = newvalue!;
                          controllerpercent.text = '5.0 ';
                        });
                      },
                      items: <String>[
                        'Custom',
                        'Beer',
                        'Wine',
                        'Shot',
                        'Champagne',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    height: 35,
                    //margin: const EdgeInsets.only(bottom: 10),
                    width: 75,
                    child: TextFormField(
                      controller: controllerpercent,
                      decoration: const InputDecoration(
                        suffixText: '%',
                        // hintText: '%',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    height: 35,
                    //margin: const EdgeInsets.only(bottom: 10),
                    width: 75,
                    child: TextFormField(
                      controller: controllervolume,
                      decoration: const InputDecoration(
                        suffixText: 'ml',
                        // labelText: 'ml',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: Text(index.toString()),
                  );
                })),
          ],
        ),
      ),
    );
  }

  frompicker() {
    return DatePicker.showDateTimePicker(
      context,
    );
  }

  String untilpicker(DateTime czas) {
    return czas.toString();
  }
}
