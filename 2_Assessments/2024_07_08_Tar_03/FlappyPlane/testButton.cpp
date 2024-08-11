/*
 Copyright 2024 "Charlie's Angels"
       <HENOC.ROJAS@ucr.ac.cr>
       <BRAUNNY.MADRIGAL@ucr.ac.cr>
       <KENDALL.VILLAFUERTE@ucr.ac.cr>
       <MARCELO.PICADO@ucr.ac.cr>
       <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#include "MainTest.hpp"
#include "Button.hpp"

// Funcion para probar la inicializacion
void testButton() {
    Button button;
    sf::Sprite buttonPlaySprite = button.getButtonPlay();
    sf::Sprite buttonHelpSprite = button.getButtonHelp();

    if (!buttonPlaySprite.getTexture()) {
        std::cerr << "Error: La textura del boton de reproduccion no se ha inicializado correctamente." << std::endl;
    }
    else {
        std::cout << "La textura del boton de reproduccion se ha inicializado correctamente." << std::endl;
    }

    if (!buttonHelpSprite.getTexture()) {
        std::cerr << "Error: La textura del boton de ayuda no se ha inicializado correctamente." << std::endl;
    }
    else {
        std::cout << "La textura del boton de ayuda se ha inicializado correctamente." << std::endl;
    }

    // Pruebas para los clicks de los botones
    if (!button.isButtonPlayClicked(110, 360)) {
        std::cerr << "Error: El boton de reproduccion no detecta clics correctamente." << std::endl;
    }
    else {
        std::cout << "El boton de reproduccion detecta clics correctamente." << std::endl;
    }

    if (!button.isButtonHelpClicked(110, 290)) {
        std::cerr << "Error: El boton de ayuda no detecta clics correctamente." << std::endl;
    }
    else {
        std::cout << "El boton de ayuda detecta clics correctamente." << std::endl;
    }
}
