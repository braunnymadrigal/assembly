/*
 Copyright 2024 "Charlie's Angels"
       <HENOC.ROJAS@ucr.ac.cr>
       <BRAUNNY.MADRIGAL@ucr.ac.cr>
       <KENDALL.VILLAFUERTE@ucr.ac.cr>
       <MARCELO.PICADO@ucr.ac.cr>
       <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#include "MainTest.hpp"
#include "Towers.hpp"

// Funcion para probar la inicializacion de las torres
void testTowers() {
    Towers towers;

    // Verificacion de las texturas
    sf::Sprite tLeftTop = towers.getTLeftTop();
    sf::Sprite tLeftBot = towers.getTLeftBot();
    sf::Sprite tRighTop = towers.getTRighTop();
    sf::Sprite tRighBot = towers.getTRighBot();

    if (!tLeftTop.getTexture()) {
        std::cerr << "Error: La textura de la torre superior izquierda no se ha inicializado correctamente." << std::endl;
    }
    else {
        std::cout << "La textura de la torre superior izquierda se ha inicializado correctamente." << std::endl;
    }

    if (!tLeftBot.getTexture()) {
        std::cerr << "Error: La textura de la torre inferior izquierda no se ha inicializado correctamente." << std::endl;
    }
    else {
        std::cout << "La textura de la torre inferior izquierda se ha inicializado correctamente." << std::endl;
    }

    if (!tRighTop.getTexture()) {
        std::cerr << "Error: La textura de la torre superior derecha no se ha inicializado correctamente." << std::endl;
    }
    else {
        std::cout << "La textura de la torre superior derecha se ha inicializado correctamente." << std::endl;
    }

    if (!tRighBot.getTexture()) {
        std::cerr << "Error: La textura de la torre inferior derecha no se ha inicializado correctamente." << std::endl;
    }
    else {
        std::cout << "La textura de la torre inferior derecha se ha inicializado correctamente." << std::endl;
    }

    // Verificacion de las posiciones iniciales
    std::vector<int> coordinates = towers.getCoordinates();
    if (coordinates != std::vector<int>{140, 240, 140, -70, 330, 240, 330, -70}) {
        std::cerr << "Error: Las coordenadas iniciales de las torres no son correctas." << std::endl;
    }
    else {
        std::cout << "Las coordenadas iniciales de las torres son correctas." << std::endl;
    }

    // Prueba de movimiento de las torres
    towers.moveTowers();
    coordinates = towers.getCoordinates();
    if (coordinates == std::vector<int>{138, 240, 138, -70, 328, 240, 328, -70}) {
        std::cout << "El movimiento de las torres es correcto." << std::endl;
    }
    else {
        std::cerr << "Error: El movimiento de las torres no es correcto." << std::endl;
    }

    // Prueba de restablecimiento de las posiciones originales
    towers.setOriginalPosition();
    coordinates = towers.getCoordinates();
    if (coordinates == std::vector<int>{140, 240, 140, -70, 330, 240, 330, -70}) {
        std::cout << "El restablecimiento de las posiciones originales es correcto." << std::endl;
    }
    else {
        std::cerr << "Error: El restablecimiento de las posiciones originales no es correcto." << std::endl;
    }
}
