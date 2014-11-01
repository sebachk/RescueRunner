package com.scfactory.characters;

import com.tvj.Animation;
import com.tvj.GameElement;
import openfl.Assets;

/**
 * ...
 * @author Sebachk
 */
class Hero extends GameElement
{
	var anim:Animation;
	public function new() 
	{
		super();
		anim = new Animation(Assets.getBitmapData("img/runner.png"),8,1);
		
		this.addHijo(anim);
		this.addChild(anim);
		
	}
	
}