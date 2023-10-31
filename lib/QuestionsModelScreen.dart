import 'package:easy_localization/easy_localization.dart';

class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final int Correctness;

  Answer(this.answerText, this.Correctness);
}

List<Question> getQuestions() {
  List<Question> list = [];
  //ADD questions and answer here

  list.add(Question(
    "Question_Model_Screen_Q1".tr(),
    [
      Answer("Quiz_Screen_A1".tr(), 3),
      Answer("Quiz_Screen_A2".tr(), 2),
      Answer("Quiz_Screen_A3".tr(), 1),
      Answer("Quiz_Screen_A4".tr(), 0),
    ],
  ));
  list.add(Question(
    "Question_Model_Screen_Q2".tr(),
    [
      Answer("Quiz_Screen_A1".tr(), 3),
      Answer("Quiz_Screen_A2".tr(), 2),
      Answer("Quiz_Screen_A3".tr(), 1),
      Answer("Quiz_Screen_A4".tr(), 0),
    ],
  ));
  list.add(Question(
    "Question_Model_Screen_Q3".tr(),
    [
      Answer("Quiz_Screen_A1".tr(), 3),
      Answer("Quiz_Screen_A2".tr(), 2),
      Answer("Quiz_Screen_A3".tr(), 1),
      Answer("Quiz_Screen_A4".tr(), 0),
    ],
  ));
  list.add(Question(
    "Question_Model_Screen_Q4".tr(),
    [
      Answer("Quiz_Screen_A1".tr(), 3),
      Answer("Quiz_Screen_A2".tr(), 2),
      Answer("Quiz_Screen_A3".tr(), 1),
      Answer("Quiz_Screen_A4".tr(), 0),
    ],
  ));
  list.add(Question(
    "Question_Model_Screen_Q5".tr(),
    [
      Answer("Quiz_Screen_A1".tr(), 3),
      Answer("Quiz_Screen_A2".tr(), 2),
      Answer("Quiz_Screen_A3".tr(), 1),
      Answer("Quiz_Screen_A4".tr(), 0),
    ],
  ));
  list.add(Question(
    "Question_Model_Screen_Q6".tr(),
    [
      Answer("Quiz_Screen_A1".tr(), 3),
      Answer("Quiz_Screen_A2".tr(), 2),
      Answer("Quiz_Screen_A3".tr(), 1),
      Answer("Quiz_Screen_A4".tr(), 0),
    ],
  ));
  list.add(Question(
    "Question_Model_Screen_Q7".tr(),
    [
      Answer("Quiz_Screen_A1".tr(), 3),
      Answer("Quiz_Screen_A2".tr(), 2),
      Answer("Quiz_Screen_A3".tr(), 1),
      Answer("Quiz_Screen_A4".tr(), 0),
    ],
  ));
  list.add(Question(
    "Question_Model_Screen_Q8".tr(),
    [
      Answer("Quiz_Screen_A1".tr(), 3),
      Answer("Quiz_Screen_A2".tr(), 2),
      Answer("Quiz_Screen_A3".tr(), 1),
      Answer("Quiz_Screen_A4".tr(), 0),
    ],
  ));
  list.add(Question(
    "Question_Model_Screen_Q9".tr(),
    [
      Answer("Quiz_Screen_A1".tr(), 3),
      Answer("Quiz_Screen_A2".tr(), 2),
      Answer("Quiz_Screen_A3".tr(), 1),
      Answer("Quiz_Screen_A4".tr(), 0),
    ],
  ));
  list.add(Question(
    "Question_Model_Screen_Q10".tr(),
    [
      Answer("Quiz_Screen_A1".tr(), 3),
      Answer("Quiz_Screen_A2".tr(), 2),
      Answer("Quiz_Screen_A3".tr(), 1),
      Answer("Quiz_Screen_A4".tr(), 0),
    ],
  ));
  list.add(Question(
    "Question_Model_Screen_Q11".tr(),
    [
      Answer("Quiz_Screen_A1".tr(), 3),
      Answer("Quiz_Screen_A2".tr(), 2),
      Answer("Quiz_Screen_A3".tr(), 1),
      Answer("Quiz_Screen_A4".tr(), 0),
    ],
  ));
  list.add(Question(
    "Question_Model_Screen_Q12".tr(),
    [
      Answer("Quiz_Screen_A1".tr(), 3),
      Answer("Quiz_Screen_A2".tr(), 2),
      Answer("Quiz_Screen_A3".tr(), 1),
      Answer("Quiz_Screen_A4".tr(), 0),
    ],
  ));
  list.add(Question(
    "Question_Model_Screen_Q13".tr(),
    [
      Answer("Quiz_Screen_A1".tr(), 3),
      Answer("Quiz_Screen_A2".tr(), 2),
      Answer("Quiz_Screen_A3".tr(), 1),
      Answer("Quiz_Screen_A4".tr(), 0),
    ],
  ));
  list.add(Question(
    "Question_Model_Screen_Q14".tr(),
    [
      Answer("Quiz_Screen_A1".tr(), 3),
      Answer("Quiz_Screen_A2".tr(), 2),
      Answer("Quiz_Screen_A3".tr(), 1),
      Answer("Quiz_Screen_A4".tr(), 0),
    ],
  ));

  return list;
}
