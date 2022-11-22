import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/add_wallet/add_wallet.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/share/constants/assets.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';
import '../../share/utils/utils.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class AddWalletView extends StatelessWidget {
  const AddWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AddWalletViewModel>(
      vmBuilder: (_) => AddWalletViewModel(),
      builder: (context, vm) => Scaffold(
        appBar: AppBar(
          title: Text("add wallet"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CreditCard(
                id: vm.id,
                date: vm.date,
                nameHolder: vm.name,
                bankName: "VCB",
                isFront: vm.isFront,
                cvv: vm.ccv,
              ),
              const Space(),
              TextFieldWidget(
                label: "BANK NAME",
                textController: vm.cardIdController,
                hint: "Bank Name",
                // onChanged: (S),
              ),
              const Space(),
              TextFieldWidget(
                label: "CARD ID",
                textController: vm.cardIdController,
                hint: "XXXX - XXXX ......",
                inputType: TextInputType.number,
                inputFormatters: [
                  CreditCardNumberInputFormatter(),
                  MaskedInputFormatter('####-####-####-####')
                ],
              ),
              const Space(),
              TextFieldWidget(
                label: "VALIDATE THUR",
                textController: vm.dateController,
                hint: "DD/MM",
                inputFormatters: [
                  CreditCardExpirationDateFormatter(),
                ],
              ),
              const Space(),
              TextFieldWidget(
                label: "NAME HOLDER",
                textController: vm.nameController,
                hint: "ex: John",
              ),
              const Space(),
              TextFieldWidget(
                label: "CVV",
                textController: vm.ccvController,
                hint: "CVV",
                focusNode: vm.cvvFocus,
                inputType: TextInputType.number,
                inputFormatters: [
                  CreditCardCvcInputFormatter(),
                ],
              ),
              const Space(height: 32),
              ButtonWidget(
                onPressed: () {},
                label: "ADD CreditCard",
              )
            ],
          ),
        ),
      ),
    );
  }
}
