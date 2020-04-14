import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amuse_flutter/authentication/bloc.dart';
import 'certification.dart';
import 'bloc/bloc.dart';

class CertificationScreen extends StatelessWidget {
  CertificationScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CertificationBloc>(
        create: (context) => CertificationBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
        child: CertificationMain(),
      ),
    );
  }
}
