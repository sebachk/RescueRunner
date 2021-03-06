package com.scfactory.elementos;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.masks.Hitbox;
import com.scfactory.characters.Hero;
import com.scfactory.const.ConstantManager;
import openfl.display.Bitmap;

/**
 * ...
 * @author Sebachk
 */
class Plataforma extends Entity
{

	public var hero:Hero;
	
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Hitbox=null,tipo:String=ConstantManager.TIPO_PISO) 
	{
		
		super(x, y, graphic,mask);
		
		if (mask == null) {
			setHitbox(this.width, this.height);
		}
		this.type = tipo;
		
		
	}
	
	override public function update():Void 
	{
		super.update();
		if(type==ConstantManager.TIPO_PISO)
			if (this.x + this.width < this._camera.x) {
				trace("remove");
				ElementManager.get_Instance().removerPlataforma(this);
		}
		
	}
	
	override public function moveCollideX(e:Entity):Bool 
	{
		return super.moveCollideX(e);
		
		e.x = this.x - e.width;
	}
	
	
	override public function added():Void 
	{
		super.added();
		this.layer = 15;
		
	}
	
	
	
}