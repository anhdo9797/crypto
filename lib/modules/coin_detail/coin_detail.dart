import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/modules/coin_detail/coin_detail_view_model.dart';

class CoinDetailView extends StatelessWidget {
  const CoinDetailView({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return BaseView<CoinDetailViewModel>(
        vmBuilder: (context) => CoinDetailViewModel(id), builder: _buildBody);
  }

  Widget _buildBody(BuildContext context, CoinDetailViewModel vm) {
    return Scaffold(
        appBar: AppBar(title: Text(id)),
        body: SingleChildScrollView(
          child: Column(),
        ));
  }
}
