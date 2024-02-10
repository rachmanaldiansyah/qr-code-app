class ProductsModel {
  String code;
  String nameProduct;
  String productId;
  int qty;

  ProductsModel({
    required this.code,
    required this.nameProduct,
    required this.productId,
    required this.qty,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        code: json["code"] ?? "-",
        nameProduct: json["name_product"] ?? "-",
        productId: json["product_id"] ?? "-",
        qty: json["qty"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name_product": nameProduct,
        "product_id": productId,
        "qty": qty,
      };
}
