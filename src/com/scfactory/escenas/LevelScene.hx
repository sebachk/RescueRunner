package com.scfactory.escenas;

import com.haxepunk.Graphic.ImageType;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.gui.Button;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.scfactory.characters.AnimatedCharacter;
import com.scfactory.characters.Hero;
import com.scfactory.characters.Rehen;
import com.scfactory.elementos.BackGround;
import com.scfactory.elementos.ConfiguracionNivel;
import com.scfactory.elementos.ElementManager;
import com.scfactory.elementos.Superficie;
import com.scfactory.elementos.Plataforma;
import com.scfactory.elementos.Superficie;
import com.scfactory.enemigo.Faller;
import com.tvj.InputManager;
import openfl._v2.geom.Point;

/**
 * ...
 * @author Sebachk
 */
class LevelScene extends GameScene
{

	private var background: BackGround;
	
	private var conf:ConfiguracionNivel;
	
	private var characters:Array<AnimatedCharacter>;
	
	
	private var rehenesEnEscena:Array<Rehen>;
	
	private static inline var MAX_REHENES:Int = 7;
	var bExit:Button ;
	//Piso
	
	//Frente
	
	
	var estado:String = "jugando";
	
	public var hero(default,set):Hero;
	
	public function new(backgroundImage:ImageType, floor:ImageType) 
	{
		super();
	
		rehenesEnEscena = new Array<Rehen>();
		characters = new Array<AnimatedCharacter>();
		
		bExit= new Button("Volver al Menu");
		bExit.x = 150;
		bExit.y = 100;
		bExit.addEventListener(Button.CLICKED, exit);
		this.add(bExit);
		
		
		
		bExit.followCamera = true;
		bExit.layer = 0;
		
		
		conf = new ConfiguracionNivel();
		loadPlataformas();
		
		background = new BackGround(backgroundImage, floor);
		this.add(background);
		background.layer = 15;
		
	}
	
	function exit(_) {
		SceneManager.getInstance().changeScene("menu");
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
			//this.bringToFront(bExit);
		
			this.hero = hero;
			this.hero.y = 150;
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
		
		if (InputManager.getInstance().keyPressed("Q")) {
			trace(hero.layer + "..." + bExit.layer + "...");
		}
		
		
		if(estado=="jugando"){
			
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
			checkRehenes();
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
		if(rehenesEnEscena.length<MAX_REHENES){
			var r:Rehen = new Rehen(null,HXP.camera.x + HXP.width +30,Math.random() * HXP.height / 2);
			this.add(r);
			rehenesEnEscena.push(r);
		}
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
			rehenesEnEscena.remove(cast(ch,Rehen));
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
		
		
	}
	
	public function checkRehenes() {
		for (r in rehenesEnEscena) {
			if (r.x + 200 < this.camera.x) {
				trace(rehenesEnEscena.length);		
				rehenesEnEscena.remove(r);
				this.remove(r);
			}
		}
		
	}
	
	override public function begin() 
	{
		super.begin();
		this.sprite.alpha = 1;
	}
	
}