import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
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
        centerTitle: true,
        //backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Center_appbar'.tr(),
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
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                    child: Text(
                      center[index].Name,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, top: 5),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    center[index].Address,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    center[index].Area,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    center[index].ContactNum,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-1, 1),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 0, 0, 0),
                                      child: Wrap(
                                        spacing: 40,
                                        runSpacing: 0,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.comment,
                                              size: 28,
                                            ),
                                            onPressed: () => getcenterid(
                                                index, center, userid),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.call,
                                              size: 28,
                                            ),
                                            onPressed: () async => {
                                              if (await canLaunchUrl(
                                                  CenterPhoneNum))
                                                {
                                                  await launchUrl(
                                                      CenterPhoneNum)
                                                }
                                              else
                                                {
                                                  throw "Error occurred trying to call that number."
                                                }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey, //<-- SEE HERE
                                      width: 1,
                                    ),
                                  ),
                                  child: Image(
                                    image: NetworkImage(center[index].Image),
                                    height: 80.0,
                                    width: 80.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                RatingBar.builder(
                                  initialRating:
                                      center[index].Rating.toDouble(),
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  ignoreGestures: true,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
                                  itemSize: 15,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (r) {},
                                ),
                                Text(
                                    "Center_rating".tr() +
                                        " " +
                                        "${center[index].Rating}",
                                    style: const TextStyle(
                                      fontSize: 10.0,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
