import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:libreria_flutter/globalVariables.dart' as globals;
import 'package:libreria_flutter/services/database_utility.dart';
import 'package:settings_ui/settings_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tabIndex = 0;
  late dynamic modifiedValue;
  late TextEditingController _controllerNome;
  late TextEditingController _controllerCognome;
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerTelefono;
  late TextEditingController _controllerClasse;
  late TextEditingController _controllerMateria;
  late TextEditingController _controllerTitolo;
  late TextEditingController _controllerProprietario;
  late TextEditingController _controllerCondizioni;
  late TextEditingController _controllerPrezzo;
  late TextEditingController _controllerDisponibile;

  @override
  Widget build(BuildContext context) {
    globals.user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: globals.coloreSfondoScaffold,
      bottomNavigationBar: Container(
        color: globals.coloreSfondoScaffold,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: GNav(
          duration: const Duration(milliseconds: 300),
          backgroundColor: globals.coloreSfondoScaffold,
          color: globals.coloreScritteTitoloContainer,
          activeColor: globals.coloreScritteTitoloContainer,
          tabBackgroundColor: globals.coloreBordo,
          padding: const EdgeInsets.all(16),
          gap: 8,
          onTabChange: (index) {
            setState(() {
              tabIndex = index;
              globals.libri.length;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.book,
              text: "I tuo libri",
            ),
            GButton(
              icon: Icons.account_box,
              text: "Account",
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext contex, BoxConstraints size) {
          if (size.maxWidth < globals.dimMaxTelefono) {
            switch (tabIndex) {
              case 0:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: globals.libri.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        globals.coloreSfondoContainer,
                                    content: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                globals
                                                    .libri[index].bookData.nome,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.maxWidth * 0.01,
                                              height: size.maxHeight * 0.03,
                                            ),
                                            Center(
                                              child: Text(
                                                globals.libri[index].bookData
                                                    .cognome,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.maxWidth * 0.01,
                                              height: size.maxHeight * 0.03,
                                            ),
                                            Center(
                                              child: Text(
                                                globals.libri[index].bookData
                                                    .email,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.maxWidth * 0.01,
                                              height: size.maxHeight * 0.03,
                                            ),
                                            Center(
                                              child: Text(
                                                globals.libri[index].bookData
                                                    .telefono,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.maxWidth * 0.01,
                                              height: size.maxHeight * 0.03,
                                            ),
                                            Center(
                                              child: Text(
                                                globals.libri[index].bookData
                                                    .classe,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.maxWidth * 0.01,
                                              height: size.maxHeight * 0.03,
                                            ),
                                            Center(
                                              child: Text(
                                                globals.libri[index].bookData
                                                    .materia,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.maxWidth * 0.01,
                                              height: size.maxHeight * 0.03,
                                            ),
                                            Center(
                                              child: Text(
                                                globals.libri[index].bookData
                                                    .titolo,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.maxWidth * 0.01,
                                              height: size.maxHeight * 0.03,
                                            ),
                                            Center(
                                              child: Text(
                                                globals.libri[index].bookData
                                                    .proprietario,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.maxWidth * 0.01,
                                              height: size.maxHeight * 0.03,
                                            ),
                                            Center(
                                              child: Text(
                                                globals.libri[index].bookData
                                                    .condizioni,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.maxWidth * 0.01,
                                              height: size.maxHeight * 0.03,
                                            ),
                                            Center(
                                              child: Text(
                                                globals.libri[index].bookData
                                                    .prezzo
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.maxWidth * 0.01,
                                              height: size.maxHeight * 0.03,
                                            ),
                                            Center(
                                              child: Text(
                                                globals.libri[index].bookData
                                                    .disponibile
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.maxWidth * 0.01,
                                              height: size.maxHeight * 0.08,
                                            ),
                                            Center(
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: const Text('My Button'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            borderRadius:
                                BorderRadius.circular(0.06 * size.maxWidth),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: globals.coloreSfondoContainer,
                                border: Border.all(
                                    color: globals.coloreBordo,
                                    width: 0.006 * size.maxWidth),
                                borderRadius:
                                    BorderRadius.circular(0.06 * size.maxWidth),
                              ),
                              child: Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            size.maxWidth * 0.0035),
                                        child: Text(
                                          globals.libri[index].bookData.titolo,
                                          style: TextStyle(
                                              color: globals
                                                  .coloreScritteTitoloContainer,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: size.maxWidth * 0.04),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            size.maxWidth * 0.0035),
                                        child: Text(
                                          globals.libri[index].bookData.materia,
                                          style: TextStyle(
                                              color: globals
                                                  .coloreScritteMateriaContainer,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: size.maxWidth * 0.04),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            size.maxWidth * 0.0035),
                                        child: Text(
                                          globals.libri[index].bookData.classe,
                                          style: TextStyle(
                                              color: globals
                                                  .coloreScritteClasseContainer,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: size.maxWidth * 0.04),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            size.maxWidth * 0.0035),
                                        child: Text(
                                          globals.libri[index].bookData.cognome,
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              color: globals
                                                  .coloreScritteCognomeContainer,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );

              case 1:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: globals.proprietarioList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              modifiedValue=index;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        globals.coloreSfondoContainer,
                                    content: Stack(
                                      children: [
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Center(
                                                child: TextField(
                                                  controller: _controllerNome =
                                                      TextEditingController(
                                                          text: globals
                                                              .proprietarioList[
                                                                  index]
                                                              .bookData
                                                              .nome),
                                                  decoration: InputDecoration(
                                                      labelText: "Nome"),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.maxWidth * 0.01,
                                                height: size.maxHeight * 0.01,
                                              ),
                                              Center(
                                                child: TextField(
                                                  controller: _controllerCognome =
                                                      TextEditingController(
                                                          text: globals
                                                              .proprietarioList[
                                                                  index]
                                                              .bookData
                                                              .cognome),
                                                  decoration: InputDecoration(
                                                      labelText: "Cognome"),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.maxWidth * 0.01,
                                                height: size.maxHeight * 0.01,
                                              ),
                                              Center(
                                                child: TextField(
                                                  controller: _controllerEmail =
                                                      TextEditingController(
                                                          text: globals
                                                              .proprietarioList[
                                                                  index]
                                                              .bookData
                                                              .email),
                                                  decoration: InputDecoration(
                                                      labelText: "Email"),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.maxWidth * 0.01,
                                                height: size.maxHeight * 0.01,
                                              ),
                                              Center(
                                                child: TextField(
                                                  controller: _controllerTelefono =
                                                      TextEditingController(
                                                          text: globals
                                                              .proprietarioList[
                                                                  index]
                                                              .bookData
                                                              .telefono),
                                                  decoration: InputDecoration(
                                                      labelText: "Telefono"),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.maxWidth * 0.01,
                                                height: size.maxHeight * 0.01,
                                              ),
                                              Center(
                                                child: TextField(
                                                  controller: _controllerClasse =
                                                      TextEditingController(
                                                          text: globals
                                                              .proprietarioList[
                                                                  index]
                                                              .bookData
                                                              .classe),
                                                  decoration: InputDecoration(
                                                      labelText: "Classe"),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.maxWidth * 0.01,
                                                height: size.maxHeight * 0.01,
                                              ),
                                              Center(
                                                child: TextField(
                                                  controller: _controllerMateria =
                                                      TextEditingController(
                                                          text: globals
                                                              .proprietarioList[
                                                                  index]
                                                              .bookData
                                                              .materia),
                                                  decoration: InputDecoration(
                                                      labelText: "Materia"),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.maxWidth * 0.01,
                                                height: size.maxHeight * 0.01,
                                              ),
                                              Center(
                                                child: TextField(
                                                  controller: _controllerTitolo =
                                                      TextEditingController(
                                                          text: globals
                                                              .proprietarioList[
                                                                  index]
                                                              .bookData
                                                              .titolo),
                                                  decoration: InputDecoration(
                                                      labelText: "Titolo"),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.maxWidth * 0.01,
                                                height: size.maxHeight * 0.01,
                                              ),
                                              Center(
                                                child: TextField(
                                                  controller:
                                                      _controllerCondizioni =
                                                          TextEditingController(
                                                              text: globals
                                                                  .proprietarioList[
                                                                      index]
                                                                  .bookData
                                                                  .condizioni),
                                                  decoration: InputDecoration(
                                                      labelText: "Condizioni"),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.maxWidth * 0.01,
                                                height: size.maxHeight * 0.01,
                                              ),
                                              Center(
                                                child: TextField(
                                                  controller: _controllerPrezzo =
                                                      TextEditingController(
                                                          text: globals
                                                              .proprietarioList[
                                                                  index]
                                                              .bookData
                                                              .prezzo
                                                              .toString()),
                                                  decoration: InputDecoration(
                                                      labelText: "Prezzo"),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.maxWidth * 0.01,
                                                height: size.maxHeight * 0.01,
                                              ),
                                              Center(
                                                child: TextField(
                                                  controller:
                                                      _controllerDisponibile =
                                                          TextEditingController(
                                                              text: globals
                                                                  .proprietarioList[
                                                                      index]
                                                                  .bookData
                                                                  .disponibile
                                                                  .toString()),
                                                  decoration: InputDecoration(
                                                      labelText: "Disponibile"),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.maxWidth * 0.01,
                                                height: size.maxHeight * 0.06,
                                              ),
                                              Center(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    uploadChanges(modifiedValue,_controllerNome.text,_controllerCognome.text,_controllerEmail.text,_controllerTelefono.text,_controllerClasse.text,_controllerMateria.text,_controllerTitolo.text,_controllerProprietario.text,_controllerCondizioni.text,_controllerPrezzo.text as double,_controllerDisponibile.text as bool);
                                                  },
                                                  child:
                                                      const Text('My Button'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            borderRadius:
                                BorderRadius.circular(0.06 * size.maxWidth),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: globals.coloreSfondoContainer,
                                border: Border.all(
                                    color: globals.coloreBordo,
                                    width: 0.006 * size.maxWidth),
                                borderRadius:
                                    BorderRadius.circular(0.06 * size.maxWidth),
                              ),
                              child: Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            size.maxWidth * 0.0035),
                                        child: Text(
                                          globals.proprietarioList[index]
                                              .bookData.titolo,
                                          style: TextStyle(
                                              color: globals
                                                  .coloreScritteTitoloContainer,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: size.maxWidth * 0.04),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            size.maxWidth * 0.0035),
                                        child: Text(
                                          globals.proprietarioList[index]
                                              .bookData.materia,
                                          style: TextStyle(
                                              color: globals
                                                  .coloreScritteMateriaContainer,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: size.maxWidth * 0.04),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            size.maxWidth * 0.0035),
                                        child: Text(
                                          globals.proprietarioList[index]
                                              .bookData.classe,
                                          style: TextStyle(
                                              color: globals
                                                  .coloreScritteClasseContainer,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: size.maxWidth * 0.04),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            size.maxWidth * 0.0035),
                                        child: Text(
                                          globals.proprietarioList[index]
                                              .bookData.cognome,
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              color: globals
                                                  .coloreScritteCognomeContainer,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );

              case 2:
                return Container(
                  color: globals.coloreSfondoContainer,
                  child: SettingsList(
                    sections: [
                      SettingsSection(
                        title: const Text('Common'),
                        tiles: <SettingsTile>[
                          SettingsTile.navigation(
                            leading: const Icon(Icons.language),
                            title: const Text('Language'),
                            value: const Text('English'),
                          ),
                          SettingsTile.switchTile(
                            onToggle: (value) {},
                            initialValue: true,
                            leading: const Icon(Icons.format_paint),
                            title: const Text('Enable custom theme'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );

              default:
                return const Text("default");
            }
          } else {
            return const Text("pc");
          }
        },
      ),
    );
  }
}
