/*
 Copyright 2024 "Charlie's Angels"
       <HENOC.ROJAS@ucr.ac.cr>
       <BRAUNNY.MADRIGAL@ucr.ac.cr>
       <KENDALL.VILLAFUERTE@ucr.ac.cr>
       <MARCELO.PICADO@ucr.ac.cr>
       <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#ifndef GAMESTATES_HPP
#define GAMESTATES_HPP

#define WINDOW_WIDTH 300  /**< Ancho de la ventana del juego. */
#define WINDOW_HEIGHT 400  /**< Altura de la ventana del juego. */

/**
 * @brief Enum para los estados del juego Flappy Plane.
 */
enum class GameState {
    MainMenu,  /**< Estado del men� principal. */
    HelpMenu, /**< Estado del men� de ayuda. */
    Playing,  /**< Estado en el que se est� jugando. */
    GameOver  /**< Estado de juego terminado. */
};

#endif // GAMESTATES_HPP
