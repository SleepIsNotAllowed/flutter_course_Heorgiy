class PredefinedShopItemsList {
  static const int length = 9;
  static final List names = [
    "Mens Citizen Navihawk AT Alarm Chronograph Radio Controlled Eco-Drive Watch",
    "Mens Citizen Endeavour Watch",
    "Polar Ignite 2 Fitness Smartwatch",
    "Polar Unite Fitness Smartwatch",
    "Polar Vantage M2 Running Smartwatch",
    "Gents Tommy Hilfiger Cooper Watch 1791513",
    "Gents Jack Wills Overland Watch JW012TNS",
    "Slipstream Aero Chronograph SL107521",
    "Armani Exchange Watch AX1335",
  ];
  static final images = List.generate(
    9,
    (i) => 'assets/shop_items_images/image$i.jpg',
  );
  static final List prices = [100, 150, 200, 100, 70, 300, 120, 130, 350];
}
