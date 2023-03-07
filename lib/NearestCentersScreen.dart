import 'package:flutter/material.dart';
import 'package:graduation_project_app/Centers.dart';
import 'firebaseStorage.dart';

class NearestCentersScreen extends StatefulWidget {
  const NearestCentersScreen({Key? key}) : super(key: key);

  @override
  State<NearestCentersScreen> createState() => _NearestCentersScreenState();
}

class _NearestCentersScreenState extends State<NearestCentersScreen> {
  List<centers> center =[];
  _getData() async{
    center = await firebaseStorage().getAllData();
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help Centers',
        ),
      ),
      body: center.isEmpty ? Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => buildMenuitem(index),
            separatorBuilder: (context, index) => Divider(),
            itemCount: center.length,
          ),
        ),
      ),
    );
  }

  Widget buildMenuitem(int index) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          center[index].Name,
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
                    center[index].Address,
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
                    center[index].Area,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    center[index].ContactNum,
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
                  center[index].Image),
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
