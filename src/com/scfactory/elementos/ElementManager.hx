package com.scfactory.elementos;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Hitbox;

/**
 * ...
 * @author Sebachk
 */
class ElementManager
{
	
	private static var instance:ElementManager;
	
	public var platPool:Array<Plataforma>;
	
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
		platPool.push( new Plataforma(200, 300, loadPlataformaGraphic(), new Hitbox(150,40), "piso"));
		platPool.push(new Plataforma(350, 300, loadPlataformaGraphic(), new Hitbox(150,40), "piso"));
		platPool.push(new Plataforma(350, 250, loadPlataformaGraphic(), new Hitbox(150,40), "piso"));
		platPool.push(new Plataforma(500, 300, loadPlataformaGraphic(), new Hitbox(150,40), "piso"));
		platPool.push(new Plataforma(500, 250, loadPlataformaGraphic(), new Hitbox(150,40), "piso"));
		platPool.push(new Plataforma(700, 250, loadPlataformaGraphic(), new Hitbox(150,40), "piso"));
		platPool.push(new Plataforma(850, 200, loadPlataformaGraphic(), new Hitbox(150,40), "piso"));
		platPool.push(new Plataforma(1100, 200, loadPlataformaGraphic(), new Hitbox(150,40), "piso"));
		platPool.push(new Plataforma(1500, 250, loadPlataformaGraphic(), new Hitbox(150,40), "piso"));
		var x, y:Int;
		x = 1500;
		y = 250;
		
		for (i in 0...50) {
			y +=Std.int((Math.random() * 100) - 50);
			if (y > 300) y = 300;
			x += Std.int(Math.random() * 200 + 150);
			platPool.push(new Plataforma(1500, 250, loadPlataformaGraphic(), new Hitbox(150,40), "piso"));
		
		}
		
	}
	
	public function new() 
	{
		loadPlataformas();
	}
	
}