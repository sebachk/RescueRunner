package com.scfactory.elementos;
import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.masks.Hitbox;
import com.scfactory.characters.Rehen;
import com.scfactory.const.ConstantManager;
import com.scfactory.enemigo.Avanzador;
import com.scfactory.enemigo.Enemigo;
import com.scfactory.enemigo.Faller;

/**
 * ...
 * @author Sebachk
 */
class ElementManager
{
	
	private static var instance:ElementManager;
	
	public var platPool:Array<Plataforma>;
	
	public var platUsadas:Array<Plataforma>;
	
	
	public var poolRehenes:Array<Rehen>;
	public var rehenesEnEscena:Array<Rehen>;
	//Enemigos
	public var fallerPool:Array<Enemigo>;
	public var enemigosEnEscena:Array<Enemigo>;
	
	
	private var capsula:Capsula;
	
	private var intervaloEnemigo:Float;
	private var intervaloRehen:Float;
	private var intervaloCapsula:Float;
	
	
	private var inicEnemigo:Float;
	private var inicRehen:Float;
	private var inicCapsula:Float;
	
	private var dificultad:Float = 30;
	
	
	public var velocidadCamara:Float;
	
	public static function get_Instance():ElementManager {
		if (instance == null) {
			instance = new ElementManager();
		}
		return instance;
	}
	
	private function loadPlataformaGraphic():Graphic {
		
		
		return Image.createRect(600, 30, 0xFFFF00);
	}
	private function loadPlataformas() {
		var pt:Plataforma;
		
		platPool = new Array<Plataforma>();
		platUsadas = new Array<Plataforma>();
		platPool.push( new Plataforma(200, 300, loadPlataformaGraphic(), new Hitbox(600,30), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(350, 300, loadPlataformaGraphic(), new Hitbox(600,30), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(350, 250, loadPlataformaGraphic(), new Hitbox(600,30), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 300, loadPlataformaGraphic(), new Hitbox(600,30), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(600,30), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(600,30), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(600,30), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(600,30), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(600,30), ConstantManager.TIPO_PISO));
		
		
	}
	
	public function loadFaller() {
		fallerPool = new Array<Enemigo>();
		enemigosEnEscena = new Array<Enemigo>();
		
		for (i in 0...7) {
			if (Math.random() > 0.7) {
				fallerPool.push(new Avanzador());
				trace("avanzador");
				
			}
			else {
				fallerPool.push(new Faller());
				trace("faller");
			}
		}
		
		
	}
	
	public function loadRehenes() {
		poolRehenes = new Array<Rehen>();
		rehenesEnEscena = new Array<Rehen>();
		
		for (i in 0...6) {
			poolRehenes.push(new Rehen());
		}
	}
	
	public function new() 
	{
		loadPlataformas();
		
		loadFaller();
		
		loadRehenes();
		
		inicCapsula = 60;
		inicEnemigo = 6;
		inicRehen = 4;
		
		resetContadores();
		
		
		capsula = new Capsula();
	}
	
	public function resetContadores() {
		intervaloCapsula = inicCapsula;
		intervaloEnemigo = inicEnemigo;
		intervaloRehen = inicRehen;
		velocidadCamara = 2;
	}
	
	////////////////ENEMIGOS///////////////////////////
	public function useFaller():Enemigo {
		
		if(intervaloEnemigo<0){
			intervaloEnemigo = inicEnemigo;
		
			if (fallerPool.length > 0) {
				var e:Enemigo = fallerPool.shift();
				 enemigosEnEscena.push(e);
				 return e;
			}
		}
		return null;
	}
	
	public function killFaller(faller:Enemigo){
		if (faller.scene != null) {
			faller.scene.remove(faller);
		}
		enemigosEnEscena.remove(faller);
		fallerPool.push(faller);
	}
	
	///////////////////////////////////////////////
	//////////////////////////////////////////////
	
	
	public function usePlataforma(x:Float, y:Float):Plataforma {
		var p:Plataforma = platPool.pop();
		platUsadas.push(p);
		if(p!=null){
			p.x = x;
			p.y = y;
			
			return p;
		}
		return null;
	}
	
	public function removerPlataforma(p:Plataforma) {
		if (p.scene != null) {
			p.scene.remove(p);
		}
		
		platPool.push(p);
		platUsadas.remove(p);
	}
	
	
	public function reset() {
		
		while (platUsadas.length > 0) {
			platPool.push(platUsadas.pop());
		}
		
		while (enemigosEnEscena.length > 0) {
			fallerPool.push(enemigosEnEscena.pop());
		}
		
		while (rehenesEnEscena.length > 0) {
			poolRehenes.push(rehenesEnEscena.pop());
		}
		
		resetContadores();
	}
	/////////////////////////////////////////////////
	
	public function corregiPosicion(e:Entity) {
		for (plat in platUsadas) {
			if (e.collideWith(plat, e.x, e.y)!=null) {
				if (e.y + e.height < plat.y + plat.halfHeight) {
					e.y = plat.y - e.height - 1;
				}
				else {
					e.y = plat.y + plat.height + 1;
				}
				trace("CORRIGIENDO");
				return;
			}
		}
	}
	
	///////////////////////////////////////////////////
	
	public function getRehen():Rehen {
		if (intervaloRehen < 0) {
			intervaloRehen = inicRehen;
			
			var r:Rehen = poolRehenes.pop();
			if (r != null) {
				rehenesEnEscena.push(r);
				return r;
			}
		}
		return null;
	}
	
	public function removeRehen(r:Rehen):Void {
		rehenesEnEscena.remove(r);
		r.adelante = null;
		if (r.scene != null) {
			r.scene.remove(r);
		}
		poolRehenes.push(r);
	}
	
	
	public function getCapsula():Capsula {
		if (intervaloCapsula < 0) {
			intervaloCapsula = inicCapsula;
			
			return capsula;
		}
		return null;
	}
	
	
	public function removeCapsula() {
		if (capsula.scene != null) {
			capsula.scene.remove(capsula);
		}
	}
	
	public function update() {
		
		intervaloCapsula -= HXP.elapsed;
		intervaloEnemigo -= HXP.elapsed;
		intervaloRehen -= HXP.elapsed;
		
		dificultad -= HXP.elapsed;
		if (dificultad < 0) {
			dificultad = 30;
			inicCapsula += velocidadCamara*0.25;
			inicEnemigo -= velocidadCamara * 0.25;
			inicRehen += velocidadCamara*0.25;
			velocidadCamara += 0.5;
		}
		
	}
}