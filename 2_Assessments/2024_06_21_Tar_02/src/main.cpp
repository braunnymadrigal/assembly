// Copyright 2024 HENOC ROJAS CARRILLO <HENOC.ROJAS@ucr.ac.cr>
// Copyright 2024 BRAUNNY MADRIGAL BARRANTES <BRAUNNY.MADRIGAL@ucr.ac.cr>
// Copyright 2024 KENDALL VILLAFUERTE BEITA <KENDALL.VILLAFUERTE@ucr.ac.cr>
// Copyright 2024 MARCELO PICADO LEIVA <MARCELO.PICADO@ucr.ac.cr>

/**
 * @file main.cpp
 * @brief Este archivo contiene la funci�n 'main'. La ejecuci�n del programa comienza y termina aqu�.
 */

#include "Interface.hpp"

/**
 * @brief Declaraci�n de la funci�n AVXFoundationDetection.
 *
 * Esta funci�n externa declara la funci�n AVXFoundationDetection, que est� implementada en c�digo ensamblador.
 * Utiliza instrucciones de CPUID para detectar la compatibilidad con AVX (Advanced Vector Extensions) en el procesador.
 * Retorna un valor booleano que indica si el procesador soporta la arquitectura AVX (true) o no (false).
 *
 * @return bool Retorna true si el procesador soporta AVX, false en caso contrario.
 */
extern "C" bool AVXFoundationDetection();

/**
 * @brief Funci�n principal del programa.
 *
 * Esta funci�n verifica si la CPU soporta la arquitectura AVX 2. Si es as�, crea una instancia de la clase Interface
 * y llama a sus m�todos 'welcome' y 'tests'. Si no, muestra un mensaje de error.
 *
 * @return int C�digo de retorno del programa.
 */
int main()
{
    if (AVXFoundationDetection())
    {
        Interface interface;
        interface.welcome();
        interface.tests();
    }
    else
    {
        std::cout << "ERROR: Tu CPU no soporta la arquitectura AVX 2." << std::endl;
    }
    return 0;
}

// Ejecutar Programa: Ctrl + F5
// Debug Programa: F5
