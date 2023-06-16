import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_app/Centers.dart';
import 'package:graduation_project_app/MenuScreen.dart';
import 'comments.dart';
import 'firebaseStorage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NearestCentersScreen extends StatefulWidget {
  const NearestCentersScreen({Key? key}) : super(key: key);

  @override
  State<NearestCentersScreen> createState() => _NearestCentersScreenState();
}

class _NearestCentersScreenState extends State<NearestCentersScreen> {
  late final Uri CenterPhoneNum;
  List<centers> center = [];
  _getData() async {
    center = await firebaseStorage().getAllData();
    setState(() {});
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help Centers',
        ),
      ),
      body: center.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => buildMenuitem(
                          index, Uri.parse("tel:${center[index].ContactNum}")),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: center.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  String centerdocId = "";
  getcenterid(int index, List<centers> centers, userid) {
    var tmp =
        FirebaseFirestore.instance.collection('Centers').get().then((value) {
      value.docs.forEach((element) {
        //print("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC");
        if (element.data()["Name"] == centers[index].Name) {
          centerdocId = element.id;
          showComments(context,
              ownerId: userid,
              mediaUrl: centers[index].Image,
              centerId: element.id,
              index: index);
          print(centerdocId);
        }
        //print("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC");
      });
    });
  }

  Widget buildMenuitem(int index, Uri CenterPhoneNum) => Row(
        children: [
          Expanded(
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
                            height: 1.0,
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
                    Column(
                      children: <Widget>[
                        Image(
                          image: NetworkImage(center[index].Image),
                          height: 80.0,
                          width: 80.0,
                          fit: BoxFit.fill,
                        ),
                        //_reviewsStarWidget(center[index].Rating),
                        RatingBar.builder(
                          initialRating: center[index].Rating.toDouble(),
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ignoreGestures: true,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemSize: 15,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (r) {
                          },
                        ),
                        Text("Rating : " "${center[index].Rating}",
                            style: const TextStyle(
                              fontSize: 10.0,
                            ))
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Wrap(
                  spacing: 40.0,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.comment,
                        color: Colors.blue[900],
                        size: 28,
                      ),
                      onPressed: () => getcenterid(index, center, userid),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.call,
                        color: Colors.blue[900],
                        size: 28,
                      ),
                      onPressed: () async => {
                        if (await canLaunchUrl(CenterPhoneNum))
                          {await launchUrl(CenterPhoneNum)}
                        else
                          {throw "Error occurred trying to call that number."}
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      );
}

showComments(BuildContext context,
    {required String ownerId,
    required String mediaUrl,
    required centerId,
    required index}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Centers(
      centerId: centerId,
      userId: ownerId,
      centerMediaUrl: mediaUrl,
      index: index,
    );
  }));
}

Widget _reviewsStarWidget(num rating) {
  var stars = <Widget>[];
  for (int i = 0; i < 5; i++) {
    Icon star = i < rating
        ? const Icon(Icons.star, color: Colors.orangeAccent, size: 18)
        : const Icon(Icons.star_border, color: Colors.orangeAccent, size: 18);
    stars.add(star);
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: stars,
  );
}
