import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

Widget inputField(Icon prefixIcon, String hintText, bool isPassword,
    Function onChanged, Function validator) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 25,
          offset: Offset(0, 10),
          spreadRadius: -25,
        ),
      ],
    ),
    margin: const EdgeInsets.only(bottom: 20),
    child: TextFormField(
      validator: (val) => validator(val),
      onChanged: (val) => onChanged(val),
      obscureText: isPassword,
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Color(0xff000912),
        ),
      ),
      decoration: InputDecoration(
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            borderSide: BorderSide(
              color: Colors.white,
            )),
        contentPadding: const EdgeInsets.symmetric(vertical: 25),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xffA6B0BD),
        ),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: prefixIcon,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 75,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    ),
  );
}

Widget loginBtn(Function onPressed) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 20, bottom: 50),
    decoration: const BoxDecoration(
        color: Color(0xff008FFF),
        borderRadius: BorderRadius.all(Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Color(0x60008FFF),
            blurRadius: 10,
            offset: Offset(0, 10),
            spreadRadius: 0,
          ),
        ]),
    child: TextButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 25),
        ),
      ),
      child: Text(
        "SIGN IN",
        style: GoogleFonts.montserrat(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 3,
          ),
        ),
      ),
    ),
  );
}

Widget terms() {
  return Container(
    padding: const EdgeInsets.only(top: 10, bottom: 18),
    child: TextButton(
      onPressed: () => {},
      child: Text(
        "Terms & Conditions",
        style: GoogleFonts.montserrat(
          textStyle: const TextStyle(
            color: Color(0xffA6B0BD),
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ),
    ),
  );
}

Widget signUp(Function onPressed) {
  return TextButton(
    onPressed: () => {onPressed()},
    child: Text(
      "SIGN UP NOW",
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          color: Color(0xFF008FFF),
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
    ),
  );
}

Widget dontHaveAcnt() {
  return Text(
    "Don't have an account?",
    style: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        color: Color(0xffA6B0BD),
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    ),
  );
}

Widget logoText() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 50),
    child: Text(
      "What Should I Eat?",
      style: GoogleFonts.nunito(
        textStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w800,
          color: Color(0xff000912),
          letterSpacing: 4,
        ),
      ),
    ),
  );
}

Widget logo() {
  return Container(
    margin: const EdgeInsets.only(top: 100),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
            left: -50,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff00bfdb),
              ),
            )),
        Positioned(
            child: Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff008FFF),
          ),
        )),
        Positioned(
          left: 50,
          child: Container(
            child: const Icon(
              Icons.water_drop,
              color: Colors.white,
              size: 40,
            ),
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff00227E),
            ),
          ),
        ),
      ],
    ),
  );
}
