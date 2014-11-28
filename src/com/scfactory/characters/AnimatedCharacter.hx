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
		
		anim.active = true;
		
		anim.visible = true;
		
		trace(anim.frameCount);
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
		
		
		if (estado == ESTADO_SALTANDO) {
				velocidad.y += GRAVITY;
			
			//if (this.y > 300) {//piso
				//this.y = 300;
				//piso();
			//}
		}
		
		velocidad.x += acceleracion.x;
		
		
		
		if (Math.abs(velocidad.x) > MAXVEL) {
				velocidad.x = MAXVEL * HXP.sign(velocidad.x);
		}
		if(velocidad.x>0){
			velocidad.x = Math.max(velocidad.x - DRAG, 0);
			anim.flipped = false;
		}if(velocidad.x<0) {
			velocidad.x = Math.min(velocidad.x + DRAG, 0);
			anim.flipped = true;
		}
		
		this.moveBy(velocidad.x, velocidad.y,["piso","floor"]);

	}
	
	private function animar() {
		anim.play("normal");
		
	}
	
	
	public function saltar() {
		if(estado!=ESTADO_SALTANDO){
			velocidad.y = -4;
			estado = ESTADO_SALTANDO;
		}
		
	}
	
	public function piso() {
		if(estado!=ESTADO_CORRIENDO){
			velocidad.y = 0;
			estado = ESTADO_CORRIENDO;
		}
	}
	
	override public function moveCollideY(e:Entity):Bool 
	{
		var ret:Bool = true; super.moveCollideY(e);
		//if (ret)
			piso();
		
			
		return ret;
	}
	
	
	override public function moveCollideX(e:Entity):Bool 
	{
		var ret=super.moveCollideX(e);
		
		return (e.type == "piso");
		
	}
}