class CustomerInfo {
  String? furnitureType;
  String? roomType;
  String? propertyType;
  String? fullname;
  String? email;
  String? country;
  String? mobile;
  String? monthlyRenPrice;
  String? propertyName;
  DateTime? dateTime;
  String? address;
  String? notes;
  CustomerInfo({
    this.fullname,
    this.email,
    this.country,
    this.mobile,
    this.monthlyRenPrice,
    this.dateTime,
    this.propertyName,
    this.address,
    this.notes,
    this.propertyType,
    this.roomType,
    this.furnitureType,
  });

  String toString() {
    String ans =
        // ignore: unused_label
        "fullName: ${this.fullname}\ncountry: ${this.country}\nmobile: ${this.mobile}\nmonthlyRenPrice: ${this.monthlyRenPrice}\nemail: ${this.email}\ndateTime: ${this.dateTime}\naddress: ${this.address}\npropertyName: ${this.propertyName}\npropertyType: ${this.propertyType}\nroomType: ${this.roomType}\nfurnitureType: ${this.furnitureType}";
    return ans;
  }

  Map<String, dynamic> toJson() {
    return {
      "fullname": this.fullname,
      "email": this.email,
      "country": this.country,
      "mobile": this.mobile,
      "monthlyRenPrice": this.monthlyRenPrice,
      "address": this.address,
      "dateTime": this.dateTime,
      "nameOfProperty": this.propertyName,
      "roomType": this.roomType,
      "furnitureType": this.furnitureType,
      "propertyType": this.propertyType,
    };
  }

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      fullname: json["fullname"],
      email: json["email"],
      country: json["country"],
      mobile: json["mobile"],
      monthlyRenPrice: json["monthlyRenPrice"],
      address: json["address"],
      notes: json["notes"],
      propertyName: json["propertyName"],
      propertyType: json["propertyType"],
      roomType: json["roomType"],
      furnitureType: json["furnitureType"],
    );
  }
}
