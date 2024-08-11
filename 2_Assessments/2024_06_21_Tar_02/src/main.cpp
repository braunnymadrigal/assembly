// Copyright 2024 HENOC ROJAS CARRILLO <HENOC.ROJAS@ucr.ac.cr>
// Copyright 2024 BRAUNNY MADRIGAL BARRANTES <BRAUNNY.MADRIGAL@ucr.ac.cr>
// Copyright 2024 KENDALL VILLAFUERTE BEITA <KENDALL.VILLAFUERTE@ucr.ac.cr>
// Copyright 2024 MARCELO PICADO LEIVA <MARCELO.PICADO@ucr.ac.cr>

/**
 * @file main.cpp
 * @brief Este archivo contiene la función 'main'. La ejecución del programa comienza y termina aquí.
 */

#include "Interface.hpp"

/**
 * @brief Declaración de la función AVXFoundationDetection.
 *
 * Esta función externa declara la función AVXFoundationDetection, que está implementada en código ensamblador.
 * Utiliza instrucciones de CPUID para detectar la compatibilidad con AVX (Advanced Vector Extensions) en el procesador.
 * Retorna un valor booleano que indica si el procesador soporta la arquitectura AVX (true) o no (false).
 *
 * @return bool Retorna true si el procesador soporta AVX, false en caso contrario.
 */
extern "C" bool AVXFoundationDetection();

/**
 * @brief Función principal del programa.
 *
 * Esta función verifica si la CPU soporta la arquitectura AVX 2. Si es así, crea una instancia de la clase Interface
 * y llama a sus métodos 'welcome' y 'tests'. Si no, muestra un mensaje de error.
 *
 * @return int Código de retorno del programa.
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
