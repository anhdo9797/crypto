import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/auth/forgot-password/forgot_password_view_model.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/share/utils/app_localizations.dart';
import 'package:flutter_boiler/share/utils/utils.dart';
import 'package:flutter_boiler/share/widgets/button.dart';
import 'package:flutter_boiler/share/widgets/container.dart';
import 'package:flutter_boiler/share/widgets/space.dart';
import 'package:flutter_boiler/share/widgets/text_field.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewModel>(
        vmBuilder: (_) => ForgotPasswordViewModel(), builder: _buildBody);
  }

  Widget _buildBody(BuildContext context, ForgotPasswordViewModel viewModel) {
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.translate('forgot_password')),
      ),
      body: ContainerWidget(
        child: Form(
          key: viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.translate("forgot_password_content")),
              const Space(),
              TextFieldWidget(
                textController: viewModel.emailController,
                validator: (val) {
                  final validation = AppValidator.email(val);
                  if (validation != null) {
                    return t.translate(validation);
                  }
                  return null;
                },
                label: "Email",
              ),
              const Space(height: 32),
              ButtonWidget(
                onPressed: viewModel.sendEmail,
                label: t.translate('reset_password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
