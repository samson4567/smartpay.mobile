import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smartpay_mobile/screens/auth/create_pin_screen.dart';
import 'package:smartpay_mobile/screens/auth/sign_up_screen.dart';
import 'package:smartpay_mobile/screens/auth/widget/profile_setup_model.dart';
import 'package:smartpay_mobile/utils/app_colors.dart';
import 'package:smartpay_mobile/utils/app_widgets/back_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/main_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/padded.dart';
import 'package:smartpay_mobile/utils/app_widgets/text_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/text_field.dart';
import 'package:smartpay_mobile/utils/constants.dart';
import 'package:smartpay_mobile/utils/routes_navigator.dart';

import '../../providers/authetication_provider.dart';
import '../../utils/dimensions.dart';
import 'widget/profile_setup_widget.dart';

class ProfileSetUpScreen extends StatefulHookWidget {
  const ProfileSetUpScreen({super.key, required this.email});
  final String email;

  @override
  State<ProfileSetUpScreen> createState() => _ProfileSetUpScreenState();
}

class _ProfileSetUpScreenState extends State<ProfileSetUpScreen> {
  final profileDetailsFormKey = GlobalKey<FormState>();
  void changeValue(WidgetRef ref, bool newValue) {
    ref
        .read(registerCheckingButtonProvider.notifier)
        .update((state) => newValue);
  }

