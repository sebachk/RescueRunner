package com.scfactory.escenas;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Image;
import com.haxepunk.gui.Button;
import com.haxepunk.gui.Control;
import com.haxepunk.gui.Panel;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.Tween;
import com.haxepunk.tweens.motion.LinearMotion;
import com.haxepunk.tweens.motion.LinearPath;
import com.scfactory.elementos.Cortina;
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
	var back:Entity;
	
	
	public function new() 
	{
		super();
		back = new Entity();
		back.addGraphic(new Image("img/Menu/portada.png"));
		this.add(back);
		back.layer = 15;
		botones = new List<Button>();
		Control.useSkin("img/Skins/GameSkin.png");
		
		var start :Button = new Button("START",0,0,50,30);
		//start.addEventListener(MouseEvent.CLICK, click);
		start.addEventListener(Button.CLICKED, click);
		start.layer = 0;
		
		//add(start);
		
		botones.add(start);
		var help:Button = new Button ("Help",0,0,50,30);
		help.addEventListener(Button.CLICKED, helpClick);
		start.font = "Impact";
		start.size = 16;
		start.x = HXP.halfWidth-start.halfWidth;
		start.y = HXP.halfHeight-start.halfHeight;
		
		help.x = start.x;
		help.y = start.y + start.height + 10;
		help.layer = 0;
		help.size = 16;
		help.font = "impact";
		botones.add(help);
		
		
		
		//add(help);
	}
	
	override public function init() {
		trace("scene inited");
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
		
		
		//super.begin();
		
		for (b in botones) {
			this.add(b);
		}
		super.begin();
	}
	
	private function beginScene() {
		super.begin();
		
	}
	
	override public function onEndScene() 
	{
		cortina.onEnter();
		//Actuate.tween(HXP.scene.sprite,0.6,{scaleX:5,scaleY:5}).onComplete(endScene);
	}
	
	private function endScene() {
		super.end();
		//super.end();
		
	}
	
}