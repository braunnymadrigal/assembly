#include <iostream>
using namespace std;


class SumarArreglo {    
    public: 
        static int sumarArreglo();
};

int SumarArreglo::sumarArreglo() {
    //Declaramos el arreglo 
    int arreglo[5] = { 1,2,3,4,5 };
    //Obtenermos el tamaño del arreglo.
    int cantidadDeElementos = sizeof(arreglo) / sizeof(arreglo[0]);
    //variable donde se va a guardar la suma 
    int sum = 0;
    _asm {
        // En este registro guardamos la posicion que estamos extrayendo del arreglo
        mov eax, 0; 
        // Limpiamos el registro donde vamos a guardar la suma del arrglo.
        mov edx, 0;
        // Este registro va a ser nuestro contador, lo iniciamos en la cantidad de elementos que tiene el arreglo.
        mov ebx, cantidadDeElementos;
        //Cargamos la direccion de la primera posicion del arreglo en el registro ecx. 
        lea ecx, arreglo; 
    suma:
        //En ecx esta la primera posicion del arreglo y en eax esta la posicion del arreaglo a la que queremos acceder
        //Se multimplica por cuatro ya que se es un arreglo de int. 
        add edx, [ecx + eax * 4]
        dec ebx
        jz done

        inc eax
        jmp suma

    done :
        mov sum, edx
    }
    return sum;
}

int main(int argc, char * argv){

    int sumaDelArreglo = SumarArreglo::sumarArreglo(); 
    cout << "La suma del arreglo es: " << sumaDelArreglo << endl;
    return 0; 
}


