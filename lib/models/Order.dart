import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/product.dart';

class OrderCustom {
  String? id;
  String? uid;
  String? createAt;
  String? total;
  List<Cart> listItemCart;
  String? address;
  String? status;


  OrderCustom({this.id, this.uid, this.createAt, this.total, required this.listItemCart, this.address,
      this.status});


  Future saveOrder() async {
    
  }

  List<int> convertListItemToUpload() {
    List<int> result= [];
    listItemCart.forEach((element) {
      result.add(element.product.id);
      result.add(element.numOfItem);
    });
    return result;
  }

}
