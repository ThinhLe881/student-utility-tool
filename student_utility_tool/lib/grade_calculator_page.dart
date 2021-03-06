import 'package:flutter/material.dart';
import 'package:student_utility_tool/navigation_drawer.dart';

/// Controllers for the textfields within the grade calculator tab.
final List<List<TextEditingController>> textControllers = [];

/// Parameters used to calculate the final grade within the final grade calculator tab.
double currentGrade = 0;
double targetClassGrade = 0;
double finalExamWeight = 0;

/// Controllers for the textfields within final grade calculator tab.
final currentGradeController = TextEditingController();
final targetGradeController = TextEditingController();
final finalWeightController = TextEditingController();

// ignore: must_be_immutable
class GradeCalculatorPage extends StatelessWidget {
  GradeCalculatorPage({Key? key}) : super(key: key);
  double calculationResult = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.purple),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text("Grade Calculator"),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Grade",
                ),
                Tab(
                  text: "Final Grade",
                ),
                Tab(
                  text: "Description",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _gradeCalculatorTab(context),
              _finalGradeCalculatorTab(context),
              _descriptionTab(context),
            ],
          ),
          drawer: const NavigationDrawerWidget(),
        ),
      ),
    );
  }

  /// Grade Tab within the grade controller.
  _gradeCalculatorTab(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text("Name (Optional)", style: TextStyle(fontSize: 18)),
            Text("Grade (%)", style: TextStyle(fontSize: 18)),
            Text("Weight (%)", style: TextStyle(fontSize: 18))
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const Card(
              child: GradeCalculator(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                ),
                onPressed: () {
                  calculationResult = 0;
                  for (var controller in textControllers) {
                    if (controller[1].text != "" && controller[2].text != "") {
                      calculationResult += double.parse(controller[1].text) /
                          100 *
                          double.parse(controller[2].text);
                    }
                  }
                  _showAlertDialog(context);
                },
                child: const Text("Calculate")),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                ),
                onPressed: () {
                  for (var controller in textControllers) {
                    controller[0].clear();
                    controller[1].clear();
                    controller[2].clear();
                  }
                },
                child: const Text("Clear All"))
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  /// Fianl Grade tab within the grade calculator.
  _finalGradeCalculatorTab(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(20),
            child: const FinalGradeCalculator(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                  ),
                  onPressed: () {
                    currentGrade = double.parse(currentGradeController.text);
                    targetClassGrade = double.parse(targetGradeController.text);
                    finalExamWeight = double.parse(finalWeightController.text);

                    calculationResult = (targetClassGrade -
                            ((1 - (finalExamWeight / 100)) * currentGrade)) /
                        finalExamWeight;
                    calculationResult = calculationResult * 100;
                    _showAlertDialog(context);
                  },
                  child: const Text("Calculate")),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                  ),
                  onPressed: () {
                    currentGradeController.clear();
                    targetGradeController.clear();
                    finalWeightController.clear();
                  },
                  child: const Text("Clear All"))
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// Description tab within the grade calculator.
  _descriptionTab(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const Text(
          "Grade Calculator:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
          child: const Text(
            "The grade calculator will provide your overall grade based on assignments, midterms, and final exam.",
            style: TextStyle(color: Colors.black87, fontSize: 17.0),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Final Grade Calculator:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
          child: const Text(
            "The final grade calculator will calculate what grade you will need to get on the final exam to achieve a desired overall grade.",
            style: TextStyle(color: Colors.black87, fontSize: 17.0),
          ),
        ),
      ],
    );
  }

  /// displays the result once calculate button is presssed.
  _showAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Calculation Result"),
          content: Text(calculationResult.toString()),
        );
      },
    );
  }
}

/// Listview within the card widget.
class GradeCalculator extends StatelessWidget {
  const GradeCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        List<TextEditingController> temp = [
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
        ];
        textControllers.add(temp);

        return Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Flexible(
                  flex: 2,
                  child: TextField(
                    controller: textControllers[index][0],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: TextField(
                    controller: textControllers[index][1],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: TextField(
                    controller: textControllers[index][2],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        );
      },
    );
  }
}

/// Widgets used for user input within the final grade tab.
class FinalGradeCalculator extends StatefulWidget {
  const FinalGradeCalculator({Key? key}) : super(key: key);

  @override
  _FinalGradeCalculatorState createState() => _FinalGradeCalculatorState();
}

class _FinalGradeCalculatorState extends State<FinalGradeCalculator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        TextField(
          controller: currentGradeController,
          decoration: const InputDecoration(
            labelText: "Current Grade",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: targetGradeController,
          decoration: const InputDecoration(
            labelText: "Target Grade",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: finalWeightController,
          decoration: const InputDecoration(
            labelText: "Final Exam Weight",
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
