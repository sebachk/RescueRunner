package com.scfactory.elementos;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.Mask;

/**
 * ...
 * @author Sebachk
 */
class BackGround extends Entity
{

	private var background: Backdrop;
	private var back2:Backdrop;
	private var floor:Backdrop;
	
	public function new(backgroundImage:ImageType, floor:ImageType,x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(x, y, graphic, mask);
		
		this.background = new Backdrop(backgroundImage, true, false);
		this.back2 = new Backdrop("img/escena/estrellas_chicas.png",true,false);
		
		this.floor = new Backdrop(floor, true, false);
		
		this.addGraphic(background);
		this.addGraphic(back2);
		this.addGraphic(this.floor);
		
		this.floor.y = background.height-this.floor.height;
		
		this.followCamera = true;
		
	}
	
	override public function update():Void 
	{
		super.update();
		
		this.background.x -= 0.1;
		this.back2.x -= 0.1;
		this.floor.x -= 1;
	}
	
}