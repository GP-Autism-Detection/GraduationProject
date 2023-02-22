import 'package:flutter/material.dart';

class NearestCentersScreen extends StatelessWidget {
  const NearestCentersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Centers for help',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => buildMenuitem(),
            separatorBuilder: (context, index) => Divider(),
            itemCount: 15,
          ),
        ),
      ),
    );
  }

  Widget buildMenuitem() => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The Egyptian Autistic Society',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 6.0,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '16 Street 213, Maadi as Sarayat Al Gharbeyah',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    'Maadi, Cairo',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    'Contact number: 01234567899',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 6.0,
            ),
            Image(
              image: NetworkImage(
                  'https://lh3.googleusercontent.com/p/AF1QipP5cSqO_I7-jamGIJzuow2gpmL_n4JaaQKXwqB7=s1360-w1360-h1020'),
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ],
    ),
  );
}
