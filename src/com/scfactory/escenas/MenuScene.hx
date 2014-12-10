package com.scfactory.escenas;
import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Image;
import com.haxepunk.gui.Button;
import com.haxepunk.gui.Control;
import com.haxepunk.gui.FormatAlign;
import com.haxepunk.gui.graphic.NineSlice;
import com.haxepunk.gui.Label;
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
import openfl.text.TextFormatAlign;


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
		back.addGraphic(new Image("img/portada/portada.png"));
		this.add(back);
		back.layer = 15;
		botones = new List<Button>();
		Control.useSkin("img/Skins/GameSkin.png");
		
		var start :Button = new Button("sTart ", 113, 369, 544, 46);
		
		//start.hover = new NineSlice("img/portada/start_amarillo.png");
		
		
		//start.addEventListener(MouseEvent.CLICK, click);
		start.addEventListener(Button.CLICKED, click);
		
		
		//add(start);
		
		botones.add(start);
	
		var help:Button = new Button ("Help ",0,0,544,46);
		help.addEventListener(Button.CLICKED, helpClick);
		
		start.label.color = 0xEDFC05;
		start.label.font= "font/METALSTORMB_0.TTF";
		
		start.size = 40;
		
		
		
		help.x = start.x;
		help.y = start.y + start.height + 10;
		help.layer = 0;
		help.size = 16;
		
		help.label.color = 0xFD2222;
		help.label.font= "font/METALSTORMB_0.TTF";
		//botones.add(help);
		
		
		
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