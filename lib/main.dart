import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Calculator',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: simpleCalculator(),
    );
  }
}

class simpleCalculator extends StatefulWidget{
  @override
  _simpleCalculatorState createState() => _simpleCalculatorState();
}

class _simpleCalculatorState extends State<simpleCalculator>{
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  buttonPressed(String btnText)
  {
    setState(() {
      if(btnText== "C")
        {
          equation="0";
          result="0";
          equationFontSize = 38.0;
          resultFontSize = 48.0;
        }
      else if(btnText=="⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation= equation.substring(0,equation.length-1);
        if(equation=="")
          {
            equation="0";
          }
      }
      else if(btnText=="="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e)
      {
        result = "Error";
      }
      }
      else
        {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          if(equation=="0")
            {
              equation=btnText;
            }
          equation = equation + btnText;
        }
    });
  }

  Widget buttonBuild(String btnText , double btnHeight , Color btnColor)
  {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * btnHeight,
      color: btnColor,
      child: MaterialButton(
        onPressed: () => buttonPressed(btnText),
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid
          ),
        ) ,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            btnText,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
          ),
        ),
      ),

    );
  }



  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget> [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation,style: TextStyle(fontSize: equationFontSize),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(result,style: TextStyle(fontSize: resultFontSize),),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buttonBuild("C", 1.0, Colors.orangeAccent),
                        buttonBuild("⌫", 1.0, Colors.teal),
                        buttonBuild("÷", 1.0, Colors.teal),

                      ]

                    ),
                    TableRow(
                        children: [
                          buttonBuild("7", 1.0, Colors.black54),
                          buttonBuild("8", 1.0, Colors.black54),
                          buttonBuild("9", 1.0, Colors.black54),

                        ]

                    ),
                    TableRow(
                        children: [
                          buttonBuild("4", 1.0, Colors.black54),
                          buttonBuild("5", 1.0, Colors.black54),
                          buttonBuild("6", 1.0, Colors.black54),

                        ]

                    ),
                    TableRow(
                        children: [
                          buttonBuild("1", 1.0, Colors.black54),
                          buttonBuild("2", 1.0, Colors.black54),
                          buttonBuild("3", 1.0, Colors.black54),

                        ]

                    ),
                    TableRow(
                        children: [
                          buttonBuild(".", 1.0, Colors.black54),
                          buttonBuild("0", 1.0, Colors.black54),
                          buttonBuild("00", 1.0, Colors.black54),

                        ]

                    ),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buttonBuild('×', 1.0, Colors.teal),
                      ],
                    ),
                    TableRow(
                      children: [
                        buttonBuild('-', 1.0, Colors.teal),
                      ],
                    ),
                    TableRow(
                      children: [
                        buttonBuild('+', 1.0, Colors.teal),
                      ],
                    ),
                    TableRow(
                      children: [
                        buttonBuild('=', 2.0, Colors.orangeAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



