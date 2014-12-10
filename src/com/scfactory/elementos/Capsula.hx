package com.scfactory.elementos;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.scfactory.const.ConstantManager;

/**
 * ...
 * @author Sebachk
 */
class Capsula extends Entity
{

	public function new(x:Float=0, y:Float=0) 
	{
		super(x, y);
		this.graphic = new Image("img/escena/capsula.png");
		trace("new Capsula:" + width + " " + height);
		setHitbox(50,50);
		this.type = ConstantManager.TIPO_CAPSULA;
	}
	
	override public function update():Void 
	{
		super.update();
		moveBy(0, 10, [ConstantManager.TIPO_FLOOR, ConstantManager.TIPO_PISO]);
	}
	
	
	
}