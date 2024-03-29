import 'package:flutter/material.dart';
import 'package:cusipco/themedata.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
        this.width,
      this.isLoading = false,
      required this.title,
      required this.color,
      this.fontsize = 16,
      this.isdisable = false,
      required this.callBack, this.icon})
      : super(key: key);
  final bool isLoading;
  final bool isdisable;
  final String title;
  final IconData? icon;
  final Function callBack;
  final Color color;
  final double fontsize;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: isdisable ? color.withOpacity(0.5) : color,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              ThemeClass.blueColor,
              ThemeClass.blueColor3,
            ],
          ),
        ),
        width: width ?? MediaQuery.of(context).size.width,
        child: InkWell(
          onTap: () {
            if (!isdisable) {
              callBack();
            }
          },
          child: Row(
            mainAxisAlignment: (icon!= null) ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(icon!= null)  Container(),
             if(icon!= null) Icon(icon, color: Colors.white,),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: isLoading
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06,
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: fontsize,
                        ),
                      ),
              ),

             if(icon!=null)  Container(),Container(),
            ],
          ),
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: MaterialButton(
  //       minWidth: MediaQuery.of(context).size.width,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(
  //           // horizontal: 50,
  //           vertical: 12,
  //         ),
  //         child: isLoading
  //             ? SizedBox(
  //                 width: MediaQuery.of(context).size.width * 0.06,
  //                 height: MediaQuery.of(context).size.height * 0.03,
  //                 child: CircularProgressIndicator(
  //                   strokeWidth: 2.0,
  //                   color: Colors.white,
  //                 ),
  //               )
  //             : Text(
  //                 title,
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //       ),
  //       color: isdisable ? color.withOpacity(0.5) : color,
  //       onPressed: () {
  //         if (!isdisable) {
  //           callBack();
  //         }
  //       },
  //     ),
  //   );
  // }
}
