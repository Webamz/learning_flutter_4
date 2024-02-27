import 'package:flutter/material.dart';
import 'package:learning_flutter_4/pages/button_values.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String num1 = "";
  String operand = "";
  String num2 = "";

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            //output
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "$num1$operand$num2".isEmpty ? "0" : "$num1$operand$num2",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),

            //buttons
            Wrap(
              children: Btn.buttonValues
                  .map(
                    (value) => SizedBox(
                        width: screenSize.width / 4,
                        height: screenSize.width / 5,
                        child: buildButton(value)),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white24),
            borderRadius: BorderRadius.circular(100)),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(
              child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )),
        ),
      ),
    );
  }

  // #######################
  // giving color to different buttons
  Color getBtnColor(value) {
    return [Btn.del, Btn.clr].contains(value)
        ? Colors.redAccent
        : [
            Btn.per,
            Btn.multiply,
            Btn.add,
            Btn.subtract,
            Btn.divide,
            Btn.calculate
          ].contains(value)
            ? Colors.blueGrey
            : Colors.white70;
  }

  // #####################
  // handles button taps
  void onBtnTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
      return;
    }

    if (value == Btn.per) {
      convertToPercentage();
      return;
    }

    if (value == Btn.calculate) {
      calculate();
      return;
    }

    appendValue(value);
  }

  // #####################
  // appends values
  void appendValue(String value) {
    // check if is operand and not "."
    if (value != Btn.dot && int.tryParse(value) == null) {
      // operand pressed
      if (operand.isNotEmpty && num2.isNotEmpty) {
        calculate();
      }
      operand = value;
    }
    // assign value to num1 variable
    else if (num1.isEmpty || operand.isEmpty) {
      //check if value  is "." , 1.2
      if (value == Btn.dot && num1.contains(Btn.dot)) return;
      if (value == Btn.dot && (num1.isEmpty || num1 == Btn.n0)) {
        value = "0.";
      }
      num1 += value;
    }
    //assign value to num2 variable
    else if (num2.isEmpty || operand.isNotEmpty) {
      if (value == Btn.dot && num2.contains(Btn.dot)) return;
      if (value == Btn.dot && (num2.isEmpty || num2 == Btn.n0)) {
        value = "0.";
      }
      num2 += value;
    }

    setState(() {});
  }

  // #########
  // deletes one character from behind
  void delete() {
    if (num2.isNotEmpty) {
      num2 = num2.substring(0, num2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (num1.isNotEmpty) {
      num1 = num1.substring(0, num1.length - 1);
    }

    setState(() {});
  }

  // ############
  // clears all output
  void clearAll() {
    setState(() {
      num1 = "";
      operand = "";
      num2 = "";
    });
  }

  // ################
  // converts to percentage
  void convertToPercentage() {
    if (num1.isNotEmpty && operand.isNotEmpty && num2.isNotEmpty) {
      calculate();
    }

    if (operand.isNotEmpty) {
      return;
    }

    final number = double.parse(num1);
    setState(() {
      num1 = "${(number / 100)}";
      operand = "";
      num2 = "";
    });
  }

  // ###############
  // performs the calculations
  void calculate() {
    if (num1.isEmpty) return;
    if (operand.isEmpty) return;
    if (num2.isEmpty) return;

    double n1 = double.parse(num1);
    double n2 = double.parse(num2);

    var result = 0.0;

    switch (operand) {
      case Btn.add:
        result = n1 + n2;
        break;
      case Btn.subtract:
        result = n1 - n2;
        break;
      case Btn.multiply:
        result = n1 * n2;
        break;
      case Btn.divide:
        result = n1 / n2;
        break;
      default:
    }

    setState(() {
      num1 = "$result";

      if (num1.endsWith(".0")) {
        num1 = num1.substring(0, num1.length - 2);
      } else if (num1.length > 13) {
        num1 = num1.substring(0, 14);
      }

      operand = "";
      num2 = "";
    });
  }
}
