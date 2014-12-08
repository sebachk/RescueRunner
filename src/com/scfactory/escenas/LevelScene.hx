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
import com.scfactory.enemigo.Enemigo;
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
	private var superficie:Superficie;
	
	
	private var conf:ConfiguracionNivel;
	
	private var characters:Array<AnimatedCharacter>;
	
	
	
	
	
	
	private static inline var MAX_REHENES:Int = 7;
	var bExit:Button ;
	//Piso
	
	//Frente
	
	
	var estado:String = "jugando";
	
	public var hero(default,set):Hero;
	
	public function new(backgroundImage:ImageType, floor:ImageType) 
	{
		super();
	
		
		characters = new Array<AnimatedCharacter>();
		
		bExit= new Button("Volver al Menu");
		bExit.x = 0;
		bExit.y = 20;
		bExit.addEventListener(Button.CLICKED, exit);
		bExit.followCamera = true;
		bExit.layer = 0;
		
		
		loadPlataformas();
		

		background = new BackGround(backgroundImage, floor);
		background.layer = 15;
		
	}
	
	function exit(_) {
		SceneManager.getInstance().changeScene("menu");
	}
	
	private function loadPlataformas() {
		conf = new ConfiguracionNivel();
	
		conf.add_plataforma(100, 450);
		conf.add_plataforma(700, 450);
		conf.add_plataforma(1200, 350);
		conf.add_plataforma(1700, 250);
		conf.add_plataforma(2600, 350);
		conf.add_plataforma(2700, 150);
		conf.add_plataforma(3300, 450);
		conf.add_plataforma(3600, 350);
		conf.add_plataforma(4000, 450);
		conf.add_plataforma(4700, 450);
		conf.add_plataforma(5500, 350);
		conf.add_plataforma(6000, 350);
		conf.add_plataforma(6000, 250);
		conf.add_plataforma(6500, 250);
		conf.add_plataforma(7500, 150);
		conf.add_plataforma(7500, 450);
		conf.add_plataforma(8000, 250);
		conf.add_plataforma(8000, 450);
		conf.add_plataforma(8400, 350);
		conf.add_plataforma(8900, 350);
	}
	
	public function set_hero(hero:Hero):Hero {
			this.hero = hero;
		return this.hero;
	}
	
	override public function update() 
	{
		super.update();
		
		if (InputManager.getInstance().keyPressed("Q")) {
			trace(conf.x_Actual());
		}
		
		
		if(estado=="jugando"){
			
			this.camera.x += 3;
			
			
			if (Math.random() > 0.99) {
				agregarFaller();
			}
			
			if (Math.random() > 0.989) {
				agregarRehen();
			}
			
			agregarPlat();
			checkRehenes();
		}
	}
	
	private function agregarFaller() {
		var f:Enemigo = ElementManager.get_Instance().useFaller();
		if(f!=null){
			f.x = this.camera.x + HXP.width + 50;
			f.y = Math.random() * HXP.height*0.75;
			
			
			ElementManager.get_Instance().corregiPosicion(f);
			
			this.add(f);
		}
		else {
			trace("No tengo para agregar enemigos");
		}
	}
	
	private function agregarRehen() {
		var r:Rehen = ElementManager.get_Instance().getRehen();
		if (r!=null) {
			r.x = HXP.camera.x + HXP.width +300;
			r.y = Math.random() * HXP.height * 0.75;
			this.add(r);
			
			ElementManager.get_Instance().corregiPosicion(r);
		}
		else {
		
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
			conf.resetPosiciones(this.camera.x+HXP.width);
		}
	}
	
	
	public function rescatarRehen(r:Rehen):Void {
		var ultimo:AnimatedCharacter = characters.pop();
		r.adelante = ultimo;
		characters.push(ultimo);
		characters.push(r);
		
	}
	
	public function MatarCharacter(ch:AnimatedCharacter) {
		if (characters.indexOf(ch) == -1){
			ElementManager.get_Instance().removeRehen(cast(ch, Rehen));
			
			return;
		}
		
		
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
			
			
			if(i<characters.length-1){
				var an:Rehen = cast(characters.slice(i + 1, i+2).pop() , Rehen);
				an.adelante = cast(ch, Rehen).adelante;
			}
			characters.remove(ch);
			
			ElementManager.get_Instance().removeRehen(cast(ch, Rehen));
			
			
		}
		
		
	}
	
	public function checkRehenes() {
		for (r in ElementManager.get_Instance().rehenesEnEscena) {
			if (r.x + 200 < this.camera.x) {
				r.morir();
				
			}
		}
		
	}
	
	override public function begin() 
	{
		super.begin();
		this.sprite.alpha = 1;
		init();
	}
	
	override public function end() 
	{
		super.end();
		this.sprite.scaleX = 1;
		this.sprite.scaleY = 1;
		
		
		ElementManager.get_Instance().reset();
		this.removeAll();
		
		while (characters.length > 0) {
			characters.pop();
		}
		
		estado = "exit";
		
	}
	
	
	private function init() {
		trace("init level");
		estado = "jugando";
		this.camera.x = 0;
		ElementManager.get_Instance().reset();
		if (this.hero == null) {
			trace("new heroe");
			this.hero = new Hero("img/runner2.png");
		}
		
		hero.moveTo(50, 50);
		hero.reset();
		
		this.add(hero);
		this.characters.push(hero);
		
		if(superficie==null){
			superficie = new Superficie(200, 555, null,null,"floor");
			superficie.hero = hero;
		}
		else {
			superficie.reset(200, 555);
		}
		this.add(superficie);
		
		conf.resetPosiciones(0);
		
		this.add(bExit);
		
		this.add(background);
		
	}
	
}