package com.scfactory.characters;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Graphic.TileType;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import com.haxepunk.Mask;
import com.haxepunk.masks.Hitbox;
import com.scfactory.const.ConstantManager;
import com.scfactory.elementos.Capsula;
import com.scfactory.estados.EstadoCharacter;
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
		super(anim,50,50,50,50,null,x, y, graphic, mask);
		this.anim.add("normal", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],13);
		
		
		this.setHitbox(50, 50);
		
		//this.graphic = this.anim;
		
		
		this.type = "solid";
		reset();
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
		
		state.actual = EstadoCharacter.ESTADO_SALTANDO;
		
		//this.moveTo(nuevoX, nuevoY);
		
		if (state.enAire()) {
			velocidad.y += AnimatedCharacter.GRAVITY;
			if (velocidad.y > 0)
				state.actual = EstadoCharacter.ESTADO_CAYENDO;
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
		
		this.moveBy(velocidad.x, velocidad.y, [ConstantManager.TIPO_CAPSULA,ConstantManager.TIPO_PISO,
					ConstantManager.TIPO_FLOOR,ConstantManager.TIPO_CHARACTER]);
		super.update();
		
	}
	
	public var ancho(get, null):Int;
	
	public function get_ancho():Int {
		return this.anim.width;
	}
	
	public function saltar() {
		if(!state.enAire()){
			velocidad.y = -5;
			state.actual = EstadoCharacter.ESTADO_SALTANDO;
			
		}
		
	}
	
	public function piso() {
		if(state.puedeTocarPiso()){
			velocidad.y = 0;
			estado = AnimatedCharacter.ESTADO_CORRIENDO;
			state.actual = EstadoCharacter.ESTADO_CORRIENDO;
		}
		else{
			estado = EstadoCharacter.ESTADO_CAYENDO;
			velocidad.y = 0;
		}
	}
	
	
		
	override public function moveCollideY(e:Entity):Bool 
	{
		//if (ret)
		if (e.type == ConstantManager.TIPO_CAPSULA) {
			this.lScene.salvarRehenes(cast(e, Capsula));
			trace("Collision con Capsula en Y");
			return false;
		}
		if (e.type == ConstantManager.TIPO_CHARACTER) {
			return false;
		}
		var ret:Bool = true; super.moveCollideY(e);
		
		piso();
		
			
		return ret;
	}
	
	
	override public function moveCollideX(e:Entity):Bool 
	{
		
		if (e.type == ConstantManager.TIPO_CAPSULA) {
			trace("Collision con Capsula en X");
			this.lScene.salvarRehenes(cast(e, Capsula));
			return false;
		}
		if (e.type == ConstantManager.TIPO_CHARACTER) {
			var ch:Rehen = cast(e, Rehen);
			if (ch.state.actual == EstadoCharacter.ESTADO_R_EPERANDO) {
				ch.rescatar();
			}
			return false;
		}
		
		return super.moveCollideX(e);
		
		
	
	}
	
	public function reset() {
		velocidad.x = 0;
		velocidad.y = 0;
		
	}
	
	
}