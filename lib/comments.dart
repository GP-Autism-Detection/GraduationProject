import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project_app/MenuScreen.dart';
import 'Centers.dart';
import 'firebaseStorage.dart';
import 'User.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

final _collectionReference = FirebaseFirestore.instance.collection("Centers");
TextEditingController commentController = TextEditingController();
TextEditingController ratingController = TextEditingController();
final _formKey = GlobalKey<FormState>();
late FToast fToast;

showToast() {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.green,
    ),
    child: Text("Center_review_post".tr(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        )),
  );
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 2),
  );
}
//DocumentSnapshot docSnap =  _collectionReference.get();

List<centers> center = [];
User? user;
_getData() async {
  center = await firebaseStorage().getAllData();
  user = await firebaseStorage().getUserData();
}

class Centers extends StatefulWidget {
  String? centerId;
  String? userId;
  String? centerMediaUrl;
  int? index;

  Centers({
    required this.centerId,
    required this.userId,
    required this.centerMediaUrl,
    required this.index,
  });

  @override
  CommentsState createState() => CommentsState(
      centerId: centerId!,
      userId: userId!,
      centerMediaUrl: centerMediaUrl!,
      index: index!);
}

class CommentsState extends State<Centers> {
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  TextEditingController commentController = TextEditingController();
  //TextEditingController ratingController = TextEditingController();
  var user_rating = 2.5;
  bool _validate = false;
  bool _validate2 = false;
  num avgrating = 0.0;

  final String centerId;
  final String userId;
  final String centerMediaUrl;
  final int index;

  CommentsState({
    required this.centerId,
    required this.userId,
    required this.centerMediaUrl,
    required this.index,
  });

  buildComments() {
    return StreamBuilder(
        stream: _collectionReference
            .doc(centerId)
            .collection("comments")
            .orderBy("time", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<Comment> comments = [];
          snapshot.data!.docs.forEach((doc) {
            // print("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
            // print(doc.data());
            // print("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
            if (Comment.fromDocument(doc).comment == userId) {}
            comments.add(Comment.fromDocument(doc));
          });
          //print("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
          if (comments.isNotEmpty) {
            double sumRating = 0;
            for (var i = 0; i < comments.length; i++) {
              sumRating += comments[i].rating;
            }
            //https://stackoverflow.com/questions/68075977/how-to-round-up-and-down-double-to-the-nearest-interval-in-dart-flutter
            var avg_before_ceiling = sumRating / comments.length;
            avgrating = (avg_before_ceiling * 2).ceilToDouble() / 2;
            //print(sumRating);
            //print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
            //print(avg_before_ceiling);
            print(avgrating);
            //print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
          }
          //print("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
          return ListView(
            children: comments,
          );
        });
  }

  addComment(centerId) async {
    await _getData();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    String randomStr = String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    // print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");

    await _collectionReference
        .doc(centerId)
        .collection("comments")
        .doc(randomStr)
        .set({
      "username": user!.name,
      "userId": userid,
      "comment": commentController.text,
      "time": DateTime.now().millisecondsSinceEpoch,
      "rating": user_rating,
      "Commented": true,
      //"timestamp": DateTime.now().millisecondsSinceEpoch,
    });
    // print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
    await _collectionReference.doc(centerId).update({
      "Rating": avgrating,
      //"timestamp": DateTime.now().millisecondsSinceEpoch,
    });

    // print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
    //print(userid);
    //print(user?.name);
    //print(commentController.text);
    //print(DateTime.now().millisecondsSinceEpoch);
    // print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
    commentController.clear();
    //ratingController.clear();
  }

