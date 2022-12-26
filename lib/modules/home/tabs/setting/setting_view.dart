import 'package:flutter/material.dart';
import 'package:s_crypto/data/models/language_model.dart';
import 'package:s_crypto/data/models/user.dart';
import 'package:s_crypto/modules/base/base.dart';
import 'package:s_crypto/modules/home/tabs/setting/setting_view_model.dart';
import 'package:s_crypto/providers/provider.dart';
import 'package:s_crypto/routes/routes.dart';
import 'package:s_crypto/share/constants/constants.dart';
import 'package:s_crypto/share/services/user_manager.dart';
import 'package:s_crypto/share/utils/app_localizations.dart';
import 'package:s_crypto/share/utils/size_config.dart';
import 'package:s_crypto/share/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingViewModel>(
        vmBuilder: (_) => SettingViewModel(_),
        builder: (context, viewModel) {
          final size = SizeConfig();
          final t = AppLocalizations.of(context);
          ColorScheme colorScheme = Theme.of(context).colorScheme;
          LangProvider langProvider =
              Provider.of<LangProvider>(context, listen: false);

          return Scaffold(
            body: ContainerWidget(
                padding: 0,
                child: Column(
                  children: [
                    LinearContainer(
                      type: LinearType.primary,
                      borderRadius: BorderRadius.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimension.padding,
                          vertical: AppDimension.padding * 2,
                        ),
                        child: SafeArea(
                          minimum: const EdgeInsets.all(AppDimension.padding),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildUserInfo(),
                                  IconButton(
                                      onPressed: viewModel.logout,
                                      icon: const Icon(
                                        Icons.logout_rounded,
                                        color: textDefault,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _buildItem(
                      context,
                      label: t.translate("my_profile"),
                      icon: Icons.person,
                    ),
                    _buildItem(
                      context,
                      label: t.translate("messenger"),
                      icon: Icons.message_outlined,
                    ),
                    _buildItem(
                      context,
                      label: t.translate("support"),
                      icon: Icons.support_rounded,
                    ),
                    InkWell(
                      onTap: () =>
                          AppRouter.routes.goNamed(APP_PAGE.feedback.toName),
                      child: _buildItem(
                        context,
                        label: "Feedback",
                        icon: Icons.feedback_rounded,
                      ),
                    ),
                    _buildItem(
                      context,
                      label: t.translate("is_dark"),
                      icon: Icons.dark_mode,
                      trailing: Switch(
                        value: context.watch<ThemeProvider>().isDark,
                        activeColor: colorScheme.primary,
                        onChanged: context.read<ThemeProvider>().onChangeTheme,
                      ),
                    ),
                    _buildItem(
                      context,
                      label: t.translate("language"),
                      icon: Icons.language,
                      trailing: DropdownButtonHideUnderline(
                        child: DropdownButton<Language>(
                          items: AppLanguage.supportedLanguages
                              .map<DropdownMenuItem<Language>>((lang) {
                            return DropdownMenuItem<Language>(
                              value: lang,
                              child: Text(lang.language ?? ""),
                            );
                          }).toList(),
                          value: langProvider.getLanguage(),
                          onChanged: (value) =>
                              langProvider.changeLanguage(value!.locale ?? ""),
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  _buildUserInfo() {
    return StreamBuilder<UserModel>(
        stream: UserManager.user.stream,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final user = snapshot.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageWidget(
                user?.avatar ?? "",
                color: Colors.white,
                shape: BoxShape.circle,
                width: 100,
                height: 100,
              ),
              const Space(),

              //username
              Text(
                "${user?.firstName} ${user?.lastName}",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: textDefault),
              ),
              Text(
                "${user?.email}",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: textDefault),
              )
            ],
          );
        }));
  }

  Widget _buildItem(
    BuildContext context, {
    required String label,
    required IconData icon,
    Widget trailing = const Icon(Icons.arrow_forward_ios_rounded),
  }) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppDimension.padding / 2, horizontal: AppDimension.padding),
      child: LinearContainer(
        borderRadius: BorderRadius.circular(AppDimension.borderRadius * 2),
        colors: [
          colorScheme.surface.withOpacity(0.8),
          colorScheme.surface,
        ],
        child: ListTile(
          leading: Icon(icon),
          title: Text(label),
          trailing: trailing,
        ),
      ),
    );
  }
}
