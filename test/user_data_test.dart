
import 'package:cat_album_lab_flutter/model/user_data.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  test("Get name without user having defined test", () {
    final userData = UserData();

    expect(userData.getName(), "Guest");
  });

  test("Set name test", () {
    final userData = UserData();

    userData.setName("Test Name");

    expect(userData.getName(), "Test Name");
  });

  test("Increments number of photos seen test", () {
    final userData = UserData();
    
    userData.incrementNumberOfPhotosSeen();

    expect(userData.getNumberOfPhotosSeen(), 1);
  });

  test("Increments number of photos seen twice time test", () {
    final userData = UserData();
    
    userData.incrementNumberOfPhotosSeen();
    userData.incrementNumberOfPhotosSeen();

    expect(userData.getNumberOfPhotosSeen(), 2);
  });

    test("Increments number of photos save test", () {
    final userData = UserData();
    
    userData.incrementNumberOfPhotosSave();

    expect(userData.getNumberOfPhotosSave(), 1);
  });

    test("Increments number of photos save twice time test", () {
    final userData = UserData();
    
    userData.incrementNumberOfPhotosSave();
    userData.incrementNumberOfPhotosSave();

    expect(userData.getNumberOfPhotosSave(), 2);
  });
  
}