import 'package:d_view/d_view.dart';
import 'package:flutter/cupertino.dart';

class AccountFragment extends StatelessWidget {
  const AccountFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DView.textTitle('Account'),
    );
  }
}
