package com.scfactory.enemigo;
import com.haxepunk.Entity;
import com.haxepunk.graphics.TiledSpritemap;
import com.haxepunk.masks.Hitbox;
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
		super("img/faller_vert.png", 90, 63, 90, 63, null);
		cayendo = Math.random()>0.5;
		velocidad = new Point(0, 4);
		anim.add("fly", [0, 1, 2, 3, 4, 5, 6, 7], 30);
		anim.add("fall", [2]);
		//this.anim.scale = 0.2;
		//this.anim.scale = 0.2;
		
		setHitbox(70, 63,10);
		
	}
	
	override public function update():Void 
	{
		
		
		var mov:Int = Std.int(velocidad.y);
		
		if (!cayendo) {
			mov = -mov;
			anim.play("fly");
		}
		else {
			anim.play("fall");
		}
		
		moveBy(0, mov, [ConstantManager.TIPO_FLOOR,ConstantManager.TIPO_CHARACTER,ConstantManager.TIPO_PISO]);
		
		if (this.y <= 0) {
			
			cayendo = true;
		}
		
		super.update();
		

	}
	override function animar() 
	{
		if (!cayendo) {
			
			anim.play("fly");
		}
		else {
			anim.play("fall");
		}
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