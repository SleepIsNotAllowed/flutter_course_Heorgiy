import 'package:online_shop_flutter_course/pages/shop_home_page/widgets/shop_item_browsing_grid/grid_components/grid_item.dart';
import 'package:online_shop_flutter_course/util/shop_data_management/grid_item_data_holder.dart';

class DataManager {
  int totalPriceCount = 0;
  String searched = '';
  List<GridItem> itemsList = [];
  List<GridItemDataHolder> itemsData = [];
}