  // String? get _errorText {
  //   // at any time, we can get the text from _controller.value.text
  //   final text = commentController.value.text;
  //   // Note: you can do your own custom validation here
  //   // Move this logic this outside the widget for more testable code
  //   if (text.isEmpty) {
  //     return 'Can\'t be empty';
  //   }
  //   // return null if the text is valid
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.background,
      appBar:
          AppBar(centerTitle: true, title: Text("Center_review_appbar".tr())),
      body: Column(
        children: <Widget>[
          Expanded(child: buildComments()),
          Divider(),
          SizedBox(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    ListTile(
                      title: TextFormField(
                        controller: commentController,
                        validator: (commentController) {
                          if (commentController!.isEmpty) {
                            return 'Center_comment_valid'.tr();
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'Center_review_comment'.tr()),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RatingBar.builder(
                      initialRating: 2.5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        user_rating = rating;
                      },

                      //   title: TextFormField(
                      //     controller: ratingController,
                      //     keyboardType: const TextInputType.numberWithOptions(
                      //         decimal: true),
                      //     decoration: const InputDecoration(hintText: 'Rating'),
                      //     validator: (ratingController) {
                      //       if (ratingController!.isEmpty) {
                      //         return 'Please enter a number ';
                      //       }
                      //       if (ratingController.contains('.')) {
                      //         return 'Please pick a number between 0 & 5';
                      //       }
                      //       if (int.parse(ratingController) < 1 ||
                      //           int.parse(ratingController) > 5) {
                      //         return 'Please pick a number between 1 & 5 ';
                      //       }
                      //       return null;
                      //     },
                      //   ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 175,
                      child: FilledButton(
                        style: ElevatedButton.styleFrom(
                            // Background color
                            ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Fluttertoast.showToast(
                            //     msg: "Thanks For Your Review ! ",
                            //     toastLength: Toast.LENGTH_SHORT,
                            //     gravity: ToastGravity.TOP,
                            //     timeInSecForIosWeb: 2,
                            //     backgroundColor: Colors.white24,
                            //     textColor: Colors.white,
                            //     fontSize: 12.0,
                            //
                            // );
                            showToast();
                            addComment(centerId);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Text("Center_review_post_review".tr(),
                              style: TextStyle(
                                fontSize: 12.0,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ListTile(
          //   title: TextFormField(
          //     controller: commentController,
          //     decoration: InputDecoration(labelText: "Write a comment..."),//,errorText: _validate ? ' Can\'t Be Empty !' : null,),
          //     validator: (commentController) {
          //       if(commentController!.isEmpty) return 'Comment field cannot be empty';
          //     },
          //   ),
          //   trailing: FloatingActionButton(
          //     onPressed: () =>
          //     {
          //       setState(()
          //       {
          //         _validate = commentController.text.isEmpty;
          //         _validate2 = ratingController.text.isEmpty;
          //       }),
          //       if(_validate==false&&_validate2==false){
          //         addComment(centerId)
          //       }
          //     },
          //
          //     child: Text("Post"),
          //   ),
          // ),
          // const Divider(),
          // ListTile(
          //   title: TextFormField(
          //     controller: ratingController,
          //     decoration: InputDecoration(labelText: "Enter rating...",errorText: _validate2 ? ' Please Enter From 1->5 !' : null,),
          //     validator: (ratingController) {
          //       if (ratingController!.isEmpty) {
          //         return 'Rating field cannot be empty';
          //       }
          //       if (int.parse(ratingController) < 1) {
          //         return 'Rating cannot be less than 1';
          //       }
          //       if (int.parse(ratingController) > 5) {
          //         return 'Rating cannot be greater than 5';
          //       }
          //     },
          //     keyboardType: const TextInputType.numberWithOptions(decimal: true),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String username;
  final String userId;
  final String comment;
  final int time;
  final rating;

  Comment(
      {required this.username,
      required this.userId,
      required this.comment,
      required this.time,
      required this.rating});

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
        username: doc['username'],
        userId: doc['userId'],
        comment: doc['comment'],
        time: doc["time"],
        rating: doc["rating"]);
  }

  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(time);
    final format = DateFormat('dd/MM/yyyy h:mma');
    final dateString = format.format(date);
    return Column(
      children: <Widget>[
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(username),
                subtitle: Text(comment),
                leading: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      'https://ouch-cdn2.icons8.com/-JZptPGuKRXkyuzdLeFBi71mdKqKYQHlVYx_4AQFhdQ/rs:fit:256:256/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvNTIx/LzYyOTBlMmU4LWQ2/NmMtNDgzMS1hOWFl/LTUwNDQ3M2ZkMWZj/NS5wbmc.png'),
                ),
                contentPadding: const EdgeInsets.all(0),
                //leading: Icon(Icons.account_circle_rounded,size: 50,color: Colors.lightBlue,),
              ),
            ],
          ),
          trailing: Column(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              RatingBar.builder(
                initialRating: rating,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ignoreGestures: true,
                itemPadding: EdgeInsets.symmetric(horizontal: 1),
                itemSize: 19,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (r) {},
              ),
              //   _reviewsStarWidget(rating),
              Text(
                dateString,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          dense: false,
        ),
        // Card(
        //   child: ListTile(
        //     title: Text(username),
        //     subtitle:Text(comment),
        //     trailing: Text(dateString),
        //     contentPadding: EdgeInsets.all(10),
        //   ),
        // ),
        // Divider(),
      ],
    );
  }

  Widget _reviewsStarWidget(int rating) {
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
}
