import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/asteroides_model.dart';
import 'package:flutter_application_1/src/widgets/background.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_application_1/src/models/asteroides_model.dart';

class AsteroidPage extends StatefulWidget {
  final Asteroides asteroi;
  final int enteroname;
  final String velocidad, dist, diametromax, diametromin;

  AsteroidPage(this.asteroi, this.enteroname, this.velocidad, this.dist,
      this.diametromax, this.diametromin);

  @override
  _AsteroidPageState createState() => _AsteroidPageState();
}

class _AsteroidPageState extends State<AsteroidPage> {
  String initv = 'Km/s';
  String initd = 'Km';
  String initdiam = 'm';
  String subtitulodiamax = '';
  String subtitulodiamin = '';
  String subtitulov = '';
  String subtitulod = '';
  @override
  void initState() {
    subtitulov = widget.velocidad;
    subtitulod = widget.dist;
    subtitulodiamax = widget.diametromax;
    subtitulodiamin = widget.diametromin;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String nombre;
    Map vel = new Map();
    Map diam = new Map();
    Map dist = new Map();
    int val = 0;
    for (var x in widget.asteroi.nearEarthObjects.values.first) {
      if (val == widget.enteroname) {
        diam['Km'] = [
          x.estimatedDiameter.kilometers.estimatedDiameterMax,
          x.estimatedDiameter.kilometers.estimatedDiameterMin
        ];
        diam['m'] = [
          x.estimatedDiameter.meters.estimatedDiameterMax,
          x.estimatedDiameter.meters.estimatedDiameterMin
        ];
        diam['milla'] = [
          x.estimatedDiameter.miles.estimatedDiameterMax,
          x.estimatedDiameter.miles.estimatedDiameterMin
        ];
        diam['Ft'] = [
          x.estimatedDiameter.feet.estimatedDiameterMax,
          x.estimatedDiameter.feet.estimatedDiameterMin
        ];
        nombre = x.name;
        for (var y in x.closeApproachData) {
          vel['Km/h'] = y.relativeVelocity.kilometersPerHour;
          vel['Km/s'] = y.relativeVelocity.kilometersPerSecond;
          vel['mph'] = y.relativeVelocity.milesPerHour;
          dist['Astr'] = y.missDistance.astronomical;
          dist['Km'] = y.missDistance.kilometers;
          dist['Lunar'] = y.missDistance.lunar;
          dist['milla'] = y.missDistance.miles;
        }

        // print(nombre);
        val = 0;
        break;
      }
      val++;
    }

    final _tampant = MediaQuery.of(context)
        .size; //el mediaquery me indica el tamaño de la pantalla
    return Scaffold(
      body: Stack(
        children: [
          background(),
          Column(children: [
            appbar(_tampant, nombre),
            lista(vel, dist, diam),
          ]),
        ],
      ),
    );
  }

  Widget appbar(Size tama, String nombre) {
    return SafeArea(
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                child: Image.asset(
                  'assets/asteroide_2.png',
                  width: tama.width * .3,
                  // height: tama.height * .2,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(nombre,
                  style: TextStyle(
                      fontFamily: 'Space',
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget lista(Map vel, dist, diam) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListTileTheme(
          contentPadding: EdgeInsets.all(10),
          iconColor: Colors.green,
          textColor: Colors.white,
          dense: false,
          style: ListTileStyle.list,
          child: ListView(
            shrinkWrap: true,
            primary: true,
            scrollDirection: Axis.vertical,
            // itemCount: 4,
            // separatorBuilder: (BuildContext context, int entero) => Divider(),
            // itemBuilder: (BuildContext context, int valor) {
            children: [
              velocidad(vel),
              SizedBox(height: 10),
              distancia(dist),
              SizedBox(height: 10),
              diametro(diam),
              SizedBox(height: 10),
              informacion(),
            ],
          ),
        ),
      ),
    );
  }

  Widget distancia(Map dist) {
    return Container(
      // color: Color.fromRGBO(70, 97, 137, .7),
      child: ListTile(
        selected: false,
        leading: FaIcon(FontAwesomeIcons.route),
        title: Text("Distancia"),
        subtitle: Text(
          subtitulod,
        ),
        tileColor: Colors.black,
        trailing: DropdownButton<String>(
          value: initd,
          style: TextStyle(color: Colors.white),
          dropdownColor: Colors.black,
          items: valores(['Astr', 'Lunar', 'Km', 'milla']),
          onChanged: (opcion) {
            setState(() {
              initd = opcion;
              subtitulod = dist[opcion];
            });
          },
        ),
      ),
    );
  }

  Widget diametro(Map diam) {
    return Container(
      // color: Color.fromRGBO(70, 97, 137, .7),
      child: ListTile(
        leading: FaIcon(FontAwesomeIcons.circleNotch),

        // tileColor: Colors.black,
        title: Text("Diametro Estimado"),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Max: $subtitulodiamax'),
            Text('Min: $subtitulodiamin')
          ],
        ),
        trailing: DropdownButton<String>(
          value: initdiam,
          dropdownColor: Colors.black,
          items: valores(['Km', 'm', 'Ft', 'milla']),
          style: TextStyle(color: Colors.white),
          onChanged: (opcion) {
            setState(() {
              diam.forEach((k, v) {
                if (k == opcion) {
                  print(v);
                  subtitulodiamax = v[0].toString();
                  subtitulodiamin = v[1].toString();
                }
              });

              initdiam = opcion;
            });
          },
        ),
      ),
    );
  }

  Widget velocidad(Map vel) {
    return Container(
      // color: Color.fromRGBO(70, 97, 137, .7),
      child: ListTile(
        leading: FaIcon(FontAwesomeIcons.tachometerAlt),

        // tileColor: Colors.black,
        title: Text("Velocidad"),
        subtitle: Text(subtitulov),
        trailing: DropdownButton<String>(
          value: initv,
          dropdownColor: Colors.black,
          style: TextStyle(color: Colors.white),
          items: valores(['Km/h', 'Km/s', 'mph']),
          onChanged: (opcion) {
            setState(() {
              initv = opcion;
              subtitulov = vel[opcion];
            });
          },
        ),
      ),
    );
  }

  Widget informacion() {
    return Container(
      color: Color.fromRGBO(70, 97, 137, .7),
      child: ListTile(
        title: Text(
          "Mas informacion",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> valores(List<String> valor) {
    List<DropdownMenuItem<String>> lista = [];
    List<String> medidas = valor;
    medidas.forEach((poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });
    return lista;
  }

  Widget background() {
    return Stack(
      children: [
        Container(
            // decoration: decoration,
            color: Color.fromRGBO(20, 19, 21, 1)),
        Positioned(
          right: -450,
          bottom: -500,
          child: Container(
              width: 900,
              height: 900,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                gradient: gradiente(
                  Color.fromRGBO(249, 199, 132, 1),
                  Color.fromRGBO(252, 158, 79, 1),
                ),
              )),
        )
      ],
    );
  }
}
