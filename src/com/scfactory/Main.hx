package com.scfactory;

import com.haxepunk.Engine;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.atlas.Atlas;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.scfactory.characters.Hero;
import com.scfactory.map.Floor;
import com.tvj.InputManager;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.utils.Timer;
import openfl.Assets;
import sys.db.Types.SLongBinary;

/**
 * ...
 * @author Sebachk
 */

class Main extends Engine 
{
	var inited:Bool;

	var timer:Timer;
	var hero:Hero;
	var mapa:Floor;
	
	var last:Int;
	var game:Scene;
	
	/* ENTRY POINT */
	
	override function resize() 
	{
		super.resize();
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	
	
	override public function init() 
	{
		if (inited) return;
		inited = true;
		
		
		//this.addEventListener(Event.ENTER_FRAME, update);
		
		var anim:Spritemap = new Spritemap("img/runner2.png",40, 51);
		anim.add("normal", [0, 1, 2, 3, 4, 5, 6, 7, 8], 60);
		
		hero = new Hero(anim);
		mapa = new Floor(50, 350);
	
		hero.x = stage.width/2;
		hero.y = stage.height / 2;
	
		trace(stage.width + " " + stage.height);
		
		game = new Scene();
		
		game.addGraphic(new Image("img/fondo.png"));
		game.add(hero);
		
		game.
		
		HXP.scene = game;
		
		//mapa.addHijo(hero);
		//this.addChild(hero);
		
		InputManager.getInstance().suscribe(stage);
		
		//stage.addEventListener(Event.ENTER_FRAME, update);
		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}

	/* SETUP */

	override public function update() {
		
		super.update();
		//hero.updateLogic(1 / 60);
		//mapa.updateLogic(1 / 60);
		//game.render();
		
	}
	
	public function resized(_) {
			resize();
	}
	
	
	public function new() 
	{
		super();	
		added(null);
		addEventListener(Event.ADDED_TO_STAGE, added);
		
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resized);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
