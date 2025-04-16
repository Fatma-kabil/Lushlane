import 'package:bloc/bloc.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';

class CartCubit extends Cubit<Map<String, dynamic>> {
  CartCubit() : super({'items': [], 'totalPrice': 0.0, 'itemCount': 0});

  // إضافة عنصر إلى السلة
  void addToCart(PotsModel pot) {
    // إضافة العنصر إلى السلة حتى لو كان موجودًا بالفعل
    List<PotsModel> currentItems = List.from(state['items']);
    currentItems.add(pot); // إضافة العنصر دون التحقق من وجوده مسبقًا

    emit({
      'items': currentItems,
      'totalPrice': currentItems.fold(0.0, (sum, item) => sum + item.price),
      'itemCount': currentItems.length,
    });
  }

  // حذف عنصر من السلة
  void removeFromCart(PotsModel pot) {
    List<PotsModel> currentItems = List.from(state['items']);
    currentItems.removeWhere((item) => item.id == pot.id);

    emit({
      'items': currentItems,
      'totalPrice': currentItems.fold(0.0, (sum, item) => sum + item.price),
      'itemCount': currentItems.length,
    });
  }
}
