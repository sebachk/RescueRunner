package com.scfactory.characters;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import openfl.Vector;

/**
 * ...
 * @author Sebachk
 */
class Rehen extends Entity
{

	var adelante:Entity;

	var XX:Vector<Float>;
	var YY:Vector<Float>;
	
	public function new(adelante:Entity, x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		this.adelante = adelante;
		this.x = 600;
		this.y = 200;
		this.XX = new Vector();
		this.YY = new Vector();
		
		XX.push(x);
		XX.push(x);
		XX.push(x);
		XX.push(x);
		XX.push(x);
		XX.push(x);
		XX.push(x);
		XX.push(x);
		XX.push(x);
		
		
		YY.push(y);
		YY.push(y);
		YY.push(y);
		YY.push(y);
		YY.push(y);
		YY.push(y);
		YY.push(y);
		YY.push(y);
		YY.push(y);
	}
	
	override public function update():Void 
	{
		super.update();
		
		
		var xx, yy:Float;
		XX.reverse();
		YY.reverse();
		
		xx = XX.pop();
		yy = YY.pop();
		
		XX.reverse();
		YY.reverse();
		
		
		XX.push(adelante.x);
		YY.push(adelante.y);
		
		moveTo(xx, yy);
		
	}
	
}