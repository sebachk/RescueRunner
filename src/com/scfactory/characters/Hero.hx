package com.scfactory.characters;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Graphic.TileType;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Mask;
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
class Hero extends AnimatedCharacter
{
	var playing:Bool;
	public function new(anim:TileType,x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		super(anim,40,51,40,51,null,x, y, graphic, mask);
		this.anim.add("normal", [0, 1, 2, 3, 4, 5, 6, 7, 8],13);
		
		this.setHitbox(40, 51);
		
		//this.graphic = this.anim;
		
		playing = false;
		this.type = "solid";
	}
	
	
	override public function update() 
	{
		super.update();
		
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
		
	}
	
	public var ancho(get, null):Int;
	
	public function get_ancho():Int {
		return this.anim.width;
	}
	
}