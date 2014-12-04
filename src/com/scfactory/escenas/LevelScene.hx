package com.scfactory.escenas;

import com.haxepunk.Graphic.ImageType;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.scfactory.characters.AnimatedCharacter;
import com.scfactory.characters.Hero;
import com.scfactory.characters.Rehen;
import com.scfactory.elementos.ConfiguracionNivel;
import com.scfactory.elementos.ElementManager;
import com.scfactory.elementos.Superficie;
import com.scfactory.elementos.Plataforma;
import com.scfactory.elementos.Superficie;
import com.scfactory.enemigo.Faller;
import openfl._v2.geom.Point;

/**
 * ...
 * @author Sebachk
 */
class LevelScene extends Scene
{

	private var background: Backdrop;
	private var floor:Backdrop;
	private var conf:ConfiguracionNivel;
	
	private var characters:Array<AnimatedCharacter>;
	
	//Piso
	
	//Frente
	
	
	var estado:String = "jugando";
	
	public var hero(default,set):Hero;
	
	public function new(backgroundImage:ImageType, floor:ImageType) 
	{
		super();
	
		characters = new Array<AnimatedCharacter>();
		background = new Backdrop(backgroundImage, true, false);
		this.addGraphic(background);
		
		this.floor = new Backdrop(floor, true, false);
		this.addGraphic(this.floor);
		
		this.floor.y = background.height-this.floor.height;
		
		
		conf = new ConfiguracionNivel();
		loadPlataformas();
	}
	
	private function loadPlataformas() {
		conf.add_plataforma(100, 300);
		conf.add_plataforma(300, 250);
		conf.add_plataforma(500, 200);
		conf.add_plataforma(700, 225);
		conf.add_plataforma(900, 250);
		conf.add_plataforma(1100, 275);
		conf.add_plataforma(1300, 300);
		conf.add_plataforma(1500, 250);
		conf.add_plataforma(1700, 200);
		conf.add_plataforma(1900, 350);
		conf.add_plataforma(2100, 300);
		conf.add_plataforma(2300, 250);
		conf.add_plataforma(2500, 200);
		conf.add_plataforma(2700, 100);
		conf.add_plataforma(2900, 150);
		conf.add_plataforma(3100, 300);
		conf.add_plataforma(3300, 350);
		conf.add_plataforma(3500, 300);
	}
	
	public function set_hero(hero:Hero):Hero {
			this.hero = hero;
			this.hero.y = 100;
			this.hero.x = 100;
			this.add(hero);
			this.characters.push(hero);
			
			var t:Superficie = new Superficie(200, 555, null,null,"floor");
			//t.setHitbox(interface., HXP.height-200);
			t.hero = hero;
			this.add(t);
			var re:Rehen;
			
			//var anim:Spritemap = new Spritemap("img/runner2.png",40, 51);
			//anim.add("normal", [0, 1, 2, 3, 4, 5, 6, 7, 8],13);
			
			//for (i in 0...3) {
				//re = new Rehen();
				//this.add(re);
				//rescatarRehen(re);
			//}
			//
			return this.hero;
	}
	
	override public function update() 
	{
		super.update();
		
		if(estado=="jugando"){
			this.background.x += 2.5;
			this.floor.x += 1.5;
			this.camera.x += 3;
			
			
			
			//if (hero.y > floor.y + floor.height-hero.height) {
				//hero.y = floor.y + floor.height-hero.height;
			//}
			//if (hero.y < floor.y -hero.height/2) {
				//hero.y = floor.y-hero.height/2 ;
			//}
			
			if (Math.random() > 0.997) {
				agregarFaller();
			}
			
			if (Math.random() > 0.98) {
				agregarRehen();
			}
			
			agregarPlat();
		}
	}
	
	private function agregarFaller() {
		var f:Faller = ElementManager.get_Instance().useFaller();
		if(f!=null){
			f.x = this.camera.x + HXP.width + 50;
			f.y = Math.random() * HXP.height / 2;
			
			
			this.add(f);
		}
	}
	
	private function agregarRehen() {
		var r:Rehen = new Rehen(null,HXP.camera.x + HXP.width * 2,Math.random() * (HXP.height / 2));

		this.add(r);
	}
	
	private function agregarPlat() {
		var x:Float = conf.x_Actual();
		if(x!=null){
			if (x < this.camera.x + HXP.width + 100) {
				var p:Point = conf.get_Next();
				
				this.add(ElementManager.get_Instance().usePlataforma(p.x, p.y));
			}
		}
		else {
			conf.resetPosiciones(this.camera.x + HXP.width + 50);
		}
	}
	
	
	public function rescatarRehen(r:Rehen):Void {
		var ultimo:AnimatedCharacter = characters.pop();
		r.adelante = ultimo;
		characters.push(ultimo);
		characters.push(r);
		
	}
	
	public function MatarCharacter(ch:AnimatedCharacter) {
		var it:Iterator<AnimatedCharacter> = characters.iterator();
		///lo salteo al heroe
		var atras:Rehen;
		var rem:AnimatedCharacter;
		trace(ch.toString());
		if (ch.toString() == hero.toString()) {
			
			while (it.hasNext()) {
				this.remove(it.next());
			}
			estado = "perdio";
			characters = characters.splice(0, 0);
		}
		else {
			var i:Int = characters.indexOf(ch);
			trace(characters.length, i);
			
			if(i<characters.length-1){
				var an:Rehen = cast(characters.slice(i + 1, i+2).pop() , Rehen);
				an.adelante = cast(ch, Rehen).adelante;
			}
			characters.remove(ch);
			this.remove(ch);
			//it.next();
			//;
			//while (it.hasNext()) {
				//an = cast(it.next(),Rehen);
				//if(ch.distanceToPoint(an.adelante.x, an.adelante.y)==0){
					//an.adelante = cast(ch, Rehen).adelante;
					//characters.remove(an.adelante);	
					//this.remove(ch);
					//break;
				//}
				//
			//}
		}
		
		
		trace("Tamanio:" + characters.length);
	}
	
}