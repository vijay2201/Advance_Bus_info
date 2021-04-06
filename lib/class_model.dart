class PassDetails {
  var passType;
  var fullName;
  var address;
  var gender;
  var dateOfBirth;
  var age;
  var occupation;
  var education;
  var category;
  var emailAddress;
  var mobileNo;
  var fromPlace;
  var toPlace;
  var duration;
  var viaPlaces;
  var distance;
  var startDate;
  var userPhoto;
  var collegeIdPhoto;
  var lightBillPhoto;
  var freeReceiptPhoto;

  PassDetails(
      {this.mobileNo,
      this.distance,
      this.viaPlaces,
      this.toPlace,
      this.fromPlace,
      this.address,
      this.age,
      this.dateOfBirth,
      this.fullName,
      this.duration,
      this.category,
      this.collegeIdPhoto,
      this.education,
      this.emailAddress,
      this.freeReceiptPhoto,
      this.gender,
      this.lightBillPhoto,
      this.occupation,
      this.passType,
      this.startDate,
      this.userPhoto});
}
