import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sip_social/app/locator.dart';
import 'package:sip_social/const/enums/dialogs_enum.dart';
import 'package:sip_social/main.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogEnum.saveOrNot: (context, sheetRequest, completer) => LogoutDialog(request: sheetRequest, completer: completer),
    DialogEnum.confirmation: (context, sheetRequest, completer) => ConfirmationDialog(request: sheetRequest, completer: completer),
    DialogEnum.permission: (context, sheetRequest, completer) => PermissionDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class LogoutDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  LogoutDialog({required this.request, required this.completer});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 13, top: 13, right: 21, bottom: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.power_settings_new, color: $styles.colors.greyMedium),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        request.title ?? "Are you sure",
                        style: TextStyle(
                          fontSize: 21,
                          color: $styles.colors.greyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    request.description ?? "Are you sure you want to logout?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0,
                      ),
                      onPressed: () {
                        DialogResponse _dialogResponse = DialogResponse(confirmed: false);
                        completer(_dialogResponse);
                      },
                      child: Text(
                        'NO',
                        style: TextStyle(color: $styles.colors.greyMedium, fontSize: 18.0),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: $styles.colors.greyMedium,
                          elevation: 0,
                        ),
                        onPressed: () async {
                          DialogResponse _dialogResponse = DialogResponse(confirmed: true);
                          completer(_dialogResponse);
                        },
                        child: Text(
                          'YES',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        )),
                    const SizedBox(
                      width: 17,
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

class MoneyTransferredDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const MoneyTransferredDialog({super.key, required this.request, required this.completer});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        color: $styles.colors.black,
        child: Padding(
            padding: const EdgeInsets.only(left: 22, top: 22, right: 22, bottom: 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 100, height: 100, child: SvgPicture.asset('assets/icons/payment_success.svg')),

                const Text(
                  "Money Transferred",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                ),

                const Text(
                  "The amount will be transfer in 3-5 days in linked bank account.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // CustomButton(
                //   "Check Status",
                //   height: 46,
                //   buttonPressed: () {
                //     completer(DialogResponse(confirmed: true));
                //   },
                // ),
                // 12.verticalSpace,
                // CustomButton(
                //   'Close',
                //   backgroundColor: Colors.transparent,
                //   height: 44,
                //   borderSide: Border.all(color: Colors.white, width: 1.w),
                //   buttonPressed: () {
                //     completer(
                //       DialogResponse(confirmed: false),
                //     );
                //   },
                // ),
              ],
            )),
      ),
    );
  }
}

class ConfirmationDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ConfirmationDialog({required this.request, required this.completer});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                request.title ?? "Are You Sure?",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14),
                child: Text(
                  request.description ?? "Are You Sure about this action",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1, color: Colors.black38),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  // Flexible(
                  //   flex: 1,
                  //   child: CustomButton(
                  //     "NO",
                  //     backgroundColor: ColorConfig.backgroundColor,
                  //     textColor: $styles.colors.black,
                  //     height: 42,
                  //     buttonTextStyle: TextStyle(
                  //       fontSize: 16,
                  //     ),
                  //     buttonPressed: () {
                  //       completer(DialogResponse(confirmed: false));
                  //     },
                  //   ),
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Flexible(
                  //   flex: 1,
                  //   child: CustomButton(
                  //     "CONFIRM",
                  //     backgroundColor: ColorConfig.secondaryColor,
                  //     height: 42,
                  //     buttonTextStyle: TextStyle(
                  //       fontSize: 16,
                  //     ),
                  //     buttonPressed: () {
                  //       completer(DialogResponse(confirmed: true));
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PermissionDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  PermissionDialog({required this.request, required this.completer});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 13, top: 13, right: 21, bottom: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Permission Required',
                        style: TextStyle(fontSize: 21, color: $styles.colors.greyMedium),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    request.description ?? "Please Grant ",
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 0),
                      onPressed: () {
                        DialogResponse _dialogResponse = DialogResponse(confirmed: false);
                        completer(_dialogResponse);
                      },
                      child: Text(
                        'NO',
                        style: TextStyle(color: $styles.colors.greyMedium, fontSize: 18.0),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: $styles.colors.greyMedium, elevation: 0),
                      onPressed: () async {
                        DialogResponse _dialogResponse = DialogResponse(confirmed: true);
                        completer(_dialogResponse);
                      },
                      child: Text(
                        'YES',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    const SizedBox(
                      width: 17,
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