  @override
  Widget build(BuildContext context) {
    var fullName = useTextEditingController();
    var username = useTextEditingController();
    var country = useTextEditingController();
    var countryCode = useState('');
    var password = useTextEditingController();
    var isSelected = useState(false);
    var isPasswordVisible = useState(true);
    var isButtonActive = useState(false);
    var selectedIndexNumber = useState(-1);
    return Scaffold(
      backgroundColor: kWHTCOLOUR,
      body: Form(
        key: profileDetailsFormKey,
        child: SingleChildScrollView(
          child: Padded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                yMargin(52),
                const SmartPayBackButton(),
                yMargin(30),
                Text.rich(
                  TextSpan(
                    text: 'Hey there! tell us a bit about',
                    children: [
                      TextSpan(
                          text: ' yourself',
                          style: kTextStyleCustom(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: kSECCOLOUR)),
                    ],
                    style: kTextStyleCustom(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                yMargin(32),
                SmartPayTextField(
                  controller: fullName,
                  hintText: 'Full name',
                  onChange: (value) {
                    if (value.isNotEmpty &&
                        username.value.text.isNotEmpty &&
                        country.value.text.isNotEmpty &&
                        password.value.text.isNotEmpty) {
                      isButtonActive.value = true;
                    } else {
                      isButtonActive.value = false;
                    }
                  },
                ),
                yMargin(16),
                SmartPayTextField(
                  controller: username,
                  hintText: 'Username',
                  onChange: (value) {
                    if (value.isNotEmpty &&
                        fullName.value.text.isNotEmpty &&
                        country.value.text.isNotEmpty &&
                        password.value.text.isNotEmpty) {
                      isButtonActive.value = true;
                    } else {
                      isButtonActive.value = false;
                    }
                  },
                ),
                yMargin(16),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: kTransperent,
                      isScrollControlled: true,
                      builder: (context) {
                        final searchTextFeild = TextEditingController();
                        return Container(
                          height: getScreenHeight(617),
                          decoration: BoxDecoration(
                            color: kWHTCOLOUR,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(getScreenHeight(40)),
                              topRight: Radius.circular(
                                getScreenHeight(40),
                              ),
                            ),
                          ),
                          child: Padded(
                            child: Column(
                              children: [
                                yMargin(32),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: getScreenWidth(258),
                                      child: SmartPayTextField(
                                        controller: searchTextFeild,
                                        hintText: 'Search',
                                        icon: Padding(
                                          padding: EdgeInsets.all(
                                              getScreenHeight(16)),
                                          child: SvgPicture.asset(
                                              'assets/svgs/Search.svg'),
                                        ),
                                      ),
                                    ),
                                    SmartPayTextButton(
                                      onTap: () {
                                        RouteNavigators.pop(context);
                                      },
                                      title: 'Cancel',
                                      fontSize: getScreenHeight(16),
                                      fontWeight: FontWeight.w700,
                                    )
                                  ],
                                ),
                                yMargin(24),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: listOfAllUsedCountries.length,
                                    itemBuilder: (context, index) {
                                      int selectIndex =
                                          selectedIndexNumber.value;
                                      CountryListModel dataToUse =
                                          listOfAllUsedCountries[index];
                                      return CountryListWidget(
                                        countryName: dataToUse.counrtyName,
                                        countryAbbrevation:
                                            dataToUse.countryAbbrevtion,
                                        imagePath: dataToUse.imagePath,
                                        currentIndex: index,
                                        selectedIndex: selectIndex,
                                        onTap: () {
                                          selectedIndexNumber.value = index;
                                          country.text = dataToUse.counrtyName;
                                          countryCode.value =
                                              dataToUse.countryAbbrevtion;
                                          isSelected.value = true;
                                          RouteNavigators.pop(context);
                                        },
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: SmartPayTextField(
                    controller: country,
                    hintText: 'Select Country',
                    icon: (isSelected.value == true)
                        ? Padding(
                            padding: EdgeInsets.all(getScreenHeight(10)),
                            child: SvgPicture.asset(listOfAllUsedCountries[
                                    selectedIndexNumber.value]
                                .imagePath),
                          )
                        : null,
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(getScreenHeight(15)),
                      child: SvgPicture.asset('assets/svgs/arrowdown.svg'),
                    ),
                    enable: false,
                  ),
                ),
                yMargin(16),
                SmartPayTextField(
                  controller: password,
                  obscureText: isPasswordVisible.value,
                  hintText: 'Password',
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Password is minimum of 6 characters';
                    } else {
                      return null;
                    }
                  },
                  onChange: (value) {
                    if (value.isNotEmpty &&
                        username.value.text.isNotEmpty &&
                        country.value.text.isNotEmpty &&
                        password.value.text.isNotEmpty) {
                      isButtonActive.value = true;
                    } else {
                      isButtonActive.value = false;
                    }
                  },
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(getScreenHeight(12)),
                    child: InkWell(
                      onTap: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
                      child: SvgPicture.asset(
                        isPasswordVisible.value
                            ? 'assets/svgs/eye-off.svg'
                            : 'assets/svgs/eyevisible.svg',
                      ),
                    ),
                  ),
                ),
                yMargin(24),
                Consumer(builder: (context, ref, child) {
                  final isItLoading =
                      ref.watch(verifyEmaillCheckingButtonProvider);
                  return !isItLoading
                      ? SmartPayMainButton(
                          text: 'Continue',
                          backgroundColor: isButtonActive.value
                              ? kBLKCOLOUR
                              : kINACTIVECOLOR,
                          onTap: () async {
                            if (profileDetailsFormKey.currentState!
                                    .validate() &&
                                isButtonActive.value == true) {
                              changeValue(ref, true);
                              //The api response was giving error 422, a database error, so to make it flow without the call.
                              RouteNavigators.route(
                                context,
                                const CreatePinScreen(),
                              );
                              final action = await ref
                                  .read(emaillCheckingProvider.notifier)
                                  .register(
                                    widget.email,
                                    password.value.text,
                                    fullName.value.text,
                                    username.value.text,
                                    country.value.text,
                                  );
                              if (action == true) {
                                // ignore: use_build_context_synchronously
                                RouteNavigators.route(
                                  context,
                                  const CreatePinScreen(),
                                );
                              }
                              print(action);

                              changeValue(ref, false);
                            }
                          },
                        )
                      : const LoadingWidget();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
