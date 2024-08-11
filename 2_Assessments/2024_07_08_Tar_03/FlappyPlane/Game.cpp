/*
 Copyright 2024 "Charlie's Angels"
	   <HENOC.ROJAS@ucr.ac.cr>
	   <BRAUNNY.MADRIGAL@ucr.ac.cr>
	   <KENDALL.VILLAFUERTE@ucr.ac.cr>
	   <MARCELO.PICADO@ucr.ac.cr>
	   <RODRIGO.CARBALLO@ucr.ac.cr>
*/

#include "Game.hpp"

void Game::initWindow() {
	this->videoMode.height = WINDOW_HEIGHT;
	this->videoMode.width = WINDOW_WIDTH;
	this->windowName = "Flappy Plane";
	this->window = new sf::RenderWindow(videoMode, windowName, sf::Style::Close);
	this->window->setFramerateLimit(60);
}

Game::Game() {
	this->gameScore = 0;
	this->initWindow();
	this->gameState = GameState::MainMenu;
}

Game::~Game() {delete this->window;}

void Game::update() {this->pollEvents();}

void Game::render() {
	switch (this->gameState) {
	case GameState::MainMenu:
		this->window->clear(sf::Color::Cyan);
		this->window->draw(this->plane.getPlane());
		this->window->draw(this->towers.getTLeftTop());
		this->window->draw(this->towers.getTLeftBot());
		this->window->draw(this->towers.getTRighTop());
		this->window->draw(this->towers.getTRighBot());
		this->window->draw(this->text.getTextScore());
		this->window->draw(this->button.getButtonHelp());
		this->window->draw(this->button.getButtonPlay());
		this->window->draw(this->text.getTextTitle());
		this->window->display();
		break;
	case GameState::HelpMenu:
		this->window->clear(sf::Color::Cyan);
		this->window->draw(this->text.getTextInfo());
		this->window->draw(this->button.getButtonPlay());
		this->window->display();
		break;
	case GameState::Playing:
		this->window->clear(sf::Color::Cyan);
		this->window->draw(this->plane.getPlane());
		this->window->draw(this->towers.getTLeftTop());
		this->window->draw(this->towers.getTLeftBot());
		this->window->draw(this->towers.getTRighTop());
		this->window->draw(this->towers.getTRighBot());
		this->window->draw(this->text.getTextScore());
		this->window->display();
		break;
	case GameState::GameOver:
		this->window->clear(sf::Color::Cyan);
		this->window->draw(this->plane.getPlane());
		this->window->draw(this->towers.getTLeftTop());
		this->window->draw(this->towers.getTLeftBot());
		this->window->draw(this->towers.getTRighTop());
		this->window->draw(this->towers.getTRighBot());
		this->window->draw(this->plane.getSmoke());
		this->window->draw(this->text.getTextScore());
		this->window->draw(this->button.getButtonHelp());
		this->window->draw(this->button.getButtonPlay());
		this->window->display();
		break;
	default:
		std::cerr << "Unknown state" << std::endl;
		break;
	}
}

const bool Game::isRunning() const {return this->window->isOpen();}

void Game::pollEvents() {
	while (this->window->pollEvent(this->event)) {
		switch (this->event.type) {
		case sf::Event::Closed:
			this->window->close();
			break;
		case sf::Event::MouseButtonPressed:
			if (this->event.mouseButton.button == sf::Mouse::Left) {
				if (this->gameState == GameState::MainMenu) {
					int mouseX = this->event.mouseButton.x;
					int mouseY = this->event.mouseButton.y;
					if (this->button.isButtonHelpClicked(mouseX, mouseY)) {
						this->audios.playClickSound();
						this->gameState = GameState::HelpMenu;
					}
					else if (this->button.isButtonPlayClicked(mouseX, mouseY)) {
						this->audios.playClickSound();
						this->gameState = GameState::Playing;
					}
				}
				else if (this->gameState == GameState::HelpMenu) {
					int mouseX = this->event.mouseButton.x;
					int mouseY = this->event.mouseButton.y;
					if (this->button.isButtonPlayClicked(mouseX, mouseY)) {
						this->audios.playClickSound();
						this->gameState = GameState::Playing;
					}
				}
				else if (this->gameState == GameState::Playing) {
					this->audios.playJumpSound();
					this->plane.jump();
				}
				else if (this->gameState == GameState::GameOver) {
					int mouseX = this->event.mouseButton.x;
					int mouseY = this->event.mouseButton.y;
					if (this->button.isButtonHelpClicked(mouseX, mouseY)) {
						this->audios.playClickSound();
						this->plane.setOriginalPosition();
						this->towers.setOriginalPosition();
						this->gameScore = 0;
						this->gameState = GameState::HelpMenu;
					}
					else if (this->button.isButtonPlayClicked(mouseX, mouseY)) {
						this->audios.playClickSound();
						this->plane.setOriginalPosition();
						this->towers.setOriginalPosition();
						this->gameScore = 0;
						this->gameState = GameState::Playing;
					}
				}
				else {
					std::cerr << "Unknown state" << std::endl;
				}
			}
			break;
		default:
			break;
		}
	}
	if (this->gameState == GameState::Playing) {
		this->plane.applyGravity();
		this->towers.moveTowers();
		if (this->checkCollisions()) {
			this->audios.playBombSound();
			this->gameState = GameState::GameOver;
		}
		else {
			this->updateGameScore();
			this->text.setTextScore(this->gameScore);
		}
	}
}

void Game::updateGameScore() {
	int planeX = this->plane.getCoordinates()[0];
	int towerW = this->towers.getTowerWidth();
	int towerLX = this->towers.getCoordinates()[0];
	int towerRX = this->towers.getCoordinates()[4];
	towerLX = Sum(towerLX, towerW);
	towerRX = Sum(towerRX, towerW);
	if (getGameScore(planeX, towerLX, towerRX) == 1) {
		this->gameScore = Sum(this->gameScore, 1);
		this->audios.playCoinSound();
	}
}

bool Game::checkCollisions() {
	int i = 0;
	bool collision = false;
	int planeH = this->plane.getPlaneHeight();
	int planeW = this->plane.getPlaneWidth();
	int planeX = this->plane.getCoordinates()[0];
	int planeY = this->plane.getCoordinates()[1];
	int towerH = this->towers.getTowerHeight();
	int towerW = this->towers.getTowerWidth();
	std::vector<int> towersC = this->towers.getCoordinates();
	if (planeY > 400 || planeY < 0) {
		collision = true;
	}
	while (!collision && i < 8) {
		int towerX = Sum(towersC[i], towerW);
		int towerY = Sum(towersC[Sum(i,1)], towerH);
		int planeWX = Sum(planeX, planeW);
		int planeHY = Sum(planeY, planeH);

		bool collision1 = collisions(towerX, planeX, towerY, planeY) == 1;
		bool collision2 = collisions(planeWX, towersC[i], planeHY, towersC[Sum(i,1)]) == 1;
		collision = collision1 && collision2;
		if (!collision) {
			i = Sum(i,2);
		}
	}
	return collision;
}
