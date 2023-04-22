import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smartpay_mobile/screens/auth/otp_verification_screen.dart';
import 'package:smartpay_mobile/screens/auth/sign_in.dart';
import 'package:smartpay_mobile/utils/app_colors.dart';
import 'package:smartpay_mobile/utils/app_widgets/back_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/padded.dart';
import 'package:smartpay_mobile/utils/app_widgets/text_field.dart';
import 'package:smartpay_mobile/utils/constants.dart';

import '../../providers/authetication_provider.dart';
import '../../utils/app_widgets/main_button.dart';
import '../../utils/app_widgets/text_button.dart';
import '../../utils/dimensions.dart';
import '../../utils/routes_navigator.dart';

class SignUpScreen extends StatefulHookWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpEmailFormKey = GlobalKey<FormState>();

  void changeValue(WidgetRef ref, bool newValue) {
    ref.read(emaillCheckingButtonProvider.notifier).update((state) => newValue);
  }

  @override
  Widget build(BuildContext context) {
    var emailTextController = useTextEditingController();
    var isActive = useState(false);

    return Scaffold(
      backgroundColor: kWHTCOLOUR,
      body: SingleChildScrollView(
        child: Padded(
          child: Form(
            key: signUpEmailFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                yMargin(52),
                const SmartPayBackButton(),
                yMargin(30),
                Text.rich(
                  TextSpan(
                    text: 'Create a ',
                    children: [
                      TextSpan(
                        text: 'Smartpay\n',
                        style: kTextStyleCustom(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: kSECCOLOUR,
                        ),
                      ),
                      const TextSpan(text: 'account')
                    ],
                    style: kTextStyleCustom(
                        fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
                yMargin(32),
                SmartPayTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  onChange: (value) {
                    if (value.isEmpty) {
                      isActive.value = false;
                    } else {
                      isActive.value = true;
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                yMargin(24),
                Consumer(builder: (context, ref, child) {
                  final isItLoading = ref.watch(emaillCheckingButtonProvider);

                  return !isItLoading
                      ? SmartPayMainButton(
                          text: 'Sign Up',
                          backgroundColor: isActive.value
                              ? kBLKCOLOUR
                              : kBLKCOLOUR.withOpacity(0.7),
                          onTap: () async {
                            if (signUpEmailFormKey.currentState!.validate() &
                                    isActive.value ==
                                true) {
                              changeValue(ref, true);
                              final action = await ref
                                  .read(emaillCheckingProvider.notifier)
                                  .getEmailToken(
                                      emailTextController.value.text);
                              if (action == true) {
                                // ignore: use_build_context_synchronously
                                RouteNavigators.route(
                                  context,
                                  OtpVerificationScreen(
                                    email: kHideEmail(
                                        emailTextController.value.text),
                                  ),
                                );
                              }
                              print(action);

                              changeValue(ref, false);
                              // final action = ref.read(authRepositoryProvider);
                              // print(emailTextController.value.text);
                              // final response =
                              //     await RepositoryProviderCalls.getEmailToken(
                              //         action, emailTextController.value.text);
                              // print(response);
                              // RouteNavigators.route(
                              //   context,
                              //   OtpVerificationScreen(
                              //     email: kHideEmail(emailTextController.value.text),
                              //   ),
                              // );
                            }
                          },
                        )
                      : const LoadingWidget();
                }),
                yMargin(32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: getScreenWidth(142),
                      child: Divider(
                        color: kLIGHTINACTIVE,
                        thickness: getScreenHeight(0.5),
                      ),
                    ),
                    Text(
                      'OR',
                      style: kTextStyleCustom(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kLightGray),
                    ),
                    SizedBox(
                      width: getScreenWidth(142),
                      child: Divider(
                        color: kLIGHTINACTIVE,
                        thickness: getScreenHeight(0.7),
                      ),
                    ),
                  ],
                ),
                yMargin(34),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            getScreenHeight(16),
                          ),
                          border: Border.all(style: BorderStyle.solid),
                        ),
                        height: getScreenHeight(56),
                        width: getScreenWidth(155),
                        child: Image.asset('assets/images/google.png'),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            getScreenHeight(16),
                          ),
                          border: Border.all(style: BorderStyle.solid),
                        ),
                        height: getScreenHeight(56),
                        width: getScreenWidth(155),
                        child: Image.asset('assets/images/apple.png'),
                      ),
                    ),
                  ],
                ),
                yMargin(117),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: kTextStyleCustom(
                        fontSize: getScreenHeight(14),
                        fontWeight: FontWeight.w400,
                        color: kLightGray,
                      ),
                    ),
                    SmartPayTextButton(
                      onTap: () {
                        RouteNavigators.routeNoWayHome(
                          context,
                          const SignInScreen(),
                        );
                      },
                      title: 'Sign In',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: kSECCOLOUR,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: getScreenHeight(30),
        width: getScreenWidth(30),
        child: const CircularProgressIndicator.adaptive(
          backgroundColor: kPRYCOLOUR,
        ),
      ),
    );
  }
}
