class FirebaseHistory {
  String? list;
  String? date;
  int? right;
  int? wrong;
  int? skip;
  int? refId;
  int? time;
  int? totalQuestion;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['list'] = list;
    data['date'] = date;
    data['right'] = right;
    data['wrong'] = wrong;
    data['skip'] = skip;
    data['time'] = time;
    data['totalQuestion'] = totalQuestion;
    data['ref_id'] = refId;
    return data;
  }
}
