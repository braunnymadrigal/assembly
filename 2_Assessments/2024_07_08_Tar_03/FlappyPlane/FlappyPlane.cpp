/*
 Copyright 2024 "Charlie's Angels"
       <HENOC.ROJAS@ucr.ac.cr>
       <BRAUNNY.MADRIGAL@ucr.ac.cr>
       <KENDALL.VILLAFUERTE@ucr.ac.cr>
       <MARCELO.PICADO@ucr.ac.cr>
       <RODRIGO.CARBALLO@ucr.ac.cr>
*/

// Correr programa: Ctrl + F5

#include "Game.hpp"

/**
 * @brief Función principal del juego Flappy Plane.
 *
 *     Crea una instancia del juego, ejecuta pruebas y maneja el ciclo principal
 *     del juego.En caso de una excepción, captura el error y cierra limpiamente.
 *
 *     @return int (0 si se ejecuta correctamente, 1 si ocurre un error).
 */
int main() {
    Game* game = new Game();
    runTests();
    try {
        while (game->isRunning()) {
            game->update();
            game->render();
        }
        delete game;
    }
    catch (const std::exception& e) {
        std::cerr << "Error catched: " << e.what() << std::endl;
        delete game;
        return 1;
    }
    return 0;
}
