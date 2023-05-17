import 'package:flutter/material.dart';
import 'package:sip_social/app/locator.dart';
import 'package:sip_social/const/enums/bottom_sheet_enums.dart';
import 'package:sip_social/main.dart';
import 'package:stacked_services/stacked_services.dart';

void setUpBottomSheet() {
  final bottomSheetService = locator<BottomSheetService>();
  final builders = {
    BottomSheetEnum.basic: (context, sheetRequest, completer) => _BasicDialog(request: sheetRequest, completer: completer),
    BottomSheetEnum.error: (context, sheetRequest, completer) => _ErrorDilog(request: sheetRequest, completer: completer),
    BottomSheetEnum.noInternet: (context, sheetRequest, completer) => _NoInternetDialog(request: sheetRequest, completer: completer),
    BottomSheetEnum.pickImage: (context, sheetRequest, completer) => PickImageBottomSheet(request: sheetRequest, completer: completer),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

class PickImageBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const PickImageBottomSheet({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _BasicDialog extends StatelessWidget {
  final SheetRequest request;
  final Function(DialogResponse) completer;

  const _BasicDialog({required this.request, required this.completer});

  @override
  Widget build(BuildContext context) {
    return const Dialog(child: Text("Basic"));
  }
}

class _ErrorDilog extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const _ErrorDilog({
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? "",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            request.description ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => completer(SheetResponse(confirmed: true)),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: $styles.colors.black,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Text(
                  request.mainButtonTitle ?? "OK",
                  style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _NoInternetDialog extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const _NoInternetDialog({
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? "",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            request.description ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => completer(SheetResponse(confirmed: true)),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    request.mainButtonTitle ?? "OK",
                    style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
