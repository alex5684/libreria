import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class InputData extends StatefulWidget {
  @override
  InputDataState createState() => InputDataState();
}
enum SingingCharacter { lafayette, jefferson }
const List<String> listClassi = <String>[
  '1A',	'1B',	'1C',	'1D',	'1E',	'1F',	'1G',	'1H',
  '2A',	'2B',	'2C',	'2D',	'2E',	'2F',	'2G',	'2H',
  '3A',	'3B',	'3C',	'3D',	'3E',	'3F',	'3FA',	'3FI',	'3G',
  '4A',	'4B',	'4C',	'4D',	'4E',	'4F',	'4FA',	'4FI',	'4G',	'4H',
  '5A',	'5B',	'5C',	'5D',	'5E',	'5F'];
const List<String> listMaterie = <String>['Italiano', 'Storia', 'Francese', 'Inglese', 'Sistemi', 'Informatica'];

class InputDataState extends State<InputData> {
  TextEditingController userInput = TextEditingController();
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerCognome = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerTelefono = TextEditingController();
  final TextEditingController controllerClasse = TextEditingController();
  final TextEditingController controllerMateria = TextEditingController();
  final TextEditingController controllerTitolo = TextEditingController();
  final TextEditingController controllerCondizione = TextEditingController();
  final TextEditingController controllerPrezzo = TextEditingController();
  final TextEditingController controllerDisponibile = TextEditingController();
  String text = "";

  SingingCharacter? _character = SingingCharacter.lafayette;

  bool status = false;
  String messaggio= 'NON Disponibile';

  String dropdownValueClassi = listClassi.first;
  String dropdownValueMaterie = listMaterie.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page Demo"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child:
                Column(
                  children: [
                    TextFormField(
                      controller: controllerNome,
                      keyboardType: TextInputType.text,
                      decoration:
                      const InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: controllerCognome,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Cognome',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: controllerEmail,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: controllerTelefono,
                      decoration: const InputDecoration(
                        labelText: 'Telefono',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      margin: const EdgeInsets.all(0.0),
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),

                      child: Row(
                        children: [
                          Expanded(child:                     DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Classe',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10),
                                ),
                              ),
                            ),
                            items: listClassi.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              // This is called when the user selects an item.
                              setState(() {
                                controllerClasse.text = value!;
                              });
                            },
                          ),
                          ),

                          const SizedBox(width: 10,),
                          Expanded(child:                     DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Materia',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10),
                                ),
                              ),
                            ),
                            items: listMaterie.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              // This is called when the user selects an item.
                              setState(() {
                                controllerMateria.text = value!;
                              });
                            },
                          ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: controllerTitolo,
                      decoration: const InputDecoration(
                        labelText: 'Titolo',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: controllerCondizione,
                      decoration: const InputDecoration(
                        labelText: 'Condizione',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(child:
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controllerPrezzo,
                          decoration: const InputDecoration(
                            labelText: 'Prezzo',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        ),
                        Expanded(child:
                        CheckboxListTile(
                          title: Text(messaggio,
                            style: TextStyle(
                              color: status! ? Colors.green : Colors.red,
                            ),
                            textAlign: TextAlign.center,) ,
                          activeColor: status! ? Colors.green : Colors.red,
                          value: timeDilation != 1.0,
                          onChanged: (bool? value) {
                            setState(() {
                              timeDilation = value! ? 1.5 : 1.0;
                              messaggio = value! ? 'Disponibile' : 'NON\nDisponibile';
                              status = value;
                            });
                          },
                        ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud(
    'Cloud',
    Icons.cloud_outlined,
  ),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

