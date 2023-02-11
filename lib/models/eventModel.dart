import 'package:flutter/material.dart';

class Event {
  int? id;
  String? title;
  String? url;
  String? venue;
  String? location;
  String? dateOfEvent;
  String? endDateOfEvent;
  String? descriptions;
  String? userId;
  String? phone;
  Null? time;
  String? createdAt;
  String? updatedAt;
  String? image;

  Event(
      {this.id,
        this.title,
        this.url,
        this.venue,
        this.location,
        this.dateOfEvent,
        this.endDateOfEvent,
        this.descriptions,
        this.userId,
        this.phone,
        this.time,
        this.createdAt,
        this.updatedAt,
        this.image});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    venue = json['venue'];
    location = json['location'];
    dateOfEvent = json['date_of_event'];
    endDateOfEvent = json['end_date_of_event'];
    descriptions = json['descriptions'];
    userId = json['user_id'];
    phone = json['phone'];
    time = json['time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['venue'] = this.venue;
    data['location'] = this.location;
    data['date_of_event'] = this.dateOfEvent;
    data['end_date_of_event'] = this.endDateOfEvent;
    data['descriptions'] = this.descriptions;
    data['user_id'] = this.userId;
    data['phone'] = this.phone;
    data['time'] = this.time;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}


class TopMenu{


  Color? color;
  String? title;
  String? subtitle;
  IconData? iconData;
  String? route;

  TopMenu({this.subtitle, this.color, this.iconData,  this.route,this.title});

}