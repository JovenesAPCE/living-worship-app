
import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';

class WorkshopSelector extends StatelessWidget {
  final String title;
  final int select;
  final List<String> selects;
  final ValueChanged<int> onChanged;
  final VoidCallback onPressed;
  final String? errorText;
  const WorkshopSelector({super.key,
    required this.title,
    required this.selects,
    required this.onChanged,
    required this.onPressed,
    this.select = 0,
    this.errorText, // <-- nuevo
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  labelText: title,
                  errorText: errorText,
                  labelStyle: TextStyle(
                      color: AppColor.textGrey
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.lineGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                isEmpty: false,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: select,
                    isExpanded: true,
                    items: List.generate( selects.length ,(index){
                      var select = selects[index];
                      return DropdownMenuItem(
                        value: index,
                        child: Text(select),
                      );
                    }),
                    style: TextStyle(
                        color: Colors.black

                    ),
                    onChanged: (value) {
                      onChanged.call(value??0);
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              onPressed.call();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.blueLight,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('   ELEGIR   ',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: AppFont.fontTwo
              ),
            ),
          ),
        ),
      ],
    );
  }
}
