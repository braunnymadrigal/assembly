// Copyright 2024 HENOC ROJAS CARRILLO <HENOC.ROJAS@ucr.ac.cr>
// Copyright 2024 BRAUNNY MADRIGAL BARRANTES <BRAUNNY.MADRIGAL@ucr.ac.cr>
// Copyright 2024 KENDALL VILLAFUERTE BEITA <KENDALL.VILLAFUERTE@ucr.ac.cr>
// Copyright 2024 MARCELO PICADO LEIVA <MARCELO.PICADO@ucr.ac.cr>

/**
 * @file Interface.cpp
 * @brief Implementación de los métodos de la clase Interface para la calculadora vectorial.
 *
 * Este archivo contiene las implementaciones de los métodos definidos en Interface.hpp.
 * Incluye la lógica para mostrar mensajes de bienvenida, ejecutar pruebas, interactuar con el usuario
 * a través de un menú y realizar operaciones de suma y multiplicación de vectores.
 */

#include "Interface.hpp"

void Interface::welcome()
{
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << "  UNIVERSIDAD DE COSTA RICA" << std::endl;
    std::cout << "  CI-0118 Lenguaje Ensamblador" << std::endl;
    std::cout << "  Dr. Carlos Vargas" << std::endl;
    std::cout << "  I Ciclo del 2024" << std::endl;
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << "  Segunda Tarea Programada: Calculadora Vectorial" << std::endl;
    std::cout << "  Programacion hibrida (Visual C++ y ensamblador)" << std::endl;
    std::cout << "  Arquitectura Intel X64 en modo protegido" << std::endl;
    std::cout << "  IDE: Visual Studio Community" << std::endl;
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << "  Operaciones de la Calculadora:" << std::endl;
    std::cout << "  1. Suma de dos vectores" << std::endl;
    std::cout << "  2. Multiplicacion de un escalar por un vector" << std::endl;
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << "  Integrantes del equipo:" << std::endl;
    std::cout << "  - Braunny Madrigal Barrantes (C24436)" << std::endl;
    std::cout << "  - Marcelo Picado Leiva (C15950)" << std::endl;
    std::cout << "  - Henoc Rojas Carrillo (C26764)" << std::endl;
    std::cout << "  - Kendall Villafuerte Beita (C28387)" << std::endl;
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << "   Bienvenidos al programa de la Calculadora Vectorial!" << std::endl;
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << "   Presione 'ENTER' para continuar!" << std::endl;
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << std::endl << std::endl << std::endl;
    std::cin.get();
}

void Interface::printMenu()
{
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << "  MENU PRINCIPAL" << std::endl;
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << "  0. Salir del programa" << std::endl;
    std::cout << "  1. Sumar dos vectores" << std::endl;
    std::cout << "  2. Multiplicar un escalar por un vector" << std::endl;
    std::cout << "  3. Mostrar manual de usuario" << std::endl;
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << std::endl << std::endl << std::endl;
}

void Interface::tests()
{
    int myOption = -1;
    while (myOption != 0)
    {
        this->printMenu();
        myOption = this->getOption();
        if (myOption == 1)
        {
            this->sumInterface();
        }
        else if (myOption == 2)
        {
            this->mulInterface();
        }
        else if (myOption == 3)
        {
            this->showGuide();
        } 
        else if (myOption == 0)
        {
            std::cout << "-----------------------------------------------" << std::endl;
            std::cout << "   Presione 'ENTER' para terminar de ejecutar!" << std::endl;
            std::cout << "-----------------------------------------------" << std::endl;
        }
        std::cout << std::endl << std::endl << std::endl;
        std::cin.get();
    }
}

int Interface::getOption()
{
    int myOption = -1;
    std::cout << std::endl;
    std::cout << " Que deseas hacer?: ";
    std::string myInput = "";
    std::cin >> myInput;
    std::cout << std::endl;
    try
    {
        myOption = std::stoi(myInput);
    }
    catch (const std::invalid_argument& e)
    {
        (void)e;
        std::cerr << "Error: Entrada no valida. No es un numero entero." << std::endl;
    }
    return myOption;
}

