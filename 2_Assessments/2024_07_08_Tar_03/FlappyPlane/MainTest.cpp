/*
 Copyright 2024 "Charlie's Angels"
       <HENOC.ROJAS@ucr.ac.cr>
       <BRAUNNY.MADRIGAL@ucr.ac.cr>
       <KENDALL.VILLAFUERTE@ucr.ac.cr>
       <MARCELO.PICADO@ucr.ac.cr>
       <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#include "MainTest.hpp"
#include "FlappyCommon.hpp"

#include <cassert>

/// Prueba unitaria para GetGameScore
void testGetGameScore() {
    // Caso 1: El avi�n est� alineado con la torre izquierda
    assert(getGameScore(5, 5, 10) == 1);
    // Caso 2: El avi�n est� alineado con la torre derecha
    assert(getGameScore(10, 5, 10) == 1);
    // Caso 3: El avi�n no est� alineado con ninguna torre
    assert(getGameScore(7, 5, 10) == 0);
    // Caso 4: El avi�n est� alineado con ambas torres
    assert(getGameScore(5, 5, 5) == 1);
    std::cout << "Todas las pruebas de GetGameScore han pasado exitosamente." << std::endl;
}

/// Prueba unitaria para collisions
void test_collisions() {
    // Caso 1: (op1 > op2) && (op3 > op4) es verdadero
    assert(collisions(5, 3, 7, 2) == 1);
    // Caso 2: (op1 > op2) && (op3 > op4) es falso
    assert(collisions(3, 5, 7, 2) == 0);
    // Caso 3: Solo (op1 > op2) es verdadero
    assert(collisions(5, 3, 2, 7) == 0);
    // Caso 4: Solo (op3 > op4) es verdadero
    assert(collisions(3, 5, 7, 2) == 0);
    std::cout << "Todas las pruebas de collisions han pasado exitosamente." << std::endl;
}

/// Prueba unitaria para CheckPointInLine
void test_CheckPointInLine() {
    // Caso 1: El punto est� en la l�nea
    assert(CheckPointInLine(5, 5, 10) == 1);
    // Caso 2: El punto est� en el otro extremo de la l�nea
    assert(CheckPointInLine(10, 5, 10) == 1);
    // Caso 3: El punto est� en el medio de la l�nea
    assert(CheckPointInLine(7, 5, 10) == 1);
    // Caso 4: El punto no est� en la l�nea
    assert(CheckPointInLine(4, 5, 10) == 0);
    // Caso 5: El punto est� en los extremos invertidos de la l�nea
    assert(CheckPointInLine(10, 10, 5) == 1);
    std::cout << "Todas las pruebas de CheckPointInLine han pasado exitosamente." << std::endl;
}

/// Corre todos los tests
void runTests() {
    testButton();
    testText();
    testTowers();
    testPlane();
    testGetGameScore();
    test_CheckPointInLine();
    test_collisions();
}
