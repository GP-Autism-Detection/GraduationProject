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
    "It is difficult for me to understand how other people are feeling when we are talking.",
    [
      Answer("True now & when I was young", 3),
      Answer("True only now", 2),
      Answer("True only when I was < 16", 1),
      Answer("Never true", 0),
    ],
  ));
  list.add(Question(
    "Some ordinary textures that do not bother others feel very offensive when they touch my skin.",
    [
      Answer("True now & when I was young", 3),
      Answer("True only now", 2),
      Answer("True only when I was < 16", 1),
      Answer("Never true", 0),
    ],
  ));
  list.add(Question(
    "It is very difficult for me to work and function in groups.",
    [
      Answer("True now & when I was young", 3),
      Answer("True only now", 2),
      Answer("True only when I was < 16", 1),
      Answer("Never true", 0),
    ],
  ));
  list.add(Question(
    "It is difficult to figure out what other people expect of me",
    [
      Answer("True now & when I was young", 3),
      Answer("True only now", 2),
      Answer("True only when I was < 16", 1),
      Answer("Never true", 0),
    ],
  ));
  list.add(Question(
    "I often don't know how to act in social situations.",
    [
      Answer("True now & when I was young", 3),
      Answer("True only now", 2),
      Answer("True only when I was < 16", 1),
      Answer("Never true", 0),
    ],
  ));
  list.add(Question(
    "I can chat and make small talk with people",
    [
      Answer("True now & when I was young", 3),
      Answer("True only now", 2),
      Answer("True only when I was < 16", 1),
      Answer("Never true", 0),
    ],
  ));
  list.add(Question(
    "When I feel overwhelmed by my senses, I have to isolate myself to shut them down.",
    [
      Answer("True now & when I was young", 3),
      Answer("True only now", 2),
      Answer("True only when I was < 16", 1),
      Answer("Never true", 0),
    ],
  ));
  list.add(Question(
    "How to make friends and socialize is a mystery to me.",
    [
      Answer("True now & when I was young", 3),
      Answer("True only now", 2),
      Answer("True only when I was < 16", 1),
      Answer("Never true", 0),
    ],
  ));
  list.add(Question(
    "When talking to someone, I have a hard time telling when it is my turn to talk or to listen.",
    [
      Answer("True now & when I was young", 3),
      Answer("True only now", 2),
      Answer("True only when I was < 16", 1),
      Answer("Never true", 0),
    ],
  ));
  list.add(Question(
    "Sometimes I have to cover my ears to block out painful noises (like vacuum cleaners or people talking too much or too loudly).",
    [
      Answer("True now & when I was young", 3),
      Answer("True only now", 2),
      Answer("True only when I was < 16", 1),
      Answer("Never true", 0),
    ],
  ));
  list.add(Question(
    "It can be very hard to read someone's face,hand,and body movements when we are talking.",
    [
      Answer("True now & when I was young", 3),
      Answer("True only now", 2),
      Answer("True only when I was < 16", 1),
      Answer("Never true", 0),
    ],
  ));
  list.add(Question(
    "I focus on details rather than the overall idea.",
    [
      Answer("True now & when I was young", 3),
      Answer("True only now", 2),
      Answer("True only when I was < 16", 1),
      Answer("Never true", 0),
    ],
  ));
  list.add(Question(
    "I take things too literally,so I often miss what people are trying to say.",
    [
      Answer("True now & when I was young", 3),
      Answer("True only now", 2),
      Answer("True only when I was < 16", 1),
      Answer("Never true", 0),
    ],
  ));
  list.add(Question(
    "I get extremely upset when the way I like to do things is suddenly changed.",
    [
      Answer("True now & when I was young", 3),
      Answer("True only now", 2),
      Answer("True only when I was < 16", 1),
      Answer("Never true", 0),
    ],
  ));

  return list;
}
