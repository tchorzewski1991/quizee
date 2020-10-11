import 'package:flutter/material.dart';

import 'answer.dart';

class AnswerPresenter extends StatelessWidget {
  final Answer answer;

  final Widget _rightAnswer = Icon(
    Icons.check,
    color: Colors.green,
    size: 30.0,
  );

  final Widget _wrongAnswer = Icon(
    Icons.close,
    color: Colors.red,
    size: 30.0,
  );

  AnswerPresenter({
    Key key,
    @required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildPresenter(answer);
  }

  Widget _buildPresenter(Answer answer) {
    return answer.isCorrect() ? _rightAnswer : _wrongAnswer;
  }
}
