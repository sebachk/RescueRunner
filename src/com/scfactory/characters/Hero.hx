package com.scfactory.characters;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
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
		var run:Bitmap  = new Bitmap(Assets.getBitmapData("img/runner2.png"));
		this.anim = anim;
		
		
		this.graphic = anim;
		playing = false;
	}
	private function animar() {
		anim.play("normal");
		
	}
	
	override public function update() 
	{
		
		animar();
		if (InputManager.getInstance().keyPressed("W")) {
				y--;
		}
		if (InputManager.getInstance().keyPressed("S")) {
				y++;
		}
		
		if (InputManager.getInstance().keyPressed("D")) {
				x++;
		}if (InputManager.getInstance().keyPressed("A")) {
				x--;
		}
		
		super.update();
		height = anim.height;
	}
	
	
	
	
}