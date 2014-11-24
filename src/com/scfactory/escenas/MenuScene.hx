package com.scfactory.escenas;
import com.haxepunk.gui.Button;
import com.haxepunk.Scene;
import com.haxepunk.Tween;
import com.haxepunk.tweens.motion.LinearMotion;
import com.haxepunk.tweens.motion.LinearPath;
import openfl.events.Event;
import openfl.events.MouseEvent;


/**
 * ...
 * @author Sebachk
 */
class MenuScene extends Scene
{
	var botones:List<Button>;
	
	public function new() 
	{
		super();
		botones = new List<Button>();
		
		var start :Button = new Button("START");
		start.addEventListener(MouseEvent.CLICK, click);
		start.addEventListener(Button.CLICKED, click);
		
		add(start);
		
	
		var help:Button = new Button ("Help");
		help.addEventListener(Button.CLICKED, helpClick);
		
		start.x = 100;
		start.y = 100;
		
		help.x = start.x;
		help.y = start.y + start.height + 10;
		
		add(help);
	}
	
	public function addButton(buton:Button) {
	
	}
	
	public function click(_) {
		SceneManager.getInstance().changeScene("game");
	}
	
	function helpClick(_) {
		trace("help");
	}
	
	
}