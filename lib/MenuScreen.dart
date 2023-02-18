import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
            Icons.menu,
        ),
        title: Text(
            'Autism Detection',
        ),
      ),
      body: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                Text(
                  'Take Test',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      "Take the test",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Wrap(
                        spacing: 20.0,
                        runSpacing: 20.0,
                        children:[
                          SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                              color: Color.fromARGB(200, 200, 200, 200),
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset("Imags\Child.jpg", width: 64.0,),
                                      SizedBox(height: 10.0),
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'Upload Photo',
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                              color: Color.fromARGB(200, 200, 200, 200),
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset("Imags\Child.jpg", width: 64.0,),
                                      SizedBox(height: 10.0),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Upload Photo',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      "Take the test",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Wrap(
                        spacing: 20.0,
                        runSpacing: 20.0,
                        children:[
                          SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                              color: Color.fromARGB(200, 200, 200, 200),
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset("Imags\Center.jpg", width: 64.0,),
                                      SizedBox(height: 10.0),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'View Near Centers',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                              color: Color.fromARGB(200, 200, 200, 200),
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset("Imags\Child.jpg", width: 64.0,),
                                      SizedBox(height: 10.0),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Upload Photo',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text(
                      "Take the test",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Wrap(
                        spacing: 20.0,
                        runSpacing: 20.0,
                        children:[
                          SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                              color: Color.fromARGB(200, 200, 200, 200),
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset("Imags\puzzle.png", width: 64.0,),
                                      SizedBox(height: 10.0),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Game',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: Card(
                              color: Color.fromARGB(200, 200, 200, 200),
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.asset("Imags\puzzle.png", width: 64.0,),
                                      SizedBox(height: 10.0),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Game',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
        ),
      ),
    );
  }
}