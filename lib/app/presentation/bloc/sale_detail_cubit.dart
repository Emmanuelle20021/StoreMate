import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/sale_detail.dart';

class SaleDetailCubit extends Cubit<List<SaleDetail>> {
  SaleDetailCubit() : super([]);

  void changeDetails(List<SaleDetail> details) {
    emit(details);
  }
}
