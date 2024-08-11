/*
 Copyright 2024 "Charlie's Angels"
	   <HENOC.ROJAS@ucr.ac.cr>
	   <BRAUNNY.MADRIGAL@ucr.ac.cr>
	   <KENDALL.VILLAFUERTE@ucr.ac.cr>
	   <MARCELO.PICADO@ucr.ac.cr>
	   <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#include "Audios.hpp"

void Audios::initBuffers() {
	if (!this->bombBuffer.loadFromFile("myMedia/bomb.wav")) {
		throw std::runtime_error("Failed to load bomb.wav");
	}
	if (!this->coinBuffer.loadFromFile("myMedia/coin.wav")) {
		throw std::runtime_error("Failed to load coin.wav");
	}
	if (!this->jumpBuffer.loadFromFile("myMedia/jump.wav")) {
		throw std::runtime_error("Failed to load jump.wav");
	}
	if (!this->clickBuffer.loadFromFile("myMedia/click.wav")) {
		throw std::runtime_error("Failed to load click.wav");
	}
}

void Audios::initSounds() {
	this->bombSound.setBuffer(bombBuffer);
	this->coinSound.setBuffer(coinBuffer);
	this->jumpSound.setBuffer(jumpBuffer);
	this->clickSound.setBuffer(clickBuffer);
}

Audios::Audios() {
	this->initBuffers();
	this->initSounds();
}

Audios::~Audios() {}

void Audios::playBombSound() {
	this->bombSound.setVolume(100.f);
	this->bombSound.play();
}

void Audios::playCoinSound() {
	this->coinSound.setVolume(70.f);
	this->coinSound.play();
}

void Audios::playJumpSound() {
	this->jumpSound.setVolume(40.f);
	this->jumpSound.play();
}

void Audios::playClickSound() {
	this->clickSound.setVolume(90.f);
	this->clickSound.play();
}
