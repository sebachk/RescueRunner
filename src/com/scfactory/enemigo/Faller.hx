package com.scfactory.enemigo;
import com.haxepunk.Entity;
import com.haxepunk.graphics.TiledSpritemap;
import com.scfactory.characters.AnimatedCharacter;
import com.scfactory.elementos.ElementManager;
import openfl.geom.Point;

/**
 * ...
 * @author Sebachk
 */
class Faller extends AnimatedCharacter
{

	private var cayendo:Bool;
	
	
	
	public function new() 
	{
		super("img/faller.png", 150, 261, 150, 261, null);
		cayendo = true;
		velocidad = new Point(0, 5);
		
		this.anim.scale = 0.2;
		this.anim.scale = 0.2;
		
		setHitbox(30, 53);
	
	}
	
	override public function update():Void 
	{
		
		
		var mov:Int = Std.int(velocidad.y);
		
		if (!cayendo) {
			mov = -mov;
		}
		

		
		moveBy(0, mov, ["floor"]);
		
		if (this.y <= 0) {
			trace("techo");
			cayendo = true;
		}
		
		if (this.x < this._camera.x) {
			ElementManager.get_Instance().killFaller(this);
		}
	}
	
	
	override public function moveCollideY(e:Entity):Bool 
	{
		
		cayendo = false;
		
		return super.moveCollideY(e);
		
	}
}