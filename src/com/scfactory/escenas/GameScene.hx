package com.scfactory.escenas;

import com.haxepunk.Scene;
import com.scfactory.elementos.Cortina;
import motion.Actuate;

/**
 * ...
 * @author Sebachk
 */
class GameScene extends Scene
{

	var cortina:Cortina;
	
	var estado:String = "jugando";
	
		
	public function new() 
	{
		super();
		cortina = new Cortina();
		
		cortina.entered = SceneManager.getInstance().putScene;
		cortina.exited = exiting;
		this.add(cortina);
		cortina.layer = -10;
		
	}
	
	override public function begin() 
	{
		super.begin();
		init();
		cortina.onExit();
		
	}
	
	public function init() {
		
	}
	
	public function exiting() {
		this.estado = "jugando";
	}
	public function onEndScene() {
		cortina.onEnter();
		
		//Actuate.tween(this.sprite, 0.5, { scaleX:5, scaleY:5 } ).onComplete(SceneManager.getInstance().putScene);
	}
	
}