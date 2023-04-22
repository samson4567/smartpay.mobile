import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smartpay_mobile/utils/app_widgets/padded.dart';
import 'package:smartpay_mobile/utils/constants.dart';

class HomeScreen extends StatefulHookWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padded(
        child: Center(
          child: Text(
            'Thanks for going through our app flow',
            style: kTextStyleCustom(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
