class UserData {
  String name = "Guest";
  int numberOfPhotosSeen = 0;
  int numberOfPhotosSave = 0;

  UserData();

  String getName(){
    return name;
  }

  int getNumberOfPhotosSeen(){
    return numberOfPhotosSeen;
  }

  int getNumberOfPhotosSave(){
    return numberOfPhotosSave;
  }

  void setName(String name){
    this.name = name;
  }

  void incrementNumberOfPhotosSeen() => numberOfPhotosSeen++;
  void incrementNumberOfPhotosSave() => numberOfPhotosSave++;

  
  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    numberOfPhotosSeen = json['numberOfPhotosSeen'];
    numberOfPhotosSave = json['numberOfPhotosSave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['numberOfPhotosSeen'] = numberOfPhotosSeen;
    data['numberOfPhotosSave'] = numberOfPhotosSave;
    return data;
  }
}