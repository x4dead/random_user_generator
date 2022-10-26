import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user_generator/cubit/user_cubit.dart';
import 'package:random_user_generator/screens/widgets/app_avatar.dart';
import 'package:random_user_generator/screens/widgets/icon_button.dart';
import 'package:random_user_generator/screens/widgets/default_button.dart';
import 'package:random_user_generator/screens/widgets/text_button.dart';
import 'package:random_user_generator/theme/Color/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../theme/text_style/text_styles.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

final currentIndex = ValueNotifier<int>(1);

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserColor.colorFF212121,
      body: BlocBuilder<UserCubit, UserStates>(builder: (context, state) {
        final user = state.model.results?[0];
        return ListView(
          padding: const EdgeInsets.all(50),
          children: [
            const SizedBox(height: 26),
            AppAvatar(
              url: user?.picture?.large ??
                  'https://media.istockphoto.com/vectors/profile-placeholder-image-gray-silhouette-no-photo-vector-id1016744004?k=20&m=1016744004&s=612x612&w=0&h=Z4W8y-2T0W-mQM-Sxt41CGS16bByUo4efOIJuyNBHgI=',
            ),
            const SizedBox(height: 24),
            Text(
              '${user?.name?.title ?? 'Tite'}. ${user?.name?.first ?? 'Name'} ${user?.name?.last ?? 'Surname'}',
              textAlign: TextAlign.center,
              style: UserTextStyle.w500s24,
            ),
            const SizedBox(height: 12),
            Text(
              'City: ${user?.location?.city ?? 'City'}',
              textAlign: TextAlign.center,
              style: UserTextStyle.wBolds16,
            ),
            const SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: IconButtonBorder(
                      icon: const Icon(
                        Icons.send_rounded,
                        size: 28,
                      ),
                      onPressed: () {
                        final String mail = user?.email ?? '';

                        try {
                          // String? encodeQueryParameters(
                          //     Map<String, String> params) {
                          //   return params.entries
                          //       .map((MapEntry<String, String> e) =>
                          //           '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                          //       .join('&');
                          // }

                          // ···
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: mail,
                          );

                          launchUrl(emailLaunchUri);
                        } on PlatformException catch (e) {
                          log(e.toString());
                        }
                      }),
                ),
                Expanded(
                  child: IconButtonBorder(
                    icon: const Icon(
                      Icons.location_on_outlined,
                      size: 30,
                    ),
                    onPressed: () async {
                      final String latitude =
                          user?.location?.coordinates?.latitude ?? '';
                      final String longitude =
                          user?.location?.coordinates?.longitude ?? '';

                      try {
                        await launchUrlString(
                            'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ValueListenableBuilder(
              valueListenable: currentIndex,
              builder: (context, _, __) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButtonBorder(
                        isActive: currentIndex.value == 0,
                        onPressed: () {
                          currentIndex.value = 0;
                        },
                        title: 'Men',
                      ),
                    ),
                    Expanded(
                      child: TextButtonBorder(
                        isActive: currentIndex.value == 1,
                        onPressed: () {
                          currentIndex.value = 1;
                        },
                        title: 'Both',
                      ),
                    ),
                    Expanded(
                      child: TextButtonBorder(
                        isActive: currentIndex.value == 2,
                        onPressed: () {
                          currentIndex.value = 2;
                        },
                        title: 'Women',
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
            Text('1 user session generator',
                textAlign: TextAlign.center,
                style: UserTextStyle.w400s15_3.copyWith(fontSize: 18)),
            const SizedBox(height: 24),
            DefaultButton(
              isLoading: state is LoadingState,
              onPressed: () {
                BlocProvider.of<UserCubit>(context)
                    .getRandomUser(mode: getApiMode);
              },
            ),
            const SizedBox(height: 24),
            ValueListenableBuilder(
              valueListenable: currentIndex,
              builder: (context, _, __) {
                return Text('$getMode mode',
                    textAlign: TextAlign.center,
                    style: UserTextStyle.w400s15_3);
              },
            ),
          ],
        );
      }),
    );
  }

  String get getApiMode {
    String value = '';
    switch (currentIndex.value) {
      case 0:
        value = 'male';
        break;
      case 1:
        value = 'both';
        break;
      case 2:
        value = 'female';
        break;
    }
    return value;
  }

  String get getMode {
    String value = '';
    switch (currentIndex.value) {
      case 0:
        value = 'Men';
        break;
      case 1:
        value = 'Both';
        break;
      case 2:
        value = 'Women';
        break;
    }
    return value;
  }

  @override
  void dispose() {
    currentIndex.dispose();
    super.dispose();
  }
}
