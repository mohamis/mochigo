// ignore_for_file: always_specify_types

class MochiModel {
  MochiModel({
    required this.name,
    required this.id,
    required this.category,
    required this.ownerId,
    required this.description,
    required this.images,
    required this.price,
  });
  factory MochiModel.fromJson(Map<String, dynamic> data, String id) {
    assert(data.isEmpty, 'Mochi Data cannot be null!');
    return MochiModel(
      name: data['name'],
      id: id,
      category: data['category'],
      ownerId: data['ownerId'],
      description: data['description'],
      images: data['images'],
      price: data['price'],
    );
  }
  late String name;
  late String id;
  late String category;
  late String ownerId;
  late String description;
  late String images;
  late double price;

  Map<String, dynamic> toJson(MochiModel mochiData) {
    return {
      'name': mochiData.name,
      'id': mochiData.id,
      'category': mochiData.category,
      'ownerId': mochiData.ownerId,
      'description': mochiData.description,
      'images': mochiData.images,
      'price': mochiData.price,
    };
  }
}

class MochiOrder {
  MochiOrder({
    required this.name,
    required this.ownerId,
    required this.items,
    required this.orderStatus,
    required this.price,
  });
  factory MochiOrder.fromJson(Map<String, dynamic> data, String id) {
    assert(data.isEmpty, 'Mochi Order cannot be null!');
    return MochiOrder(
      name: data['name'],
      ownerId: data['ownerId'],
      items: data['items'],
      orderStatus: data['orderStatus'],
      price: data['price'],
    );
  }
  late String name;
  late String ownerId;
  late double items;
  late String orderStatus;
  late double price;

  Map<String, dynamic> toJson(MochiOrder mochiData) {
    return {
      'name': mochiData.name,
      'ownerId': mochiData.ownerId,
      'items': mochiData.items,
      'orderStatus': mochiData.orderStatus,
      'totalPrice': mochiData.price,
    };
  }
}
