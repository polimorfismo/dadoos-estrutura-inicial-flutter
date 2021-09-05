
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(JogaDados());

class JogaDados extends StatefulWidget {
  @override
  _JogaDadosState createState() => _JogaDadosState();
}

class _JogaDadosState extends State<JogaDados> {
  var numDadoEsq = 0;
  var numDadoDrt = 0;

  var ptsDadoEsq = 0;
  var ptsDadoDrt = 0;
  var ladoQuemComecou;
  var msgaviso = '';
  var ladoAB = '';

  var rng = new Random();

//ARRUMAR O BUG DE NAO MOSTRA O DADO

  //Lado 0 = esquerda
  //Lado 1 = Direita
  void jogaDado(int lado) {
    if (ladoQuemComecou == null) {
      ladoQuemComecou = lado;

      setState(() {
        ladoQuemComecou == 0
            ? numDadoEsq = rng.nextInt(6) + 1
            : numDadoDrt = rng.nextInt(6) + 1;
      });
    }

    if (lado == ladoQuemComecou) {
      lado == 0 ? ladoAB = 'B' : ladoAB = 'A';
      msgaviso = 'Agora é a vez do jogador $ladoAB';
    } else {
      lado == 0
          ? numDadoEsq = rng.nextInt(5) + 1
          : numDadoDrt = rng.nextInt(5) + 1;

      setState(() {
        //EM CASO DE EMPATE DA UM PONTO PARA CADA
        if (numDadoDrt == numDadoEsq) {
          ptsDadoDrt += 1;
          ptsDadoEsq += 1;
          ladoQuemComecou = null;

          msgaviso = 'Empare, 1pt para cada!';
        }

        if (numDadoDrt > numDadoEsq) {
          ptsDadoDrt += 1;
          ladoQuemComecou = null;
          msgaviso = 'O jogador B ganhou!';
        }

        if (numDadoEsq > numDadoDrt) {
          ptsDadoEsq += 1;
          msgaviso = 'O jogador A ganhou!';
          ladoQuemComecou = null;
        }
      });
    }
  }

  void reset() {
    //Lado 0 = esquerda
    //Lado 1 = Direita
    setState(() {
      ladoQuemComecou = null;

      numDadoEsq = 0;
      numDadoDrt = 0;
      ptsDadoEsq = 0;
      ptsDadoDrt = 0;
      msgaviso = 'Toque em um dos dados para começar!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          centerTitle: true,
          title: Text('Jogar Dados'),
          backgroundColor: Colors.black87,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
            reset();
          },
          label: const Text('resetar'),
          icon: const Icon(Icons.refresh),
          backgroundColor: Colors.black87,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                //width: 250,
                height: 50.0,
                child: Center(
                  child: Text(
                    'PONTOS',
                    style: TextStyle(color: Colors.black87, fontSize: 22),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    //Esquerda
                    child: TextButton(
                      child: Text(
                        '$ptsDadoEsq',
                        style: TextStyle(color: Colors.black87, fontSize: 70),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    //Direita
                    child: TextButton(
                      child: Text(
                        '$ptsDadoDrt',
                        style: TextStyle(color: Colors.black87, fontSize: 70),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),

              SizedBox(
                //width: 250,
                height: 50.0,
                child: Divider(
                  color: Colors.black45,
                  thickness: 2,
                  indent: 50,
                  endIndent: 50,
                ),
              ),
              SizedBox(
                //width: 250,
                height: 40.0,
                child: Center(
                  child: Text(
                    '$msgaviso',
                    style: TextStyle(color: Colors.redAccent, fontSize: 22),
                  ),
                ),
              ),


              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Image.asset('imagens/dado$numDadoEsq.png'),
                      onPressed: () {
                        jogaDado(0);
                        print('Btn Esquerda');
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: Image.asset('imagens/dado$numDadoDrt.png'),
                      onPressed: () {
                        jogaDado(1);
                        print('Btn Direita');
                      },
                    ),
                  ),
                ],
              ),

              //LADO A B

              
              Row(
                children: [
                  Expanded(
                    //Esquerda
                    child: TextButton(
                      child: Text(
                        'JOGADOR A',
                        style: TextStyle(color: Colors.black87, fontSize: 20),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    //Direita
                    child: TextButton(
                      child: Text(
                        'JOGADOR B',
                        style: TextStyle(color: Colors.black87, fontSize: 20),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),

              //LADO A B
            ],
          ),
        ),
      ),
    );
  }
}
