package com.scfactory.characters;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.atlas.TextureAtlas;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.TiledSpritemap;
import com.haxepunk.HXP;
import com.haxepunk.Mask;
import openfl._v2.geom.Point;

/**
 * ...
 * @author Sebachk
 */
class AnimatedCharacter extends Entity
{
	var anim:TiledSpritemap;
	
	
	//Movimiento
	
	var velocidad:Point;
	var acceleracion:Point;
	var estado:String;
	
	static var ESTADO_CORRIENDO:String = "CORRIENDO";
	static var ESTADO_SALTANDO:String = "SALTANDO";
	
	static inline var GRAVITY:Float = 0.1;
	static inline var DRAG:Float = 0.2;
	
	static inline var MAXVEL:Float = 6;
	
	public function new(tile:TileType,fw:Int,fh:Int,w:Int,h:Int,cb:Void->Void,x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		
		super(x, y, graphic, mask);
		
		anim = new TiledSpritemap(tile, fw, fh, w, h, cb);
		
		
		this.graphic = anim;
		
		
		velocidad = new Point();
		acceleracion = new Point();
		
		estado = ESTADO_SALTANDO;
	}
	
	override public function update():Void 
	{
		super.update();
		this.animar();
		
		height = anim.height;
		
		

	}
	
	private function animar() {
		anim.play("normal");
		
	}
	
	
	

}