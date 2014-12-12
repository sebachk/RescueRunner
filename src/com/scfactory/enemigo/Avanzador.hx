package com.scfactory.enemigo;
import com.haxepunk.Entity;
import com.scfactory.characters.AnimatedCharacter;
import com.scfactory.const.ConstantManager;
import com.scfactory.escenas.LevelScene;
import openfl._v2.display.BitmapData;

import com.haxepunk.graphics.Spritemap;

/**
 * ...
 * @author Sebachk
 */
class Avanzador extends Enemigo
{

	var avanza:Bool;
	
	private var sprite:Spritemap;
	
	public function new() 
	{
		var b:BitmapData = new BitmapData(30, 40, false, 0x00FF00FF);
		super(b, 30, 40, 30, 40, null);
		velocidad.x = 1;
		velocidad.y = 9;
		avanza = false;
		//setHitbox(30, 40);
		setHitbox(58, 57);
		sprite = new Spritemap("img/enemigo_saltar.png", 58, 57);
        //avanza = true;
        sprite.add("avanza", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 13);
        graphic = sprite;
	}

	override public function update():Void 
	{
		super.update();
		var mov:Float = velocidad.x;
		if (!avanza) {
			mov = -mov;
			
			sprite.flipped = true;
		} else sprite.flipped = false;
		sprite.play("avanza");
		
		moveBy(mov, velocidad.y,[ConstantManager.TIPO_FLOOR,ConstantManager.TIPO_PISO,ConstantManager.TIPO_CHARACTER]);
	}
	
	override public function moveCollideX(e:Entity):Bool 
	{
		avanza = !avanza;
		
		if (e.type == ConstantManager.TIPO_CHARACTER) {
			collideCharacter(cast(e,AnimatedCharacter));
		}
		return super.moveCollideX(e);
		
	}
	
	override public function moveCollideY(e:Entity):Bool 
	{
		if (!super.moveCollideY(e)) {
			avanza = !avanza;
		}
		return true;
	}
	
	
	
}