package com.scfactory;

import com.scfactory.characters.Hero;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.utils.Timer;
import openfl.Assets;
import sys.db.Types.SLongBinary;

/**
 * ...
 * @author Sebachk
 */

class Main extends Sprite 
{
	var inited:Bool;

	var timer:Timer;
	var hero:Hero;
	
	var last:Int;
	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		
		this.addEventListener(Event.ENTER_FRAME, update);
		
		timer =  new Timer(60, 0);
		
		timer.start();
		
		last = timer.currentCount;
		
		hero = new Hero();
		
		hero.x = 10;
		hero.y = stage.height / 2;
		trace(hero.y+" "+stage.height);
		stage.addChild(hero);
		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}

	/* SETUP */

	public function update(_) {
		trace(timer.currentCount);
		hero.updateLogic(1/60);
	}
	
	
	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
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
