package com.scfactory.elementos;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.masks.Hitbox;
import com.scfactory.characters.Hero;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sebachk
 */
class Plataforma extends Entity
{

	public var hero:Hero;
	
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		
		
		super(x, y, Image.createRect(40, 40, 0xFF00FF));
		
		this.setHitbox(40, 40);
		
		this.type = "piso";
		
	}
	
	override public function update():Void 
	{
		super.update();
		
		
	}
	
	override public function moveCollideX(e:Entity):Bool 
	{
		return super.moveCollideX(e);
		
		e.x = this.x - e.width;
	}
	
	
	
	
}