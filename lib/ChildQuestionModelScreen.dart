class CQuestion {
  final String questionText;
  final List<CAnswer> answersList;

  CQuestion(this.questionText, this.answersList);
}

class CAnswer {
  final String answerText;
  final int Correctness;

  CAnswer(this.answerText, this.Correctness);
}

List<CQuestion> getQuestions() {
  List<CQuestion> list = [];
  //ADD questions and answer here

  list.add(CQuestion(
    "Is old-fashioned or precocious ?",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));

  list.add(CQuestion(
    "Is regarded as an eccentric professor by the other children ?",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Lives somewhat in a world of his/her own with restricted idiosyncratic intellectual interests",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Accumulates facts on certain subjects (good rote memory) but does not really understand the meaning",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Has a literal understanding of ambiguous and metaphorical language ?",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Has a deviant style of communication with a formal, fussy, old-fashioned or robot-like language ?",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Invents idiosyncratic words and expressions",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Has a different voice or speech ?",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Expresses sounds involuntarily; clears throats, grunts, smacks, cries or screams",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Is surprisingly good at some things and surprisingly poor at others ?",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Uses language freely but fails to make adjustment fit social contexts or the needs of different listeners",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Lacks empathy ",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Makes naive or embarrassing remarks ",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Has a deviant style of gaze? ",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Wishes to be sociable but fails to make relationships with peers ",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Can be with other children but only on his/her terms ? ",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Lacks best friend ",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Lacks common sense ",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Is poor at games: no idea of cooperating in a team, scores own goals ? ",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Has clumsy, ill coordinated, ungainly, awkward movements or gestures ? ",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Has involuntary face or body movements ?",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Has difficulties in completing simple daily activities because of compulsory repetition of certain actions or thoughts ? ",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Has special routines: insists on no change ? ",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "shows idiosyncratic attachment to objects",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Is bullied by other children",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Has markedly unusual facial expression",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));
  list.add(CQuestion(
    "Has markedly unusual posture",
    [
      CAnswer("Yes", 2),
      CAnswer("Somewhat", 1),
      CAnswer("No", 0),
    ],
  ));

  return list;
}
