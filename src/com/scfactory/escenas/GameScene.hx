package com.scfactory.escenas;

import com.haxepunk.Scene;
import motion.Actuate;

/**
 * ...
 * @author Sebachk
 */
class GameScene extends Scene
{

	public function new() 
	{
		super();
		
	}
	
	public function onBeginScene() {
		
	}
	
	public function onEndScene() {
		Actuate.tween(this.sprite, 0.5, { scaleX:5, scaleY:5 } ).onComplete(SceneManager.getInstance().putScene);
	}
	
}