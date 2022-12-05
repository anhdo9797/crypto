import 'package:flutter/material.dart';
import 'package:s_crypto/modules/add_wallet/add_wallet.dart';
import 'package:s_crypto/modules/base/base.dart';
import 'package:s_crypto/share/widgets/widgets.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class AddWalletView extends StatelessWidget {
  const AddWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AddWalletViewModel>(
      vmBuilder: (_) => AddWalletViewModel(),
      builder: (context, vm) => Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CreditCard(
                id: vm.id,
                date: vm.date,
                nameHolder: vm.name,
                bankName: vm.bankName,
                isFront: vm.isFront,
                cvv: vm.cvv,
              ),
              const Space(),
              TextFieldWidget(
                label: "BANK NAME",
                textController: vm.bankNameController,
                hint: "Bank Name",
                onChanged: vm.onChangeBankName,
              ),
              const Space(),
              TextFieldWidget(
                label: "CARD ID",
                textController: vm.cardIdController,
                hint: "XXXX - XXXX ......",
                inputType: TextInputType.number,
                onChanged: vm.onChangeCardId,
                inputFormatters: [
                  CreditCardNumberInputFormatter(),
                ],
              ),
              const Space(),
              TextFieldWidget(
                label: "VALIDATE THUR",
                textController: vm.dateController,
                hint: "DD/MM",
                onChanged: vm.onChangeDate,
                inputFormatters: [
                  CreditCardExpirationDateFormatter(),
                ],
              ),
              const Space(),
              TextFieldWidget(
                label: "NAME HOLDER",
                textController: vm.nameController,
                hint: "ex: John",
                onChanged: vm.onChangeName,
              ),
              const Space(),
              TextFieldWidget(
                label: "CVV",
                textController: vm.ccvController,
                hint: "CVV",
                focusNode: vm.cvvFocus,
                inputType: TextInputType.number,
                onChanged: vm.onChangeCvv,
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
