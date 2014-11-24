package com.scfactory.gui;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import openfl.display.Sprite;

/**
 * ...
 * @author Sebachk
 */
class Button extends Entity
{
	public var over(default, default):Graphic;
	public var down(default, default):Graphic;
	public var up(default, default):Graphic;
	public var normal(default, default):Graphic;
	
	
	
	public function new(x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, null, mask);
		
		normal = down=up=down=graphic;
		
	}
	
	
}