import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/password_cubit.dart';
import '../../constant.dart';
import '../../../cubit/auth_cubit.dart';
import '../../../cubit/state/cubit_state.dart';
import '../../../utils/custom_route.dart';
import '../../widgets/custom_checkbox.dart';
import '../../widgets/profile/auth_widgets.dart';
import '../../widgets/snackbar.dart';
import 'login_page.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget with AuthWidgets {
  RegisterPage({super.key});

  Map<String, ValueNotifier<TextEditingValue>> controller = {
    "name": TextEditingController(),
    "email": TextEditingController(),
    "password": TextEditingController(),
  };

  bool isShown = false;

  void _navigateToLoginPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      CustomRoute.createRoute(
        destination: LoginPage(),
        begin: const Offset(-1.0, 0.0),
      ),
    );
  }

  List<Widget> form(BuildContext context) {
    return [
      TextField(
        decoration: const InputDecoration(
          labelText: "Nama",
          hintText: "Nama",
        ),
        controller: controller["name"] as TextEditingController,
      ),
      const SizedBox(height: 24),
      TextField(
        decoration: const InputDecoration(
          labelText: "Email",
          hintText: "Email",
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

  Widget registerButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocConsumer<AuthCubit, CubitState>(
        listener: (_, state) {
          if (state is AuthSuccess) {
            _navigateToLoginPage(context);
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
              context.read<AuthCubit>().register(
                    controller["name"]!.value.text,
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
              "Daftar Akun",
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

  Widget loginSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Sudah memiliki akun?"),
        TextButton(
          onPressed: () {
            _navigateToLoginPage(context);
          },
          style: TextButton.styleFrom(
            foregroundColor: greenMainColor,
          ),
          child: const Text(
            "Login",
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
                backgroundText: "REGISTERREGISTER",
                welcomeText: "Siap Untuk Memulai? Daftar Sekarang!",
                description:
                    "Satu langkah lagi untuk memulai, Lengkapi data diri Anda",
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
                    registerButton(context),
                    const SizedBox(height: 16),
                    loginSection(context),
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
