class Api {
  dynamic hotelName;
  dynamic latitude;
  dynamic longitude;
  dynamic price;

  Api({this.hotelName, this.latitude, this.longitude, this.price});

  Api.fromJson(Map<String, dynamic> json) {
    hotelName = json['0']?? '';
    latitude = json['1'];
    longitude = json['2'];
    price = json['3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.hotelName;
    data['1'] = this.latitude;
    data['2'] = this.longitude;
    data['3'] = this.price;
    return data;
  }
}
