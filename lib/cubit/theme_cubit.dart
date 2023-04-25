import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.lightTheme());

  void toggleTheme() {
    emit(state.isDarkMode ? ThemeState.lightTheme() : ThemeState.darkTheme());
  }
}

// class ThemeCubit extends Cubit<ThemeState> {
//   ThemeCubit()
//       : super(ThemeState(
//           themeData: ThemeData(
//             primaryColor: Colors.blue,
//             backgroundColor: Colors.white,
//           ),
//           isDarkMode: false,
//         ));

//   void toggleTheme() {
//     final newIsDarkMode = !state.isDarkMode;
//     final newThemeData = ThemeData(
//       primaryColor: newIsDarkMode ? Colors.white : Colors.blue,
//       backgroundColor: newIsDarkMode ? Colors.black : Colors.white,
//     );
//     emit(ThemeState(themeData: newThemeData, isDarkMode: newIsDarkMode));
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'theme_state.dart';

// class ThemeCubit extends Cubit<ThemeState> {
//   ThemeCubit() : super(ThemeState.lightTheme());

//   void toggleTheme() {
//     emit(state.isDarkMode
//         ? ThemeState(
//             themeData: ThemeData.dark().copyWith(
//               scaffoldBackgroundColor: Colors.black,
//             ),
//             isDarkMode: false,
//           )
//         : ThemeState(
//             themeData: ThemeData.light().copyWith(
//               scaffoldBackgroundColor: Colors.white,
//             ),
//             isDarkMode: true,
//           ));
//   }
// }

//-----

// class ThemeCubit extends Cubit<ThemeState> {
//   ThemeCubit() : super(ThemeState.lightTheme());

//   void toggleTheme() {
//     emit(state.isDarkMode ? ThemeState.lightTheme() : ThemeState.darkTheme());
//   }
// }



