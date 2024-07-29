import 'dart:convert';

// ignore: non_constant_identifier_names
List<Model> FromJson(String str) =>
    List<Model>.from(json.decode(str).map((x) => Model.fromJson(x)));

class Model {
  final String type;
  final String title;
  final List<Content>? contents;
  final String id;
  final String? imageUrl;

  Model({
    required this.type,
    required this.title,
    this.contents,
    required this.id,
    this.imageUrl,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        type: json["type"],
        title: json["title"],
        contents: json["contents"] == null
            ? []
            : List<Content>.from(
                json["contents"]!.map((x) => Content.fromJson(x))),
        id: json["id"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "contents": contents == null
            ? []
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
        "id": id,
        "image_url": imageUrl,
      };
}

class Content {
  final String? title;
  final String? imageUrl;
  final String? sku;
  final String? productName;
  final String? productImage;
  final int? productRating;
  final String? actualPrice;
  final String? offerPrice;
  final String? discount;

  Content({
    this.title,
    this.imageUrl,
    this.sku,
    this.productName,
    this.productImage,
    this.productRating,
    this.actualPrice,
    this.offerPrice,
    this.discount,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      title: json["title"],
      imageUrl: json["image_url"],
      sku: json["sku"],
      productName: json["product_name"],
      productImage: json["product_image"],
      productRating: json["product_rating"],
      actualPrice: json["actual_price"],
      offerPrice: json["offer_price"],
      discount: json["discount"],
    );
  }
  Map<String, dynamic> toJson() => {
        "title": title,
        "image_url": imageUrl,
        "sku": sku,
        "product_name": productName,
        "product_image": productImage,
        "product_rating": productRating,
        "actual_price": actualPrice,
        "offer_price": offerPrice,
        "discount": discount,
      };
}