void Interface::showGuide()
{
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << "  MANUAL DE USUARIO" << std::endl;
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << "  Esta calculadora vectorial permite realizar las siguientes operaciones:" << std::endl;
    std::cout << std::endl;
    std::cout << "  1. Suma de dos vectores de numeros flotantes." << std::endl;
    std::cout << "     Ejemplo: Ingrese la cantidad de elementos del vector, debe de ser un entero multiplo de 8." << std::endl;
    std::cout << "              Ingrese los elementos del primer vector separados por comas (a.aa,b.bb,c.cc,...)." << std::endl;
    std::cout << "              Luego, ingrese los elementos del segundo vector de la misma forma." << std::endl;
    std::cout << "              Importante, no pueden haber espacios entre las comas." << std::endl;
    std::cout << std::endl;
    std::cout << "  2. Multiplicacion de un escalar por un vector de números flotantes." << std::endl;
    std::cout << "     Ejemplo: Ingrese la cantidad de elementos del vector, debe de ser un entero multiplo de 8." << std::endl;
    std::cout << "              Ingrese los elementos del primer vector separados por comas (a.aa,b.bb,c.cc,...)." << std::endl;
    std::cout << "              Luego, ingrese el escalar como numero de tipo flotante." << std::endl;
    std::cout << "              Importante, no pueden haber espacios entre las comas." << std::endl;
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << "  NOTAS:" << std::endl;
    std::cout << "  - Asegurese de ingresar numeros validos para evitar errores." << std::endl;
    std::cout << "  - Si se ingresa un decimal y el programa espera un entero, dicho decimal sera truncado y usado como tal." << std::endl;
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << "   Presione 'ENTER' para volver al menu principal!" << std::endl;
    std::cout << "-----------------------------------------------" << std::endl;
    std::cout << std::endl << std::endl << std::endl;
}

void Interface::sumInterface()
{
    int vectorSize = 0;
    std::string userInput = "";
    double* vector1 = nullptr;
    double* vector2 = nullptr;
    bool memoryAsked = false;
    std::stringstream ss = std::stringstream();
    std::string value = "";
    int i = 0;
    int numSegments = 0;
    try
    {
        // pedir tamaño vectores
        std::cout << "Ingresa la cantidad de elementos de ambos vectores:" << std::endl;
        std::cin >> userInput;
        vectorSize = std::stoi(userInput);
        if (vectorSize % 8 != 0)
        {
            throw std::out_of_range("La cantidad de elementos ingresada no es multiplo de 8.");
        }

        // vectores
        vector1 = new double[vectorSize];
        vector2 = new double[vectorSize];
        memoryAsked = true;

        // pedir vector1
        ss.clear();
        ss.str("");
        i = 0;
        value = "";
        std::cout << "Ingresa el primer vector:" << std::endl;
        std::cin >> userInput;
        ss << userInput;
        while (std::getline(ss, value, ','))
        {
            if (i >= vectorSize)
            {
                throw std::out_of_range("El numero de elementos excede la maxima cantidad de elementos que puede alojar el vector.");
            }
            vector1[i++] = std::stod(value);
        }
        if (i < vectorSize)
        {
            throw std::out_of_range("El numero de elementos no llena al vector.");
        }

        // pedir vector2
        ss.clear();
        ss.str("");
        i = 0;
        value = "";
        std::cout << "Ingresa el segundo vector:" << std::endl;
        std::cin >> userInput;
        ss << userInput;
        while (std::getline(ss, value, ','))
        {
            if (i >= vectorSize)
            {
                throw std::out_of_range("El numero de elementos excede la maxima cantidad de elementos que puede alojar el vector.");
            }
            vector2[i++] = std::stod(value);
        }
        if (i < vectorSize)
        {
            throw std::out_of_range("El numero de elementos no llena al vector.");
        }

        // computar e imprimir
        numSegments = vectorSize / 8; // Número de segmentos completos de 8 elementos
        for (int seg = 0; seg < numSegments; ++seg) {  // Sumar vectores usando AVX por partes de 8 elementos
            AVXSumTwoVectors(vector1 + seg * 8, vector2 + seg * 8);
        }
        std::cout << "Resultado:" << std::endl;
        for (i = 0; i < vectorSize; ++i)
        {
            std::cout << vector1[i];
            if (i < (vectorSize - 1))
            {
                std::cout << ",";
            }
        }
    }
    catch (const std::invalid_argument& e)
    {
        (void)e;
        std::cerr << "Error: Entrada no valida. No es un numero valido." << std::endl;
    }
    catch (const std::out_of_range& e)
    {
        std::cerr << "Error: " << e.what() << std::endl;
    }
    catch (const std::bad_alloc& e)
    {
        (void)e;
        std::cerr << "Error de asignación de memoria." << std::endl;
    }
    if (memoryAsked)
    {
        delete[] vector1;
        delete[] vector2;
    }
    std::cout << std::endl << std::endl << std::endl;
}

