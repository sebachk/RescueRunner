package com.scfactory.escenas;

import com.haxepunk.Graphic.ImageType;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Scene;
import com.scfactory.characters.Hero;
import com.scfactory.characters.Rehen;
import com.scfactory.elementos.Plataforma;

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
		
		var t:Plataforma = new Plataforma(800, 300);
		t.hero = hero;
		this.add(t);
		
		var re:Rehen = new Rehen(this.hero);
		
		var anim:Spritemap = new Spritemap("img/runner2.png",40, 51);
		anim.add("normal", [0, 1, 2, 3, 4, 5, 6, 7, 8],13);
		
		re.graphic = anim;
		
		this.add(re);
		
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
		this.camera.x += 0.8;
		
		
		
		if (hero.y > floor.y + floor.height-hero.height) {
			hero.y = floor.y + floor.height-hero.height;
		}
		if (hero.y < floor.y -hero.height/2) {
			hero.y = floor.y-hero.height/2 ;
		}
		
		
		
	}
	
}