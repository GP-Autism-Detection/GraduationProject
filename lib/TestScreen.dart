import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  var result = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test result',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image(
              image: NetworkImage(
                  'https://domf5oio6qrcr.cloudfront.net/medialibrary/13292/700fc35b-3c70-4762-b24a-c9d895eb9863.jpg'),
              height: 200.0,
              width: 200.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 16.0,
            ),
            Container(
              width: double.infinity,
              color: Colors.indigoAccent,
              child: MaterialButton(
                onPressed: () {
                  print('Result');
                },
                child: Text(
                  'Show result',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
