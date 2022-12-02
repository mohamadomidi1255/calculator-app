import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget calcbotton(String btntxt, Color btncolor, Color txtcolor) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 90,
        height: 80,
        decoration: BoxDecoration(
            color: btncolor, borderRadius: BorderRadius.circular(40)),
        child: InkWell(
          onTap: () {
            calculation(btntxt);
          },
          child: Center(
            child: Text(
              btntxt,
              style: TextStyle(
                fontSize: 30,
                color: txtcolor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', ''), // farsi, no country code
      ],
      home: Scaffold(
          body: Column(children: [
        Container(height: 220),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text.toString(),
                style: const TextStyle(fontSize: 40),
              ),
            )
          ],
        ),
        Divider(
          color: Color.fromARGB(97, 0, 0, 0),
        ),
        Row(
          children: <Widget>[
            calcbotton("÷", Color.fromARGB(255, 236, 236, 236),
                Color.fromARGB(255, 174, 215, 11)),
            calcbotton("%", Color.fromARGB(255, 236, 236, 236),
                Color.fromARGB(255, 174, 215, 11)),
            calcbotton("20", Color.fromARGB(255, 236, 236, 236),
                Color.fromARGB(255, 174, 215, 11)),
            calcbotton("C", Color.fromARGB(255, 236, 236, 236), Colors.red),
          ],
        ),
        Row(
          children: <Widget>[
            calcbotton("x", Color.fromARGB(255, 236, 236, 236),
                Color.fromARGB(255, 174, 215, 11)),
            calcbotton("9", Color.fromARGB(255, 236, 236, 236), Colors.black),
            calcbotton("8", Color.fromARGB(255, 236, 236, 236), Colors.black),
            calcbotton("7", Color.fromARGB(255, 236, 236, 236), Colors.black),
          ],
        ),
        Row(
          children: <Widget>[
            calcbotton("-", Color.fromARGB(255, 236, 236, 236),
                Color.fromARGB(255, 174, 215, 11)),
            calcbotton("6", Color.fromARGB(255, 236, 236, 236), Colors.black),
            calcbotton("5", Color.fromARGB(255, 236, 236, 236), Colors.black),
            calcbotton("4", Color.fromARGB(255, 236, 236, 236), Colors.black),
          ],
        ),
        Row(
          children: <Widget>[
            calcbotton("+", Color.fromARGB(255, 236, 236, 236),
                Color.fromARGB(255, 174, 215, 11)),
            calcbotton("3", Color.fromARGB(255, 236, 236, 236), Colors.black),
            calcbotton("2", Color.fromARGB(255, 236, 236, 236), Colors.black),
            calcbotton("1", Color.fromARGB(255, 236, 236, 236), Colors.black),
          ],
        ),
        Row(
          children: <Widget>[
            calcbotton("=", Color.fromARGB(255, 174, 215, 11), Colors.black),
            calcbotton(".", Color.fromARGB(255, 236, 236, 236), Colors.black),
            calcbotton("0", Color.fromARGB(255, 236, 236, 236), Colors.black),
            calcbotton("00", Color.fromARGB(255, 236, 236, 236), Colors.black),
          ],
        ),
      ])),
    );
  }

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'C') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '÷') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '÷' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }
      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '÷') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
