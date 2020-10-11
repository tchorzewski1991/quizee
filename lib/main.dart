import 'package:flutter/material.dart';
import 'package:quizee/quiz_manager.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'answer_presenter.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: Text(
            'Quizee',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 30.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey.shade900,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
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
  final QuizManager quizManager = QuizManager();

  @override
  void initState() {
    quizManager.initState();
    super.initState();
  }

  Future<void> processAnswer(BuildContext context, bool receivedAnswer) async {
    quizManager.processAnswer(receivedAnswer);

    bool decision = false;

    if (quizManager.isQuizFinished()) {
      decision = await getDecision(context);
    }

    setState(() {
      if (decision) {
        quizManager.initState();
      } else {
        quizManager.nextQuestion();
      }
    });
  }

  Future<bool> getDecision(BuildContext context) {
    return Alert(
      context: context,
      type: AlertType.info,
      title: "Quizee",
      desc: "Shall we play again?",
      buttons: [
        DialogButton(
          child: Text('Yes, please!'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizManager.getQuestionText(),
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
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () => processAnswer(context, true),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () => processAnswer(context, false),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: quizManager.questions.map(
                (question) {
                  return Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: question.isAnswered,
                    child: Container(
                      width: 50,
                      // width: deviceWidth / (quizManager.questions.length + 2),
                      child: AnswerPresenter(
                        answer: question.answer,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        )
      ],
    );
  }
}
