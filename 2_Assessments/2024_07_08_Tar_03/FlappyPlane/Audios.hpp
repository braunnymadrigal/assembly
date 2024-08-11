/*
 Copyright 2024 "Charlie's Angels"
	   <HENOC.ROJAS@ucr.ac.cr>
	   <BRAUNNY.MADRIGAL@ucr.ac.cr>
	   <KENDALL.VILLAFUERTE@ucr.ac.cr>
	   <MARCELO.PICADO@ucr.ac.cr>
	   <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#ifndef AUDIOS_HPP
#define AUDIOS_HPP

#include "FlappyCommon.hpp"

/**
 * @brief Clase para manejar los sonidos en el juego Flappy.
 */
class Audios {
private:
	sf::SoundBuffer bombBuffer;  /**< Buffer de sonido para la bomba. */
	sf::SoundBuffer coinBuffer;  /**< Buffer de sonido para la moneda. */
	sf::SoundBuffer jumpBuffer;  /**< Buffer de sonido para el salto. */
	sf::SoundBuffer clickBuffer;  /**< Buffer de sonido para el clic. */
	sf::Sound coinSound;  /**< Sonido de la moneda. */
	sf::Sound bombSound;  /**< Sonido de la bomba. */
	sf::Sound jumpSound;  /**< Sonido del salto. */
	sf::Sound clickSound;  /**< Sonido del clic. */

private:
	/**
	 * @brief Inicializa los buffers de sonido.
	 * 
	 * @throws std::runtime_error si no se pueden cargar los archivos.
	 */
	void initBuffers();

	/**
	 * @brief Inicializa los sonidos.
	 */
	void initSounds();

public:
	/**
	 * @brief Constructor de la clase Audios.
	 */
	Audios();

	/**
	 * @brief Destructor de la clase Audios.
	 */
	~Audios();

	/**
	 * @brief Reproduce el sonido de la bomba.
	 */
	void playBombSound();

	/**
	 * @brief Reproduce el sonido de la moneda.
	 */
	void playCoinSound();

	/**
	 * @brief Reproduce el sonido del salto.
	 */
	void playJumpSound();

	/**
	 * @brief Reproduce el sonido del clic.
	 */
	void playClickSound();
};

#endif  // AUDIOS_HPP
