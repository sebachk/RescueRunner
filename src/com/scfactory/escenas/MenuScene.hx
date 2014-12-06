package com.scfactory.escenas;
import com.haxepunk.gui.Button;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.Tween;
import com.haxepunk.tweens.motion.LinearMotion;
import com.haxepunk.tweens.motion.LinearPath;
import motion.Actuate;
import openfl.events.Event;
import openfl.events.MouseEvent;


/**
 * ...
 * @author Sebachk
 */
class MenuScene extends GameScene
{
	var botones:List<Button>;
	
	public function new() 
	{
		super();
		botones = new List<Button>();
		
		var start :Button = new Button("START");
		//start.addEventListener(MouseEvent.CLICK, click);
		start.addEventListener(Button.CLICKED, click);
		
		//add(start);
		
		botones.add(start);
		var help:Button = new Button ("Help");
		help.addEventListener(Button.CLICKED, helpClick);
		
		start.x = 100;
		start.y = 100;
		
		help.x = start.x;
		help.y = start.y + start.height + 10;
		botones.add(help);
		//add(help);
	}
	
	public function addButton(buton:Button) {
	
	}
	
	public function click(_) {
		SceneManager.getInstance().changeScene("game");
	}
	
	function helpClick(_) {
		trace("help");
		
	}
	
	override public function begin() 
	{
		
		this.sprite.alpha = 1;
		
		Actuate.tween(HXP.scene.sprite, 0.2, { scaleX:1,scaleY:1 } ).onComplete(beginScene);
		//super.begin();
		
		for (b in botones) {
			this.add(b);
		}
		
	}
	
	private function beginScene() {
		super.begin();
		
	}
	
	override public function end() 
	{
		
		Actuate.tween(HXP.scene.sprite,0.6,{scaleX:5,scaleY:5}).onComplete(endScene);
	}
	
	private function endScene() {
		trace("END MENU");
		super.end();
		
	}
	
}