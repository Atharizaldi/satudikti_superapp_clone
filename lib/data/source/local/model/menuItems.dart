import 'dart:convert';

class MenuItems {
  final String menuName;
  final String? menuNameFromAPI;
  final String menuImage;
  final double imageScale;

  MenuItems({
    required this.menuName,
    this.menuNameFromAPI,
    this.menuImage = 'assets/default.png',
    this.imageScale = 2.7,
  });

  factory MenuItems.fromJson(Map<String, dynamic> jsonData) {
    return MenuItems(
        menuName: jsonData['menuName'],
        menuImage: jsonData['menuImage'],
        imageScale: jsonData['imageScale']);
  }

  static Map<String, dynamic> toMap(MenuItems menuItems) {
    return {
      'menuName': menuItems.menuName,
      'menuImage': menuItems.menuImage,
      'imageScale': menuItems.imageScale,
    };
  }

  static String encode(List<MenuItems> listMenu) {
    return json.encode(listMenu
        .map<Map<String, dynamic>>((menu) => MenuItems.toMap(menu))
        .toList());
  }

  static List<MenuItems> decode(String stringListMenu) {
    return (json.decode(stringListMenu) as List<dynamic>)
        .map((rawMenu) => MenuItems.fromJson(rawMenu))
        .toList();
  }
}
