import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constant.dart';
import '../../../cubit/auth_cubit.dart';
import '../../../cubit/bottom_navbar_cubit.dart';
import '../../../cubit/password_cubit.dart';
import '../../../cubit/state/cubit_state.dart';
import '../../../utils/custom_route.dart';
import '../../widgets/custom_checkbox.dart';
import '../../widgets/profile/auth_widgets.dart';
import '../../widgets/snackbar.dart';
import 'register_page.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget with AuthWidgets {
  LoginPage({super.key});

  Map<String, ValueNotifier<TextEditingValue>> controller = {
    "email": TextEditingController(),
    "password": TextEditingController(),
  };

  bool isShown = false;

  void _navigateToMainPage(BuildContext context) {
    context.read<BottomNavbarCubit>().set(0);
    Navigator.pushReplacementNamed(context, "/main");
  }

  void _navigateToRegisterPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      CustomRoute.createRoute(
        destination: RegisterPage(),
        begin: const Offset(1.0, 0.0),
      ),
    );
  }

  List<Widget> form(BuildContext context) {
    return [
      TextField(
        decoration: const InputDecoration(
          labelText: "email",
          hintText: "email",
        ),
        controller: controller["email"] as TextEditingController,
      ),
      const SizedBox(height: 24),
      BlocBuilder<PasswordCubit, bool>(
        builder: (_, __) {
          return TextField(
            decoration: const InputDecoration(
              labelText: "Kata Sandi",
            ),
            controller: controller["password"] as TextEditingController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: !isShown,
          );
        },
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          CustomCheckbox(
            onChanged: (c) {
              context.read<PasswordCubit>().changeState();
              isShown = !isShown;
            },
          ),
          const SizedBox(width: 8),
          const Text(
            "Tampilkan Kata Sandi",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    ];
  }

  Widget loginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocConsumer<AuthCubit, CubitState>(
        listener: (_, state) {
          if (state is AuthSuccess) {
            _navigateToMainPage(context);
          } else if (state is CubitFailed) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is CubitLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ElevatedButton(
            onPressed: () {
              hideSnackbar(context);
              context.read<AuthCubit>().login(
                    controller["email"]!.value.text,
                    controller["password"]!.value.text,
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: greenMainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: const EdgeInsets.all(padding * 2),
            ),
            child: const Text(
              "Masuk",
              style: TextStyle(
                color: whiteMainColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget registerSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Belum memiliki akun?"),
        TextButton(
          onPressed: () {
            _navigateToRegisterPage(context);
          },
          style: TextButton.styleFrom(
            foregroundColor: greenMainColor,
          ),
          child: const Text(
            "Daftar",
            style: TextStyle(
              color: greenMainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              authTitleSection(
                context,
                backgroundText: "LOGIN",
                welcomeText: "Selamat Datang Kembali!",
                description: "Isi informasi login Anda untuk masuk ke akun.",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: padding * 2),
                child: Column(
                  children: [
                    const SizedBox(height: 28),
                    ...form(context),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: padding * 2),
                child: Column(
                  children: [
                    loginButton(context),
                    const SizedBox(height: 16),
                    registerSection(context),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
