class TestimonyResponse {
  String? userId;
  String? title;
  String? desc;
  String? url;
  String? updatedAt;
  String? createdAt;
  int? id;

  TestimonyResponse(
      {this.userId,
        this.title,
        this.desc,
        this.url,
        this.updatedAt,
        this.createdAt,
        this.id});

  TestimonyResponse.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    title = json['title'];
    desc = json['desc'];
    url = json['url'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['url'] = this.url;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
