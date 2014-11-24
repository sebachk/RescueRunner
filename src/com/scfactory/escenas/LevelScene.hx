package com.scfactory.escenas;

import com.haxepunk.Graphic.ImageType;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.Scene;
import com.scfactory.characters.Hero;

/**
 * ...
 * @author Sebachk
 */
class LevelScene extends Scene
{

	private var background: Backdrop;
	private var floor:Backdrop;
	
	//Piso
	
	//Frente
	
	public var hero(default,set):Hero;
	
	public function new(backgroundImage:ImageType, floor:ImageType) 
	{
		super();
	
		
		background = new Backdrop(backgroundImage, true, false);
		this.addGraphic(background);
		
		this.floor = new Backdrop(floor, true, false);
		this.addGraphic(this.floor);
		
		this.floor.y = background.height - 3;
		
	}
	
	public function set_hero(hero:Hero):Hero {
			this.hero = hero;
			this.add(hero);
			
			return this.hero;
	}
	
	override public function update() 
	{
		super.update();
		this.background.x += 0.05;
		this.camera.x += 0.1;
		
		
		if (hero.y > floor.y + floor.height-hero.height) {
			hero.y = floor.y + floor.height-hero.height;
		}
		if (hero.y < floor.y -hero.height/2) {
			hero.y = floor.y-hero.height/2 ;
		}
		
	}
	
}