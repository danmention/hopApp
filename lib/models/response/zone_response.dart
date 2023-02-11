class Zone {
  int? id;
  String? parentId;
  String? url;
  String? title;
  Null? faIcon;
  Null? featuredImg;
  Null? showMenu;
  String? status;
  Null? createdBy;
  String? createdAt;
  String? updatedAt;

  Zone(
      {this.id,
        this.parentId,
        this.url,
        this.title,
        this.faIcon,
        this.featuredImg,
        this.showMenu,
        this.status,
        this.createdBy,
        this.createdAt,
        this.updatedAt});

  // int get hashCode => title.hashCode;
  //
  // bool operator==(Object other) => other is url && other.title == title;


  Zone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    url = json['url'];
    title = json['title'];
    faIcon = json['fa_icon'];
    featuredImg = json['featured_img'];
    showMenu = json['show_menu'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['url'] = this.url;
    data['title'] = this.title;
    data['fa_icon'] = this.faIcon;
    data['featured_img'] = this.featuredImg;
    data['show_menu'] = this.showMenu;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


class Area {
  int? id;
  String? parentId;
  String? url;
  String? title;
  Null? faIcon;
  Null? featuredImg;
  Null? showMenu;
  String? status;
  Null? createdBy;
  String? createdAt;
  String? updatedAt;

  Area(
      {this.id,
        this.parentId,
        this.url,
        this.title,
        this.faIcon,
        this.featuredImg,
        this.showMenu,
        this.status,
        this.createdBy,
        this.createdAt,
        this.updatedAt});

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    url = json['url'];
    title = json['title'];
    faIcon = json['fa_icon'];
    featuredImg = json['featured_img'];
    showMenu = json['show_menu'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['url'] = this.url;
    data['title'] = this.title;
    data['fa_icon'] = this.faIcon;
    data['featured_img'] = this.featuredImg;
    data['show_menu'] = this.showMenu;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}