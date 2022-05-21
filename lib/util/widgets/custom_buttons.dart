import 'package:flutter/material.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({Key? key, required this.child, required this.onTap})
      : super(key: key);
  final Widget child;
  final Function()? onTap;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: size.width,
      decoration: BoxDecoration(
          color: Palette.buttonColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 5),
              color: Palette.buttonColor.withOpacity(0.1),
              blurRadius: 15,
            )
          ],
          borderRadius: BorderRadius.circular(32)),
      child: ElevatedButton(
        onPressed: widget.onTap,
        child: Center(child: widget.child),
      ),
    );
  }
}

class CustomOutlinedButton extends StatefulWidget {
  const CustomOutlinedButton(
      {Key? key, required this.child, required this.onTap})
      : super(key: key);
  final Widget child;
  final Function()? onTap;

  @override
  State<CustomOutlinedButton> createState() => _CoustomOutlinedButton();
}

class _CoustomOutlinedButton extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: size.width * 0.8,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
      child: OutlinedButton(
        onPressed: widget.onTap,
        child: Center(child: widget.child),
      ),
    );
  }
}

// SingleChildScrollView buildSingleChildScrollView(
//     {Size size, String level, int index1}) {
//   return SingleChildScrollView(
//       child: Column(
//     children: [
//       ListView.builder(
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           itemCount: nexttry.length,
//           itemBuilder: (BuildContext context, int index) {
//             return GestureDetector(
//               onTap: () {},
//               child: Container(
//                 height: 50,
//                 width: size.width,
//                 margin: EdgeInsets.symmetric(
//                     vertical: kDefaultPadding * 0.3,
//                     horizontal: kDefaultPadding),
//                 child: Row(
//                   children: [
//                     Expanded(
//                         flex: 1,
//                         child: FaIcon(
//                           FontAwesomeIcons.book,
//                           color: buttonColor,
//                         )),
//                     Expanded(
//                         flex: 8,
//                         child: Text(
//                           nexttry[index],
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ))
//                   ],
//                 ),
//               ),
//             );
//           })
//     ],
//   ));
// }
class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
    required this.icon,
    required this.controller,
  }) : super(key: key);
  final IconData icon;
  final TextEditingController controller;
  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25), bottomLeft: Radius.circular(25)),
        border: Border.all(color: Palette.primaryColor.withOpacity(0.3)),
        // boxShadow: [
        //   BoxShadow(
        //       color: Palette.primaryColor.withOpacity(0.2),
        //       blurRadius: 1.0,
        //       spreadRadius: 0.5)
        // ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
                style: TextStyle(color: Palette.primaryColor),
                controller: widget.controller,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                )),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              showSnackBar(context, 'Search tap');
            },
            child: Container(
                width: 40,
                decoration: BoxDecoration(
                  color: _focusNode.hasFocus
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).backgroundColor,
                ),
                height: 50,
                child: Center(
                    child: Icon(
                  widget.icon,
                  color: _focusNode.hasFocus
                      ? Theme.of(context).backgroundColor
                      : Theme.of(context).primaryColor,
                ))),
          ),
        ],
      ),
    );
  }
}

class SideInputField extends StatefulWidget {
  const SideInputField({
    Key? key,
    required this.controller,
    this.height,
    this.lines,
    required this.hint,
  }) : super(key: key);
  final TextEditingController controller;
  final double? height;
  final int? lines;
  final String hint;
  @override
  State<SideInputField> createState() => _SideInputFieldState();
}

class _SideInputFieldState extends State<SideInputField> {
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      height: widget.height ?? 50,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
        border: Border.all(color: Palette.primaryColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
                maxLines: (widget.lines) ?? 1,
                style: TextStyle(color: Palette.primaryColor),
                controller: widget.controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                )),
          ),
          // const SizedBox(width: 4),
          // GestureDetector(
          //   onTap: () {
          //     showSnackBar(context, 'Search tap');
          //   },
          //   child: Container(
          //       width: 40,
          //       decoration: BoxDecoration(
          //         color: _focusNode.hasFocus
          //             ? Theme.of(context).primaryColor
          //             : Theme.of(context).backgroundColor,
          //       ),
          //       height: 50,
          //       child: Center(
          //           child: Icon(
          //         widget.icon,
          //         color: _focusNode.hasFocus
          //             ? Theme.of(context).backgroundColor
          //             : Theme.of(context).primaryColor,
          //       ))),
          // ),
        ],
      ),
    );
  }
}
