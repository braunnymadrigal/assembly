/*
 Copyright 2024 "Charlie's Angels"
       <HENOC.ROJAS@ucr.ac.cr>
       <BRAUNNY.MADRIGAL@ucr.ac.cr>
       <KENDALL.VILLAFUERTE@ucr.ac.cr>
       <MARCELO.PICADO@ucr.ac.cr>
       <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#ifndef BUTTON_HPP
#define BUTTON_HPP

#include "FlappyCommon.hpp"

/**
 * @brief Clase para manejar los botones en el juego Flappy.
 */
class Button {
private:
    sf::Sprite buttonPlaySprite;  /**< Sprite del bot�n de jugar. */
    sf::Texture buttonPlayTexture;  /**< Textura del bot�n de jugar. */
    sf::Sprite buttonHelpSprite;  /**< Sprite del bot�n de ayuda. */
    sf::Texture buttonHelpTexture; /**< Textura del bot�n de ayuda. */
    int buttonPlayX;  /**< Coordenada X del bot�n de jugar. */
    int buttonPlayY;  /**< Coordenada Y del bot�n de jugar. */
    int buttonHelpX;  /**< Coordenada X del bot�n de ayuda. */
    int buttonHelpY;  /**< Coordenada Y del bot�n de ayuda. */
    int buttonWidth;  /**< Ancho de los botones. */
    int buttonHeight;  /**< Alto de los botones. */

private:
    /**
     * @brief Inicializa las texturas de los botones.
     * 
     * @throws std::runtime_error si no se pueden cargar los archivos.
     */
	void initTextures();

    /**
     * @brief Inicializa los sprites de los botones.
     */
	void initSprites();

public:
    /**
     * @brief Constructor de la clase Button.
     */
	Button();

    /**
     * @brief Destructor de la clase Button.
     */
	~Button();

    /**
     * @brief Verifica si el bot�n de jugar fue clickeado.
     *
     * @param mouseX Coordenada X del rat�n.
     * @param mouseY Coordenada Y del rat�n.
     * @return true si el bot�n de jugar fue clickeado.
     * @return false en caso contrario.
     */
	bool isButtonPlayClicked(int mouseX, int mouseY);

    /**
     * @brief Verifica si el bot�n de ayuda fue clickeado.
     *
     * @param mouseX Coordenada X del rat�n.
     * @param mouseY Coordenada Y del rat�n.
     * @return true si el bot�n de ayuda fue clickeado.
     * @return false en caso contrario.
     */
	bool isButtonHelpClicked(int mouseX, int mouseY);

    /**
     * @brief Obtiene el sprite del bot�n de jugar.
     *
     * @return sf::Sprite Sprite del bot�n de jugar.
     */
	sf::Sprite getButtonPlay();

    /**
     * @brief Obtiene el sprite del bot�n de ayuda.
     *
     * @return sf::Sprite Sprite del bot�n de ayuda.
     */
	sf::Sprite getButtonHelp();
};

#endif  // BUTTON_HPP
