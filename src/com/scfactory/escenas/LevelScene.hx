package com.scfactory.escenas;

import com.haxepunk.Graphic.ImageType;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.scfactory.characters.Hero;
import com.scfactory.characters.Rehen;
import com.scfactory.elementos.ElementManager;
import com.scfactory.elementos.Superficie;
import com.scfactory.elementos.Plataforma;
import com.scfactory.elementos.Superficie;

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
	
	function crearPlataformas() {
		var t:Plataforma = new Plataforma(800, 300, Image.createRect(100, 40, 0xFF00FF));
			t.setHitbox(100, 40);
			t.hero = hero;
			this.add(t);
			
			t= new Plataforma(900, 290, Image.createRect(100, 40, 0xFF00FF));
			t.setHitbox(100, 40);
			t.hero = hero;
			this.add(t);
			
			t= new Plataforma(1050,100 , Image.createRect(100, 40, 0xFF00FF));
			t.setHitbox(100, 40);
			t.hero = hero;
			this.add(t);
			
			t= new Plataforma(1200, 500, Image.createRect(100, 40, 0xFF00FF));
			t.setHitbox(100, 40);
			t.hero = hero;
			this.add(t);
			
			t= new Plataforma(1350, 450, Image.createRect(100, 40, 0xFF00FF));
			t.setHitbox(100, 40);
			t.hero = hero;
			this.add(t);
			
	}
	
	public function set_hero(hero:Hero):Hero {
			this.hero = hero;
			this.hero.y = 249;
			this.hero.x = 300;
			this.add(hero);
			
			//crearPlataformas();
			for(i in 0...ElementManager.get_Instance().platPool.length)
				this.add(ElementManager.get_Instance().platPool.pop());
			
			var t:Superficie = new Superficie(200, 360, Image.createRect(300, HXP.height-200, 0x0000FF),null,"floor");
			//t.setHitbox(interface., HXP.height-200);
			t.hero = hero;
			this.add(t);
			var re:Rehen = new Rehen(this.hero);
			
			var anim:Spritemap = new Spritemap("img/runner2.png",40, 51);
			anim.add("normal", [0, 1, 2, 3, 4, 5, 6, 7, 8],13);
			
			//this.add(re);
			re.graphic = anim;
				
			return this.hero;
	}
	
	override public function update() 
	{
		super.update();
		this.background.x += 0.05;
		this.camera.x += 3;
		
		
		
		if (hero.y > floor.y + floor.height-hero.height) {
			hero.y = floor.y + floor.height-hero.height;
		}
		if (hero.y < floor.y -hero.height/2) {
			hero.y = floor.y-hero.height/2 ;
		}
		
		
		
	}
	
}