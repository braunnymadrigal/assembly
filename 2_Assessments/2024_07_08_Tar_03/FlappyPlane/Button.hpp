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
    sf::Sprite buttonPlaySprite;  /**< Sprite del botón de jugar. */
    sf::Texture buttonPlayTexture;  /**< Textura del botón de jugar. */
    sf::Sprite buttonHelpSprite;  /**< Sprite del botón de ayuda. */
    sf::Texture buttonHelpTexture; /**< Textura del botón de ayuda. */
    int buttonPlayX;  /**< Coordenada X del botón de jugar. */
    int buttonPlayY;  /**< Coordenada Y del botón de jugar. */
    int buttonHelpX;  /**< Coordenada X del botón de ayuda. */
    int buttonHelpY;  /**< Coordenada Y del botón de ayuda. */
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
     * @brief Verifica si el botón de jugar fue clickeado.
     *
     * @param mouseX Coordenada X del ratón.
     * @param mouseY Coordenada Y del ratón.
     * @return true si el botón de jugar fue clickeado.
     * @return false en caso contrario.
     */
	bool isButtonPlayClicked(int mouseX, int mouseY);

    /**
     * @brief Verifica si el botón de ayuda fue clickeado.
     *
     * @param mouseX Coordenada X del ratón.
     * @param mouseY Coordenada Y del ratón.
     * @return true si el botón de ayuda fue clickeado.
     * @return false en caso contrario.
     */
	bool isButtonHelpClicked(int mouseX, int mouseY);

    /**
     * @brief Obtiene el sprite del botón de jugar.
     *
     * @return sf::Sprite Sprite del botón de jugar.
     */
	sf::Sprite getButtonPlay();

    /**
     * @brief Obtiene el sprite del botón de ayuda.
     *
     * @return sf::Sprite Sprite del botón de ayuda.
     */
	sf::Sprite getButtonHelp();
};

#endif  // BUTTON_HPP
