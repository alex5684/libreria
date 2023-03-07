import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:libreria_flutter/globalVariables.dart' as globals;
import 'package:libreria_flutter/services/database_utility.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    //getData();
    super.initState();
  }

  getData() async {
    await setListaLibri();
  }

  @override
  Widget build(BuildContext context) {
    globals.user = FirebaseAuth.instance.currentUser!;
    setProprietarioList("pippo");
    return Scaffold(
      backgroundColor: globals.coloreSfondoScaffold,
      bottomNavigationBar: Container(
        color: globals.coloreSfondoScaffold,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: GNav(
          backgroundColor: globals.coloreSfondoScaffold,
          color: globals.coloreScritteTitoloContainer,
          activeColor: globals.coloreScritteTitoloContainer,
          tabBackgroundColor: globals.coloreBordo,
          padding: EdgeInsets.all(16),
          gap: 8,
          onTabChange: (index) {},
          tabs: [
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: globals.libri.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(size.maxWidth * 0.0035),
                                child: Text(
                                  globals.libri[index].bookData.titolo,
                                  style: TextStyle(
                                      color:
                                          globals.coloreScritteTitoloContainer,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: size.maxWidth * 0.04),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(size.maxWidth * 0.0035),
                                child: Text(
                                  globals.libri[index].bookData.materia,
                                  style: TextStyle(
                                      color:
                                          globals.coloreScritteMateriaContainer,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: size.maxWidth * 0.04),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(size.maxWidth * 0.0035),
                                child: Text(
                                  globals.libri[index].bookData.classe,
                                  style: TextStyle(
                                      color:
                                          globals.coloreScritteClasseContainer,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: size.maxWidth * 0.04),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(size.maxWidth * 0.0035),
                                child: Text(
                                  globals.libri[index].bookData.cognome,
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      color:
                                          globals.coloreScritteCognomeContainer,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: globals.coloreSfondoContainer,
                          border: Border.all(
                              color: globals.coloreBordo,
                              width: 0.006 * size.maxWidth),
                          borderRadius:
                              BorderRadius.circular(0.06 * size.maxWidth),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Text("pc");
          }
        },
      ),
    );
  }
}
