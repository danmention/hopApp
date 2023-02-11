class Testimony {
  int? id;
  String? title;
  Null? image;
  String? url;
  String? desc;
  String? userId;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? name;

  Testimony(
      {this.id,
        this.title,
        this.image,
        this.url,
        this.desc,
        this.userId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.name});

  Testimony.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    url = json['url'];
    desc = json['desc'];
    userId = json['user_id'];
    status = json['status'];
    // createdAt = json['created_at'];
    //createdAt = json['created_at'];
    createdAt = (json['created_at'] != null ? DateTime.parse(json['created_at']) : null) as String?;

    updatedAt = json['updated_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['url'] = this.url;
    data['desc'] = this.desc;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    return data;
  }
}
