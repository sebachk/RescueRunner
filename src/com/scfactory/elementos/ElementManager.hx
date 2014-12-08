package com.scfactory.elementos;
import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
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
	public static function get_Instance():ElementManager {
		if (instance == null) {
			instance = new ElementManager();
		}
		return instance;
	}
	
	private function loadPlataformaGraphic():Graphic {
		
		
		return Image.createRect(600, 25, 0xFFFF00);
	}
	private function loadPlataformas() {
		var pt:Plataforma;
		
		platPool = new Array<Plataforma>();
		platUsadas = new Array<Plataforma>();
		platPool.push( new Plataforma(200, 300, loadPlataformaGraphic(), new Hitbox(600,25), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(350, 300, loadPlataformaGraphic(), new Hitbox(600,25), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(350, 250, loadPlataformaGraphic(), new Hitbox(600,25), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 300, loadPlataformaGraphic(), new Hitbox(600,25), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(600,25), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(600,25), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(600,25), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(600,25), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(600,25), ConstantManager.TIPO_PISO));
		
		
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
	}
	////////////////ENEMIGOS///////////////////////////
	public function useFaller():Enemigo {
		if (fallerPool.length > 0) {
			var e:Enemigo = fallerPool.shift();
			 enemigosEnEscena.push(e);
			 return e;
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
		var r:Rehen = poolRehenes.pop();
		if (r != null) {
			rehenesEnEscena.push(r);
		}
		
		return r;
	}
	
	public function removeRehen(r:Rehen):Void {
		rehenesEnEscena.remove(r);
		r.adelante = null;
		if (r.scene != null) {
			r.scene.remove(r);
		}
		poolRehenes.push(r);
	}
}