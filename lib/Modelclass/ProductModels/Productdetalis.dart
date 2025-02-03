class ProductdetalisModel {
  ProductdetalisModel({
      this.id, 
      this.partsCat, 
      this.partImage, 
      this.vBrand, 
      this.vCategory, 
      this.price, 
      this.partsName, 
      this.description, 
      this.offerPrice, 
      this.isOffer, 
      this.productRating,});

  ProductdetalisModel.fromJson(dynamic json) {
    id = json['id'];
    partsCat = json['parts_Cat'];
    partImage = json['part_image'];
    vBrand = json['v_brand'];
    vCategory = json['v_category'];
    price = json['price'];
    partsName = json['parts_name'];
    description = json['description'];
    offerPrice = json['offer_price'];
    isOffer = json['is_offer'];
    productRating = json['product_rating'];
  }
  int? id;
  num? partsCat;
  String? partImage;
  num? vBrand;
  num? vCategory;
  String? price;
  String? partsName;
  String? description;
  dynamic offerPrice;
  bool? isOffer;
  String? productRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['parts_Cat'] = partsCat;
    map['part_image'] = partImage;
    map['v_brand'] = vBrand;
    map['v_category'] = vCategory;
    map['price'] = price;
    map['parts_name'] = partsName;
    map['description'] = description;
    map['offer_price'] = offerPrice;
    map['is_offer'] = isOffer;
    map['product_rating'] = productRating;
    return map;
  }

}