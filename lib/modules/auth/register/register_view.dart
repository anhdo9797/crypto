import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/auth/register/register.dart';
import 'package:flutter_boiler/modules/base/base.dart';
import 'package:flutter_boiler/share/constants/app_type.dart';
import 'package:flutter_boiler/share/utils/app_localizations.dart';
import 'package:flutter_boiler/share/utils/size_config.dart';
import 'package:flutter_boiler/share/utils/utils.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      vmBuilder: (_) => RegisterViewModel(),
      builder: _buildBodyView,
    );
  }

  Widget _buildBodyView(BuildContext context, RegisterViewModel viewModel) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ContainerWidget(
            child: SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppLogo(size: 150),
                    _buildInputForm(context, viewModel),
                    Text(
                      'Flutter MVVM boiler: 1.0.0',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1!,
                    )
                  ]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputForm(BuildContext context, RegisterViewModel viewModel) {
    final t = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextFieldWidget(
          textController: viewModel.emailController,
          label: "Email",
          validator: (value) {
            final validation = AppValidator.email(value);
            if (validation != null) {
              return t.translate(validation);
            }
            return null;
          },
        ),
        const Space(),
        TextFieldWidget(
          textController: viewModel.passwordController,
          label: t.translate('password'),
          isObscure: true,
        ),
        const Space(),
        TextFieldWidget(
          textController: viewModel.passwordController,
          label: t.translate('confirm_password'),
          isObscure: true,
        ),
        Space(height: SizeConfig().getHeightRatio(80)),
        ButtonWidget(onPressed: (() => {}), label: t.translate('register')),
        const Space(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              t.translate('have_account'),
              style: Theme.of(context).textTheme.bodyText1!,
            ),
            ButtonWidget(
              onPressed: () => GoRouter.of(context).pop(),
              label: t.translate('login'),
              type: ButtonType.link,
            ),
          ],
        )
      ],
    );
  }
}
