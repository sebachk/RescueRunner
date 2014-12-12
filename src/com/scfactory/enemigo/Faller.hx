package com.scfactory.enemigo;
import com.haxepunk.Entity;
import com.haxepunk.graphics.TiledSpritemap;
import com.scfactory.characters.AnimatedCharacter;
import com.scfactory.const.ConstantManager;
import com.scfactory.elementos.ElementManager;
#if html5 
	import openfl.geom.Point;
#else
	import openfl.geom.Point;
#end

/**
 * ...
 * @author Sebachk
 */
class Faller extends Enemigo
{

	private var cayendo:Bool;
	
	
	
	public function new() 
	{
		super("img/faller.png", 150, 261, 150, 261, null);
		cayendo = Math.random()>0.5;
		velocidad = new Point(0, 4);
		
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
		
		moveBy(0, mov, [ConstantManager.TIPO_FLOOR,ConstantManager.TIPO_CHARACTER,ConstantManager.TIPO_PISO]);
		
		if (this.y <= 0) {
			
			cayendo = true;
		}
		
		super.update();
		

	}
	
	
	override public function moveCollideY(e:Entity):Bool 
	{
		
		cayendo = !cayendo;
		
		if (e.type == ConstantManager.TIPO_CHARACTER) {
			collideCharacter(cast(e, AnimatedCharacter));
		}
		
		return super.moveCollideY(e);
		
	}
}