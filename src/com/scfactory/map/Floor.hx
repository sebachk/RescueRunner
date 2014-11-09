package com.scfactory.map;

import com.haxepunk.Entity;
import com.tvj.GameElement;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Sebachk
 */
class Floor extends Entity
{

	var limites:Point;
	public function new(top:Int,bottom:Int) 
	{
		super();
		limites = new Point(top, bottom);
		
	}
	
	override public function updateLogic(time:Float) 
	{
		super.updateLogic(time);
		for (hijo in hijos) {
			
			if (hijo.y < limites.x) hijo.y = limites.x;
			if (hijo.y > limites.y) hijo.y = limites.y;
		}
	}
	
}