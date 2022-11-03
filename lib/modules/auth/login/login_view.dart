import 'package:flutter/material.dart';
import 'package:flutter_boiler/modules/auth/auth_module.dart';
import 'package:flutter_boiler/modules/base/base_view.dart';
import 'package:flutter_boiler/providers/provider.dart';
import 'package:flutter_boiler/routes/routes.dart';
import 'package:flutter_boiler/share/constants/constants.dart';

import 'package:flutter_boiler/share/utils/utils.dart';
import 'package:flutter_boiler/share/widgets/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      vmBuilder: (_) => LoginViewModel(context),
      builder: _buildBodyView,
    );
  }

  Widget _buildBodyView(BuildContext context, LoginViewModel viewModel) {
    final themProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ContainerWidget(
            child: SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: themProvider.isDark
                              ? IconButton(
                                  onPressed: () =>
                                      themProvider.onChangeTheme(false),
                                  icon: const Icon(Icons.light_mode))
                              : IconButton(
                                  onPressed: () =>
                                      themProvider.onChangeTheme(true),
                                  icon: const Icon(Icons.dark_mode)),
                        ),
                        const AppLogo(size: 150),
                      ],
                    ),
                    _buildInputForm(context, viewModel),
                    _buildMoreLogin(context, viewModel),
                    Text(
                      "${dotenv.env['APP_NAME']}: ${dotenv.env['VERSION']}",
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

  Widget _buildInputForm(BuildContext context, LoginViewModel viewModel) {
    final t = AppLocalizations.of(context);

    return Form(
      key: viewModel.formKey,
      child: Column(
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
            validator: (value) {
              final validation = AppValidator.password(value);
              if (validation != null) {
                return t.translate(validation);
              }
              return null;
            },
          ),
          const Space(),
          ButtonWidget(
            onPressed: () =>
                GoRouter.of(context).goNamed(APP_PAGE.forgotPassword.toName),
            label: t.translate('forgot_password'),
            type: ButtonType.link,
          ),
          Space(height: SizeConfig().getHeightRatio(80)),
          ButtonWidget(
              onPressed: () => viewModel.onTapLogin(context),
              label: t.translate("login")),
          const Space(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                t.translate('none_account'),
                style: Theme.of(context).textTheme.bodyText1!,
              ),
              ButtonWidget(
                onPressed: () =>
                    GoRouter.of(context).goNamed(APP_PAGE.register.toName),
                label: t.translate('create_account'),
                type: ButtonType.link,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMoreLogin(BuildContext context, LoginViewModel viewModel) {
    final t = AppLocalizations.of(context);
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Text(t.translate('or')),
            const Expanded(child: Divider()),
          ],
        ),
        const Space(),
        Row(
          children: [
            Expanded(
                child: ButtonWidget(
              onPressed: () {},
              label: "Google",
              type: ButtonType.outline,
              icon: Image.asset(
                Assets.google,
                width: 16,
                height: 16,
              ),
              labelStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            )),
            const Space(),
            Expanded(
                child: ButtonWidget(
              onPressed: () {},
              label: "Facebook",
              type: ButtonType.secondary,
              icon: const Icon(
                Icons.facebook,
                color: AppColors.lightText,
              ),
              colors: [
                AppColors.blue,
                AppColors.blue.withOpacity(0.7),
                AppColors.blue.withOpacity(0.7),
              ],
            )),
          ],
        ),
        const Space(),
      ],
    );
  }
}
