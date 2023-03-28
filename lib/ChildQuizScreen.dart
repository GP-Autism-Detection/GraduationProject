import 'package:flutter/material.dart';
import 'package:graduation_project_app/ChildExamStartScreen.dart';
import 'package:graduation_project_app/MenuScreen.dart';
import 'package:graduation_project_app/ChildQuestionModelScreen.dart';
import 'package:graduation_project_app/QuizInfoScreen.dart';

class ChildQuizScreen extends StatefulWidget {
  @override
  State<ChildQuizScreen> createState() => _ChildQuizScreen();
}

class _ChildQuizScreen extends State<ChildQuizScreen> {
  //define the datas
  List<CQuestion> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  CAnswer? selectedAnswer;
  var ans;
  var backans;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            setState(() {
              selectedAnswer = null;
              if (currentQuestionIndex > 0) {
                currentQuestionIndex--;
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChildExamStartScreen()),
                );
              }
              if (backans == "Yes") {
                score -= 2;
              } else if (backans == "Somewhat") {
                score -= 1;
              } else if (backans == "No") {
                score -= 0;
              }
            });
          },
        ),
        title: Text(
          "Children Autism Test",
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuScreen()),
              );
            },
            icon: const Icon(Icons.home),
            iconSize: 40,
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _questionWidget(),
          _answerList(),
          _nextButton(),
        ]),
      ),
    );
  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Question ${currentQuestionIndex + 1}/${questionList.length.toString()}",
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            questionList[currentQuestionIndex].questionText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answersList
          .map(
            (e) => _answerButton(e),
          )
          .toList(),
    );
  }

  Widget _answerButton(CAnswer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 48,
      child: ElevatedButton(
        child: Text(answer.answerText),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: isSelected ? Colors.green : Colors.white,
          onPrimary: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () {
          setState(() {
            selectedAnswer = answer;
            ans = answer.answerText;
          });
        },
      ),
    );
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 48,
      child: ElevatedButton(
        child: Text(isLastQuestion ? "Submit" : "Next"),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Colors.blue,
          onPrimary: Colors.white,
        ),
        onPressed: () {
          if (ans == "Yes") {
            score += 2;
          } else if (ans == "Somewhat") {
            score += 1;
          } else if (ans == "No") {
            score += 0;
          }
          backans = ans;
          ans = null;
          if (isLastQuestion) {
            //display score

            showDialog(context: context, builder: (_) => _showScoreDialog());
          } else {
            //next question
            setState(() {
              selectedAnswer = null;
              currentQuestionIndex++;
            });
          }
        },
      ),
    );
  }

  _showScoreDialog() {
    bool isAutistic = false;

    if (score >= 13) {
      isAutistic = true;
    }
    String title =
        isAutistic ? "May Indicate Autism " : "No Indication for Autism";

    return AlertDialog(
      title: Text(
        title + " | Your Score is $score / 54",
        style: TextStyle(color: isAutistic ? Colors.redAccent : Colors.green),
      ),
      content: ElevatedButton(
        child: const Text("more info"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizInfoScreen(),
            ),
          );
        },
      ),
    );
  }
}
