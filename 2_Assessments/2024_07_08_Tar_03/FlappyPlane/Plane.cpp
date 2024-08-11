/*
 Copyright 2024 "Charlie's Angels"
	   <HENOC.ROJAS@ucr.ac.cr>
	   <BRAUNNY.MADRIGAL@ucr.ac.cr>
	   <KENDALL.VILLAFUERTE@ucr.ac.cr>
	   <MARCELO.PICADO@ucr.ac.cr>
	   <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#include "Plane.hpp"

void Plane::initTexture() {

	if (!this->planeTexture.loadFromFile("myMedia/boeing.png")) {
		throw std::runtime_error("Failed to load boeing.png");
	}
	if (!this->smokeTexture.loadFromFile("myMedia/smoke.png")) {
		throw std::runtime_error("Failed to load smoke.png");
	}
}

void Plane::initSprite() {
	this->planeSprite.setTexture(planeTexture);
	this->planeSprite.setTextureRect(sf::IntRect(0, 0, this->planeWidth, this->planeHeight));
	this->planeSprite.setPosition(static_cast<float>(this->planeX), static_cast<float>(this->planeY));
	this->smokeSprite.setTexture(smokeTexture);
	this->smokeSprite.setTextureRect(sf::IntRect(0, 0, 96, 96));
	this->smokeSprite.setPosition(static_cast<float>(this->planeX), static_cast<float>(Sum(this->planeY, -30)));
}

Plane::Plane() {
	this->planeWidth = 62;
	this->planeHeight = 25;
	this->planeX = 20;
	this->planeY = 200;
	this->initTexture();
	this->initSprite();
}

Plane::~Plane() {}

void Plane::applyGravity() {
	float fall = static_cast<float>(Sum(0, 1));
	this->planeSprite.move(0.f, fall);
	this->smokeSprite.move(0.f, fall);
}

void Plane::jump() {
	float elevate = static_cast<float>(Sum(0, -30));
	this->planeSprite.move(0.f, elevate);
	this->smokeSprite.move(0.f, elevate);
}

sf::Sprite Plane::getPlane() {return this->planeSprite;}

sf::Sprite Plane::getSmoke() {return this->smokeSprite;}

void Plane::setOriginalPosition() {
	this->planeSprite.setPosition(static_cast<float>(this->planeX), static_cast<float>(this->planeY));
	this->smokeSprite.setPosition(static_cast<float>(this->planeX), static_cast<float>(Sum(this->planeY, -30)));
}

std::vector<int> Plane::getCoordinates() {
	sf::Vector2f planeCoord = this->planeSprite.getPosition();
	int planeX = static_cast<int>(planeCoord.x);
	int planeY = static_cast<int>(planeCoord.y);
	return std::vector<int>{planeX, planeY};
}

int Plane::getPlaneHeight() {return this->planeHeight;}

int Plane::getPlaneWidth() {return this->planeWidth;}
