import 'package:flutter/material.dart';
import 'package:graduation_project_app/QuizScreen.dart';
import 'package:graduation_project_app/MenuScreen.dart';
class QuizInfoScreen extends StatefulWidget {
  const QuizInfoScreen({Key? key}) : super(key: key);

  @override
  State<QuizInfoScreen> createState() => _QuizInfoScreen();
}

class _QuizInfoScreen extends State<QuizInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Autism Test",style: TextStyle(fontSize: 25),),
        actions: [
          IconButton(onPressed: ()
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuScreen()),
            );
          },
            icon: const Icon(Icons.home),iconSize: 40,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Scores of 13 or above may indicate Autism Spectrum Disorder.",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
                  textAlign: TextAlign.justify,
                ),
              ),
             // SizedBox(height: 50.0),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Next Steps:",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Autism spectrum disorder is a spectrum of disorders with a shared core of symptoms including difficulties with social interaction, empathy, communication, and flexible behavior. While autism is usually diagnosed at a young age, some adults with high-functioning autism do go undiagnosed until adulthood. If you're interested in being evaluated for ASD, begin with your family doctor, who will evaluate you and likely refer to a you psychiatrist or psychologist for in-depth assessment. Adult ASD can be treated with different types of psychotherapy depending on the challenges you're experiencing.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
