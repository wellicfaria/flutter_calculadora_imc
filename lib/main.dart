import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _info_calc = "Informe seus dados!";

  void _botaoRefesh() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _info_calc = "Informe seus dados!";
    });
  }

  void _calc() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _info_calc = "Abaixo do Peso. (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _info_calc = "Peso Ideal. (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _info_calc =
            "Levemente a cima do Peso. (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _info_calc = "Obesidade Grau II. (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _info_calc = "Obesidade Grau II. (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40.0) {
        _info_calc = "Obesidade Grau III. (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _botaoRefesh();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Icon(Icons.accessibility, size: 120, color: Colors.green),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Peso (KG)",
                          labelStyle: TextStyle(color: Colors.green)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25),
                      controller: pesoController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira seu peso!";
                        }
                      }),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: alturaController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira seu Altura!";
                        }
                      }
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20, top: 20),
                    child: Container(
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            if(_formkey.currentState.validate()){
                              _calc();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          color: Colors.green,
                        )),
                  ),
                  Text("$_info_calc",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25))
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
            )));
  }
}
