import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/models/asteroides_model.dart';
import 'package:flutter_application_1/src/models/dia_model.dart';

//hechas por mi
import 'package:flutter_application_1/src/providers/nasa_providers.dart';
import 'package:flutter_application_1/src/widgets/background.dart';

class HomePage extends StatelessWidget {
  final imagen = new NasaProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Estrellas esta noche"),
      // ),
      body: Stack(
        children: [
          Background(),
          ListView(children: [
            texto('Asteroids Database', 40),
            SizedBox(height: 15.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: _imagenDia(),
            ),
            SizedBox(height: 20),
            texto('Near Earth Objects', 30),
            Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: _asteroidesCerca()),
            SizedBox(height: 40),
            // _asteroidesCerca(),
          ]),
        ],
      ),
    );
  }

  Widget texto(String texto, double tam) {
    return SafeArea(
      bottom: false,
      child: Container(
        child: Column(
          children: [
            Text(
              texto,
              style: TextStyle(
                color: Color.fromRGBO(224, 225, 221, 1),
                fontFamily: 'Space',
                fontSize: tam,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _imagenDia() {
    // imagen.getImagenDia();
    imagen.getAsteroides();

    return Container(
      decoration: decoration(20.0, Color.fromRGBO(224, 225, 221, 1)),
      child: FutureBuilder(
          //sirve para que construya despues de que cargue el api
          future: imagen.getImagenDia(), //mandamos los datos del api
          builder: (BuildContext context, AsyncSnapshot<Imagen> snapshot) {
            //el snapshot tiene la informacion de las imagenes de la nasa

            if (snapshot.hasData) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Column(children: [
                    FadeInImage(
                      placeholder: AssetImage('assets/loading.gif'),
                      fadeInDuration: Duration(milliseconds: 20),
                      image: snapshot.data.url == null
                          ? NetworkImage('https://i.stack.imgur.com/y9DpT.jpg')
                          : NetworkImage(
                              snapshot.data.url,
                              scale: 1.0,
                            ),
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        snapshot.data.title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ]));
            } else {
              return Container(
                  height: 400,
                  child: Center(child: CircularProgressIndicator()));
            }
          }),
    );

    // Container(

    // //     child: FadeInImage(
    // //   height: 150,
    // //   placeholder: AssetImage('assets/loading.gif'),
    // //   fadeInDuration: Duration(microseconds: 20),
    // // //   image: NetworkImage('https://api.nasa.gov/planetary/apod'),
    // // )
    // );
  }

  Widget _asteroidesCerca() {
    int val = 0;
    String diametro, velocidad, distancia, nombre;
    bool peligro;

    return FutureBuilder(
      future: imagen.getAsteroides(),
      builder: (BuildContext context, AsyncSnapshot<Asteroides> snapshot) {
        if (snapshot.hasData) {
          print('si');
          return ListView.separated(
            // scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemCount: snapshot.data.elementCount,
            separatorBuilder: (BuildContext context, int entero) => Divider(),
            // itemCount: 10,
            itemBuilder: (BuildContext context, int entero) {
              for (var x in snapshot.data.nearEarthObjects.values.first) {
                if (val == entero) {
                  diametro = x.estimatedDiameter.meters.estimatedDiameterMax
                      .toString();
                  nombre = x.name;
                  // print(nombre);
                  peligro = x.isPotentiallyHazardousAsteroid;
                  // velocidad=;
                  for (var y in x.closeApproachData) {
                    velocidad = y.relativeVelocity.kilometersPerSecond;
                    distancia = y.missDistance.kilometers;
                  }

                  val = 0;
                  break;
                }
                val++;
              }
              return Stack(
                children: [
                  Container(
                      decoration: decoration(
                        10.0,
                        Color.fromRGBO(224, 225, 221, 1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                            height: 150.0,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 15.0),
                                Container(
                                  decoration: decoration(
                                    20.0,
                                    Color.fromRGBO(0, 40, 85, 1),
                                  ),
                                  // padding: EdgeInsets.only(left: 20.0),
                                  child: Image.asset(
                                    'assets/asteroide_2.png',
                                    width: 65,
                                    height: 65,
                                  ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Title(title: nombre),

                                    Text(
                                      nombre,
                                      style: TextStyle(
                                          fontFamily: 'Space',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Colors.black),
                                    ),

                                    SizedBox(height: 2.0),
                                    cartas('Diam: $diametro m'),

                                    SizedBox(
                                      height: 2.0,
                                    ),

                                    cartas('Vel: $velocidad Km/s'),
                                    SizedBox(
                                      height: 2.0,
                                    ),
                                    cartas('Dis: $distancia km'),
                                  ],
                                ),
                              ],
                            )),
                        // SizedBox(height: 20)
                      )),
                  peligro == true
                      ? Positioned(right: -50, top: -65, child: alerta())
                      : SizedBox(),
                ],
              );
            },
          );
        } else {
          return Container(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  BoxDecoration decoration(double radio, Color colores) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radio),
        color: colores,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 2.0),
          )
        ]);
  }

  Widget alerta() {
    return Transform.rotate(
      angle: -pi / 4,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
    );
  }

  Text cartas(String texto) {
    return Text(
      texto,
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'Space',
        color: Colors.black,
      ),
    );
  }
}
