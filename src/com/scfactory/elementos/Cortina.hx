package com.scfactory.elementos;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import motion.Actuate;

/**
 * ...
 * @author Sebachk
 */
class Cortina extends Entity
{

	var image:Image;
	
	public var entered:Dynamic;
	public var exited:Dynamic;
	
	public function new() 
	{
		super();
		image=Image.createRect(800, 600, 0x000000, 1);
		graphic = image;
		entered = null;
		exited = null;
	}
	
	public function onEnter(){
		Actuate.tween(image, 1, { alpha:1 } ).onComplete(entered);
	}
	
	public function onExit(){
		trace("cortina exited");
		Actuate.tween(image, 1, { alpha:0 } ).onComplete(exited);
	}
	
}