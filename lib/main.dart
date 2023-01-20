import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '....',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Der Einstandspreis Rechner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Benutzereingaben
  double? menge, listenPreis, zahl, rabattInProzent, skontoInProzent, transportKosten;

  // Fertige Berechnungen
  double? einkaufsPreis, zielEinkaufsPreis, barEinkaufsPreis, einstandsPreis;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              EingabeReihe(
                label: 'Menge',
                hintText: 'Geben Sie bitte die Menge ein',
                onChanged: (value) {
                  menge = double.tryParse(value);
                  print('Wet Menge ist $menge');
                },
              ),
              EingabeReihe(
                  label: 'Listenpreis',
                  hintText: 'geben Sie bitte den Listenpreis ein',
                  onChanged: (value) {
                    listenPreis = double.tryParse(value);
                    print('Wet Listenpreis ist $listenPreis €');
                  }),
              EingabeReihe(
                label: 'Rabatt',
                hintText: 'Geben Sie bitte den Rabatt ein',
                onChanged: (value) {
                  rabattInProzent = double.tryParse(value);
                  print('Wet Rabatt ist $rabattInProzent %');
                },
              ),
              EingabeReihe(
                label: 'Skonto',
                hintText: 'Geben Sie bitte das Skonto ein',
                onChanged: (value) {
                  skontoInProzent = double.tryParse(value);
                  print('Wet Skonto ist $skontoInProzent %');
                },
              ),
              EingabeReihe(
                label: 'Transportkosten',
                hintText: 'Geben Sie bitte die Transportkosten ein',
                onChanged: (value) {
                  transportKosten = double.tryParse(value);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0, bottom: 14.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (menge != null &&
                        listenPreis != null &&
                        rabattInProzent != null &&
                        skontoInProzent != null &&
                        transportKosten != null) {
                      setState(() {
                        einkaufsPreis = menge! * listenPreis!;
                        final rabatt = einkaufsPreis! * rabattInProzent! / 100;
                        zielEinkaufsPreis = einkaufsPreis! - rabatt;
                        final skonto = zielEinkaufsPreis! * skontoInProzent! / 100;
                        barEinkaufsPreis = zielEinkaufsPreis! - skonto;
                        einstandsPreis = barEinkaufsPreis! + transportKosten!;
                      });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 5),
                    child: Text(
                      'Berechnen',
                      style: TextStyle(fontSize: 29),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (menge != null &&
                            listenPreis != null &&
                            rabattInProzent != null &&
                            skontoInProzent != null &&
                            transportKosten != null) {
                          setState(() {
                            einkaufsPreis = 0;
                            zielEinkaufsPreis = 0;
                            barEinkaufsPreis = 0;
                            einstandsPreis = 0;
                          });
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 5),
                        child: Text(
                          'Neustarten',
                          style: TextStyle(fontSize: 29),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (einkaufsPreis != null)
                AusgabeReihe(
                  label2: 'Einkaufspreis',
                  label3: '$einkaufsPreis',
                  onChanged2: (value) {
                    double.tryParse(value);
                  },
                ),
              if (zielEinkaufsPreis != null)
                AusgabeReihe(
                  label2: 'Zieleinkaufspreis',
                  label3: '$zielEinkaufsPreis',
                  onChanged2: (value) {
                    double.tryParse(value);
                  },
                ),
              if (barEinkaufsPreis != null)
                AusgabeReihe(
                  label2: 'Bareinkaufspreis',
                  label3: '$barEinkaufsPreis',
                  onChanged2: (value) {
                    double.tryParse(value);
                  },
                ),
              if (einstandsPreis != null)
                AusgabeReihe(
                  label2: 'Einstandspreis',
                  label3: '$einstandsPreis',
                  onChanged2: (value) {
                    double.tryParse(value);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class AusgabeReihe extends StatelessWidget {
  final String label2;
  final String label3;
  final void Function(String value)? onChanged2;

  const AusgabeReihe({required this.label2, required this.label3, this.onChanged2, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            border: Border.all(width: 4),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[50],
              border: Border.all(
                width: 4,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$label3 €',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EingabeReihe extends StatelessWidget {
  final String label;
  final String hintText;
  final void Function(String value)? onChanged;

  const EingabeReihe({required this.label, required this.hintText, this.onChanged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OliversLabelWidget(label: label),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[50],
              border: Border.all(
                width: 4,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(-2),
                  isDense: true,
                ),
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OliversLabelWidget extends StatelessWidget {
  final String label;
  const OliversLabelWidget({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          border: Border.all(
            width: 4,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 35,
            ),
          ),
        ),
      ),
    );
  }
}
