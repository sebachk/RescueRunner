package com.scfactory.elementos;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Hitbox;
import com.scfactory.const.ConstantManager;
import com.scfactory.enemigo.Faller;

/**
 * ...
 * @author Sebachk
 */
class ElementManager
{
	
	private static var instance:ElementManager;
	
	public var platPool:Array<Plataforma>;
	
	
	//Enemigos
	public var fallerPool:Array<Faller>;
	
	public static function get_Instance():ElementManager {
		if (instance == null) {
			instance = new ElementManager();
		}
		return instance;
	}
	
	private function loadPlataformaGraphic():Graphic {
		return Image.createRect(150, 40, 0xFFFF00);
	}
	private function loadPlataformas() {
		var pt:Plataforma;
		
		platPool = new Array<Plataforma>();
		platPool.push( new Plataforma(200, 300, loadPlataformaGraphic(), new Hitbox(150,40), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(350, 300, loadPlataformaGraphic(), new Hitbox(150,40), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(350, 250, loadPlataformaGraphic(), new Hitbox(150,40), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 300, loadPlataformaGraphic(), new Hitbox(150,40), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(150,40), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(150,40), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(150,40), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(150,40), ConstantManager.TIPO_PISO));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(150,40), ConstantManager.TIPO_PISO));
		
		
	}
	
	public function loadFaller() {
		fallerPool = new Array<Faller>();
		
		fallerPool.push(new Faller());
		fallerPool.push(new Faller());
		fallerPool.push(new Faller());
		
	}
	
	public function new() 
	{
		loadPlataformas();
		
		loadFaller();
	}
	////////////////ENEMIGOS///////////////////////////
	public function useFaller():Faller {
		if (fallerPool.length > 0) {
			return fallerPool.pop();
		}
		return null;
	}
	
	public function killFaller(faller:Faller){
		if (faller.scene != null) {
			faller.scene.remove(faller);
		}
		
		fallerPool.push(faller);
	}
	
	///////////////////////////////////////////////
	//////////////////////////////////////////////
	
	
	public function usePlataforma(x:Float, y:Float):Plataforma {
		var p:Plataforma = platPool.pop();
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
	}
	///////////////////////////////////////////////////
	
	
}