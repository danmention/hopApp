class HopReportResponse {
  int? currentPage;
  List<HopReport>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  HopReportResponse(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  HopReportResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <HopReport>[];
      json['data'].forEach((v) {
        data!.add(new HopReport.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class HopReport {
  int? id;
  String? hopSerialNumber;
  String? url;
  String? leaderName;
  String? attendance;
  String? noOfFirstTimers;
  String? desc;
  String? image;
  String? offering;
  String? timeOfMeeting;
  String? status;
  String? userId;
  String? createdAt;
  String? updatedAt;

  HopReport(
      {this.id,
        this.hopSerialNumber,
        this.url,
        this.leaderName,
        this.attendance,
        this.noOfFirstTimers,
        this.desc,
        this.image,
        this.offering,
        this.timeOfMeeting,
        this.status,
        this.userId,
        this.createdAt,
        this.updatedAt});

  HopReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hopSerialNumber = json['hop_serial_number'];
    url = json['url'];
    leaderName = json['leader_name'];
    attendance = json['attendance'];
    noOfFirstTimers = json['no_of_first_timers'];
    desc = json['desc'];
    image = json['image'];
    offering = json['offering'];
    timeOfMeeting = json['time_of_meeting'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hop_serial_number'] = this.hopSerialNumber;
    data['url'] = this.url;
    data['leader_name'] = this.leaderName;
    data['attendance'] = this.attendance;
    data['no_of_first_timers'] = this.noOfFirstTimers;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['offering'] = this.offering;
    data['time_of_meeting'] = this.timeOfMeeting;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}