import 'dart:html';
import 'dart:js_util';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      //MONTA O AMBIENTE (ELEMENTOS GRAFICOS, ICONES, CORES, ETC)
      home: Home(), //É A ROTA DE ENTRADA DA APLICAÇÃO (START HERE)
      debugShowCheckedModeBanner: false, //REMOVE O BANNER DE DEBUG DO APP
    ),
  );
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

///ESTA CLASSE TERA TODO O CONTEUDO DA APLICAÇÃO, INCLUINDO A LOGICA
///E OS CONTROLES(CAMPOS DE ENTRADA) E BOTÕES DE AÇÃO(CALCULAR E O REST)
class _HomeState extends State<Home> {
  //AQUI VAMOS DEFINIR NOSSO CONTROLES DE ENTRADA(DIGITAÇÃO DE VALORES)
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();

  //Criação de um controle para o nosso formulario (form)
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //variavel para armazenar o resultado "Texto a ser mostrado"
  String _resultado = '';

  final fieldText = TextEditingController();

  //Definição dos métodos do App

  //Método para calcular o combustivel ideal
  void _calculaCombustivelIdeal() {
    setState(() {
      //criando e convertendo os valores digitados
      double varAlcool =
          double.parse(alcoolController.text.replaceAll(',', '.'));
      double varGasolina =
          double.parse(gasolinaController.text.replaceAll(',', '.'));

      //Medindo a proporção dos combustiveis
      double proporcao = varAlcool / varGasolina;

      //Atualizar a variavel de resposta
      _resultado =
          (proporcao < 0.7 ? 'Abasteça com Álcool' : 'Abasteça com Gasolina');
    });
  }

  void _reset() {
    alcoolController.clear(); //alcoolController.text = '';
    gasolinaController.clear(); //gasolinaController.text = '';

    //Atualizar o estado das demais variaveis globais
    setState(() {
      _resultado = '';
      _formKey = GlobalKey<FormState>();
    });
  }

  //Montagem do ambiente gráfico do App

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Álcool ou Gasolina',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                //vamos chamar um metodo que limpa as entradas e as variaveis
                _reset();
              },
              icon: Icon(Icons.refresh))
        ],
      ),

      //Criação do corpo de entrada de dados
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.local_gas_station,
                size: 80,
                color: Colors.black,
              ),

              //Montando os campos de edição
              TextFormField(
                controller: alcoolController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black, fontSize: 20.0),

                //Validação de entrada
                validator: (value) =>
                    value!.isEmpty ? 'Informe o valor do álcool' : null,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.local_gas_station,
                    color: Colors.black45,
                  ), //ICONE AO LADO DO LABEL
                  labelText: 'Valor do álcool',
                  labelStyle: TextStyle(color: Colors.black45),
                  filled: true,

                  border: OutlineInputBorder(
                    //BORDA NORMAL
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),

                  focusedBorder: OutlineInputBorder(
                    //BORDA DEPOIS QUE CLICA
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),

              Container(
                  //SEPARAR OS INPUTS
                  padding: EdgeInsets.only(top: 10)),

              TextFormField(
                controller: gasolinaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o valor da Gasolina' : null,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.local_gas_station,
                    color: Colors.black45,
                  ), //ICONE AO LADO DO LABEL
                  labelText: 'Valor da Gasolina',
                  labelStyle: TextStyle(color: Colors.black45),
                  filled: true,

                  border: OutlineInputBorder(
                    //BORDA NORMAL
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),

                  focusedBorder: OutlineInputBorder(
                    //BORDA DEPOIS QUE CLICA
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),

              //Criar o botão para calcular
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: Container(
                  //O mesmo q uma <div>
                  height: 50,
                  child: RawMaterialButton(
                    onPressed: () {
                      //Verificações dos valores (se estão preenchidos)
                      if (_formKey.currentState!.validate())
                        _calculaCombustivelIdeal();

                      alcoolController
                          .clear(); //ZERA OS VALORES DO INPUT DEPOIS DE CLICAR EM CALCULAR
                      gasolinaController
                          .clear(); //ZERA OS VALORES DO INPUT DEPOIS DE CLICAR EM CALCULAR
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    fillColor: Colors.black,
                  ),
                ),
              ),
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_resultado == 'Abasteça com Gasolina') ...[
                    const Icon(
                      Icons.local_gas_station,
                      size: 50,
                      color: Colors.black,
                    )
                  ] else if(_resultado == 'Abasteça com Álcool')...[
                    const Icon(
                      Icons.local_gas_station_outlined,
                      size: 50,
                      color: Colors.black,
                    )
                  ]
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
