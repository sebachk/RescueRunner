package com.scfactory.characters;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.masks.Hitbox;
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
class Hero extends Entity
{
	var anim:Spritemap;
	var playing:Bool;
	public function new(anim:Spritemap) 
	{
		
		super();
		this.anim = anim;
		
		this.followCamera = false;
		this.setHitbox(40, 51);
		
		this.graphic = anim;
		playing = false;
		this.type = "solid";
	}
	private function animar() {
		anim.play("normal");
		
	}
	
	override public function update() 
	{
		
		animar();
		
		var nuevoX:Float = this.x;
		var nuevoY:Float = this.y;
		if (InputManager.getInstance().keyPressed("W")) {
				nuevoY--;
		}
		if (InputManager.getInstance().keyPressed("S")) {
				nuevoY++;
		}
		
		if (InputManager.getInstance().keyPressed("D")) {
				nuevoX++;
		}
		if (InputManager.getInstance().keyPressed("A")) {
				nuevoX--;
		}
		var e:Entity = this.collide("piso", nuevoX, nuevoY - 1);
		if (e!=null) {
			
			if (this.y > e.y + e.height) {
				nuevoY++;
			}
			if (this.y+this.height-5 < e.y) {
					nuevoY--;
			}
			else if (this.x + this.width <= e.x){
				nuevoX--;
			}
			
			
		}
		
		this.moveTo(nuevoX, nuevoY);
		super.update();
		height = anim.height;
	}
	
	public var ancho(get, null):Int;
	
	public function get_ancho():Int {
		return this.anim.width;
	}
	
}