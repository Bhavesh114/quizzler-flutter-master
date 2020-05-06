import 'package:flutter/material.dart';
import 'brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Brain quizbrain = Brain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> sc = [];
  int count = 0;

  void getcorrectanswer(bool receivedanswer) {
    bool cans = quizbrain.getQuestionAnswer();
    if (quizbrain.isfinished()) {
      Alert(
              context: context,
              title: "Congratulation!!",
              desc: "Quiz is over, your score is $count/13")
          .show();
      setState(() {
        quizbrain.reset();
        sc.clear();
        count = 0;
      });
    } else {
      if (receivedanswer == cans) {
        count++;
        sc.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        sc.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
      setState(() {
        quizbrain.nextquestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizbrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                getcorrectanswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                getcorrectanswer(false);
              },
            ),
          ),
        ),
        Row(
          children: sc,
        ),
      ],
    );
  }
}
