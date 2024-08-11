#pragma once

#include<stdio.h>
#include <tchar.h>

#include<iostream>
#include <Windows.h>

using namespace std;

extern "C" INT64 sumArr(int*, INT64);

int main()
{
	int arreglo[6] = { 1,2,3,4,5,9 };  // C24436, 3+6 == 9
	int cantidadDeElementos = sizeof(arreglo) / sizeof(INT);
	cout << sumArr(arreglo, cantidadDeElementos) << endl;
	return 0;
}
