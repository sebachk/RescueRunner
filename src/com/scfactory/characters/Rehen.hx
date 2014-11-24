package com.scfactory.characters;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;

/**
 * ...
 * @author Sebachk
 */
class Rehen extends Entity
{

	public var adelante:Hero;
	
	public function new(adelante:Hero, x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		this.adelante = adelante;
	}
	
	override public function update():Void 
	{
		super.update();
		
		this.x=this.adelante.get_x();
		
		this.y = adelante.y;
	}
	
}