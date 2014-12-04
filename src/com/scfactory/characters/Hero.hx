package com.scfactory.characters;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Graphic.TileType;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import com.haxepunk.Mask;
import com.haxepunk.masks.Hitbox;
import com.scfactory.const.ConstantManager;
import com.tvj.Animation;
import com.tvj.GameElement;
import com.tvj.InputManager;
import openfl.display.Bitmap;
import openfl.display.BitmapData;


import openfl.Assets;
import openfl.display.Sprite;

/**
 * ...
 * @author Sebachk
 */
class Hero extends AnimatedCharacter
{
	var playing:Bool;
	public function new(anim:TileType,x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(anim,40,51,40,51,null,x, y, graphic, mask);
		this.anim.add("normal", [0, 1, 2, 3, 4, 5, 6, 7, 8],13);
		
		trace("cree un: " + this.toString());
		this.setHitbox(40, 51);
		
		//this.graphic = this.anim;
		
		playing = false;
		this.type = "solid";
	}
	
	
	override public function update() 
	{
		
		var nuevoX:Float = this.x;
		var nuevoY:Float = this.y;
		
		acceleracion.x = 0;
		
		if (InputManager.getInstance().keyPressed("W")) {
				saltar();
		}
		if (InputManager.getInstance().keyPressed("S")) {
				//nuevoY++;
		}
		
		if (InputManager.getInstance().keyPressed("D")) {
				acceleracion.x = 2;
		}
		if (InputManager.getInstance().keyPressed("A")) {
				acceleracion.x = -2;
		}
		estado = AnimatedCharacter.ESTADO_SALTANDO;
		
		
		//this.moveTo(nuevoX, nuevoY);
		
		if (estado == AnimatedCharacter.ESTADO_SALTANDO) {
				velocidad.y += AnimatedCharacter.GRAVITY;
			
			//if (this.y > 300) {//piso
				//this.y = 300;
				//piso();
			//}
		}
		
		velocidad.x += acceleracion.x;
		
		
		
		if (Math.abs(velocidad.x) > AnimatedCharacter.MAXVEL) {
				velocidad.x = AnimatedCharacter.MAXVEL * HXP.sign(velocidad.x);
		}
		if(velocidad.x>0){
			velocidad.x = Math.max(velocidad.x - AnimatedCharacter.DRAG, 2);
			anim.flipped = false;
		}if(velocidad.x<0) {
			velocidad.x = Math.min(velocidad.x + AnimatedCharacter.DRAG, -2);
			anim.flipped = true;
		}
		
		this.moveBy(velocidad.x, velocidad.y,[ConstantManager.TIPO_PISO,ConstantManager.TIPO_FLOOR,ConstantManager.TIPO_CHARACTER]);
		super.update();
		
	}
	
	public var ancho(get, null):Int;
	
	public function get_ancho():Int {
		return this.anim.width;
	}
	
	public function saltar() {
		if(estado!=AnimatedCharacter.ESTADO_SALTANDO){
			velocidad.y = -5;
			estado = AnimatedCharacter.ESTADO_SALTANDO;
		}
		
	}
	
	public function piso() {
		if(estado!=AnimatedCharacter.ESTADO_CORRIENDO){
			velocidad.y = 0;
			estado = AnimatedCharacter.ESTADO_CORRIENDO;
		}
	}
	
	
		
	override public function moveCollideY(e:Entity):Bool 
	{
		//if (ret)
		if (e.type == ConstantManager.TIPO_CHARACTER) {
			return false;
		}
		var ret:Bool = true; super.moveCollideY(e);
		
		piso();
		
			
		return ret;
	}
	
	
	override public function moveCollideX(e:Entity):Bool 
	{
		
		if (e.type == ConstantManager.TIPO_CHARACTER) {
			var ch:Rehen = cast(e, Rehen);
			if (ch.estado == AnimatedCharacter.ESTADO_R_ESPERANDO) {
				ch.rescatar();
			}
			return false;
		}
		return super.moveCollideX(e);
	
	}
	
	
}