import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel{

  String? postUrl;
  String? caption;
  String? profileUrl;
  String? postId;
  String? uid;
  String? username;
  Timestamp? createdOn;
 

PostModel({this.caption,this.createdOn,this.postId,this.postUrl,this.profileUrl,this.uid,this.username});
   
   PostModel.fromJson(Map<String,dynamic> json){
    username=json['username'];
    caption =json['caption'];
    profileUrl =json['userProfileUrl'];
    uid =json['uid'];
    postId =json['postId'];
    postId =json['postId'];
    postUrl =json['postUrl'];
   
    createdOn =json['createdOn'];

   }
  



}