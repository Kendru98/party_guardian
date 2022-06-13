import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:party_guardian/models/alcohol_model.dart';
import 'package:party_guardian/models/userdata.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:party_guardian/screens/results_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controllerpercent = TextEditingController();
  final controllervolume = TextEditingController();
  final controllerweight = TextEditingController();
  final userinfo = UserData;
  List<Alcohols> currentAlcohols = [];
  late DateTime untildate;
  late DateTime fromdate;
  var select;
  String dropdownvalue = 'Custom';
  var from = 'Od';
  var until = 'Do';
  bool frombool = false;
  bool untilbool = false;
  @override
  Widget build(BuildContext context) {
    List gender = ['women', 'men'];

    return Scaffold(
      backgroundColor: Color(0xff7046e0),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        color: Color(0xff7046e0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 80)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text('Kobieta',
                          style: Theme.of(context).textTheme.headline1),
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
                      Text('Mężczyzna',
                          style: Theme.of(context).textTheme.headline1),
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
                      color: Color(0xff255EDA),
                    ),
                    color: Color(0xffF6F4FB)),
                height: 40,
                margin: const EdgeInsets.only(bottom: 10),
                width: 100,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        bottom: 20 / 2,
                      ),
                      suffixText: 'kg',
                      labelText: 'Waga',
                      labelStyle: Theme.of(context).textTheme.headline3),
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
                            from = DateFormat('dd-MM HH:mm').format(time);
                            fromdate = time;
                            frombool = true;
                          });
                        },
                      );
                    },
                    child: Text(from,
                        style: Theme.of(context).textTheme.headline1),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, color: Colors.white),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(
                        context,
                        onConfirm: (time) {
                          setState(() {
                            until = DateFormat('dd-MM HH:mm').format(time);
                            untildate = time;
                            untilbool = true;
                          });
                        },
                      );
                    },
                    child: Text(until,
                        style: Theme.of(context).textTheme.headline1),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 35,
                      width: 161,
                      color: Colors.white,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(
                                bottom: 35 / 2,
                              ),
                              prefixIcon: Icon(
                                FontAwesomeIcons.percent,
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                            iconSize: 22,
                            style: Theme.of(context).textTheme.headline2,
                            value: dropdownvalue,
                            onChanged: (String? newvalue) {
                              setState(() {
                                dropdownvalue = newvalue!;
                                suggestvalues(newvalue);
                              });
                            },
                            items: <String>[
                              'Custom',
                              'Beer',
                              'Wine',
                              'Vodka',
                              'Champagne',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffF6F4FB),
                      ),
                      height: 35,
                      width: 65,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2,
                        controller: controllerpercent,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                            bottom: 30 / 2,
                          ),
                          suffixText: '%',
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffF6F4FB),
                      ),
                      height: 35,
                      width: 65,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2,
                        controller: controllervolume,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                            bottom: 30 / 2,
                          ),
                          suffixText: 'ml',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                      onPressed: () async {
                        currentAlcohols.add(Alcohols(
                            name: dropdownvalue,
                            percent: double.parse(controllerpercent.text),
                            volume: double.parse(controllervolume.text)));
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (validation() == true) {
                    CalculationData calculationData = CalculationData(
                        select,
                        controllerweight.text,
                        hoursBetween(fromdate, untildate),
                        currentAlcohols,
                        fromdate,
                        untildate);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ResultPage(
                                  calcdata: calculationData,
                                  chartdata: chartdata(fromdate, untildate,
                                      calculateBAC(calculationData)),
                                ))));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Uzupełnij wszystkie dane!')));
                  }
                },
                child: Text(
                  'Oblicz czas trzeźwienia',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              ListView.builder(
                  itemCount: currentAlcohols.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    final alcoList = currentAlcohols[index];
                    return buildList(context, alcoList);
                  })),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, Alcohols alcoList) {
    return ListTile(
      leading: SizedBox(
        width: 86,
        child: Column(
          children: [
            chooseIcon(alcoList.name),
            Text(
              alcoList.name,
              overflow: TextOverflow.clip,
            ),
          ],
        ),
      ),
      title: Text('${alcoList.percent} %'),
      subtitle: Text('${alcoList.volume} ml'),
      trailing: IconButton(
        onPressed: () {
          currentAlcohols.remove(alcoList);
          setState(() {});
        },
        icon: IconButton(
            onPressed: () {
              currentAlcohols.remove(alcoList);
              setState(() {});
            },
            icon: const Icon(
              FontAwesomeIcons.x,
              color: Colors.red,
            )),
      ),
    );
  }

  void suggestvalues(String newvalue) {
    if (newvalue == 'Beer') {
      controllerpercent.text = '5.0 ';
      controllervolume.text = '500';
    } else if (newvalue == 'Wine') {
      controllerpercent.text = '13.0 ';
      controllervolume.text = '175';
    } else if (newvalue == 'Champagne') {
      controllerpercent.text = '11.0 ';
      controllervolume.text = '120';
    } else if (newvalue == 'Vodka') {
      controllerpercent.text = '40.0';
      controllervolume.text = '50';
    }
  }

  frompicker() {
    return DatePicker.showDateTimePicker(
      context,
    );
  }

  String untilpicker(DateTime czas) {
    return czas.toString();
  }

  bool validation() {
    if (currentAlcohols.isNotEmpty &&
        controllerweight.text.isNotEmpty &&
        frombool == true &&
        untilbool == true &&
        select != null) {
      return true;
    } else {
      return false;
    }
  }

  chooseIcon(String name) {
    if (name == 'Beer') {
      return Icon(
        FontAwesomeIcons.beerMugEmpty,
        size: 40,
      );
    } else if (name == 'Wine') {
      return Icon(FontAwesomeIcons.wineGlass, size: 40);
    } else if (name == 'Champagne') {
      return Icon(FontAwesomeIcons.champagneGlasses, size: 40);
    } else if (name == 'Vodka') {
      return Icon(Icons.liquor_rounded, size: 40);
    }
  }
}
