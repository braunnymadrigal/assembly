/*
 Copyright 2024 "Charlie's Angels"
       <HENOC.ROJAS@ucr.ac.cr>
       <BRAUNNY.MADRIGAL@ucr.ac.cr>
       <KENDALL.VILLAFUERTE@ucr.ac.cr>
       <MARCELO.PICADO@ucr.ac.cr>
       <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#include "MainTest.hpp"
#include "Text.hpp"

// Funcion para probar la inicializacion de los textos
void testText() {
    Text text;

    // Verificacion de la fuente
    sf::Text textScore = text.getTextScore();
    sf::Text textInfo = text.getTextInfo();
    sf::Text textTitle = text.getTextTitle();

    if (!textScore.getFont()) {
        std::cerr << "Error: La fuente del texto de puntuacion no se ha inicializado correctamente." << std::endl;
    }
    else {
        std::cout << "La fuente del texto de puntuacion se ha inicializado correctamente." << std::endl;
    }

    if (!textInfo.getFont()) {
        std::cerr << "Error: La fuente del texto de informacion no se ha inicializado correctamente." << std::endl;
    }
    else {
        std::cout << "La fuente del texto de informacion se ha inicializado correctamente." << std::endl;
    }

    if (!textTitle.getFont()) {
        std::cerr << "Error: La fuente del titulo del texto no se ha inicializado correctamente." << std::endl;
    }
    else {
        std::cout << "La fuente del titulo del texto se ha inicializado correctamente." << std::endl;
    }

    // Verificacion de los contenidos iniciales
    if (static_cast<std::string>(textScore.getString()) != "SCORE: 0") {
        std::cerr << "Error: El texto de puntuacion inicial no es correcto." << std::endl;
    }
    else {
        std::cout << "El texto de puntuacion inicial es correcto." << std::endl;
    }

    if (static_cast<std::string>(textTitle.getString()) != "FLAPPY PLANE") {
        std::cerr << "Error: El titulo inicial del texto no es correcto." << std::endl;
    }
    else {
        std::cout << "El titulo inicial del texto es correcto." << std::endl;
    }

    // Prueba de actualizacion de puntuacion
    text.setTextScore(99);
    if (static_cast<std::string>(text.getTextScore().getString()) != "SCORE: 99") {
        std::cerr << "Error: La actualizacion del texto de puntuacion no es correcta." << std::endl;
    }
    else {
        std::cout << "La actualizacion del texto de puntuacion es correcta." << std::endl;
    }
}