void Interface::mulInterface()
{
    int vectorSize = 0;
    std::string userInput = "";
    double* vector1 = nullptr;
    double myDouble = 0;
    bool memoryAsked = false;
    std::stringstream ss = std::stringstream();
    std::string value = "";
    int i = 0;
    int numSegments = 0;
    try
    {
        // pedir tamaño vectores
        std::cout << "Ingresa la cantidad de elementos del unico vector:" << std::endl;
        std::cin >> userInput;
        vectorSize = std::stoi(userInput);
        if (vectorSize % 8 != 0)
        {
            throw std::out_of_range("La cantidad de elementos ingresada no es multiplo de 8.");
        }

        // vectores
        vector1 = new double[vectorSize];
        memoryAsked = true;

        // pedir vector1
        ss.clear();
        ss.str("");
        i = 0;
        value = "";
        std::cout << "Ingresa el vector:" << std::endl;
        std::cin >> userInput;
        ss << userInput;
        while (std::getline(ss, value, ','))
        {
            if (i >= vectorSize)
            {
                throw std::out_of_range("El numero de elementos excede la maxima cantidad de elementos que puede alojar el vector.");
            }
            vector1[i++] = std::stod(value);
        }
        if (i < vectorSize)
        {
            throw std::out_of_range("El numero de elementos no llena al vector.");
        }

        // pedir numero double
        std::cout << "Ingresa el escalar:" << std::endl;
        std::cin >> userInput;
        myDouble = std::stod(userInput);


        // computar e imprimir
        numSegments = vectorSize / 8; // Número de segmentos completos de 8 elementos
        for (int seg = 0; seg < numSegments; ++seg) {  // Multiplicar el vector por el escalar usando AVX por partes de 8 elementos
            AVXMulVecByScalar(vector1 + seg * 8, &myDouble);
        }
        std::cout << "Resultado:" << std::endl;
        for (i = 0; i < vectorSize; ++i)
        {
            std::cout << vector1[i];
            if (i < (vectorSize - 1))
            {
                std::cout << ",";
            }
        }
    }
    catch (const std::invalid_argument& e)
    {
        (void)e;
        std::cerr << "Error: Entrada no valida. No es un numero válido." << std::endl;
    }
    catch (const std::out_of_range& e)
    {
        std::cerr << "Error: " << e.what() << std::endl;
    }
    catch (const std::bad_alloc& e)
    {
        (void)e;
        std::cerr << "Error de asignación de memoria." << std::endl;
    }
    if (memoryAsked)
    {
        delete[] vector1;
    }
    std::cout << std::endl << std::endl << std::endl;
}
