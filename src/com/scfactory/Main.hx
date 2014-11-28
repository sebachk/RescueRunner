package com.scfactory;

import com.haxepunk.Engine;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.atlas.Atlas;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.utils.Draw;
import com.scfactory.characters.Hero;
import com.scfactory.escenas.LevelScene;
import com.scfactory.escenas.MenuScene;
import com.scfactory.escenas.SceneManager;
import com.scfactory.map.Floor;
import com.tvj.InputManager;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.display.Graphics;
import openfl.display.SimpleButton;
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
	
	/* ENTRY POINT */
	
	override function resize() 
	{
		super.resize();
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	private function createScenes() {
		var scn:Scene = new MenuScene();
		SceneManager.getInstance().addScene("menu", scn);
		
		scn= new LevelScene("img/backgrounds/background1.jpeg", "img/fondo.png");
		//game.addGraphic(new Image("img/fondo.png"));
		cast (scn,LevelScene).hero= hero;
		
		SceneManager.getInstance().addScene("game", scn);
	}
	
	override public function init() 
	{
		
		
		if (inited) return;
		
		#if debug
			HXP.console.enable();
		#end
		
		inited = true;
		
		
		hero = new Hero("img/runner2.png");
		mapa = new Floor(50, 350);
	
		hero.x = stage.width/2;
		hero.y = stage.height / 2;
	
		trace(stage.width + " " + stage.height);
		
		createScenes();
		SceneManager.getInstance().changeScene("menu");
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
	
	
	
	public function generarMenu() {
		//var ms:MenuScene = new MenuScene();
			//
		//var but:SimpleButton = new SimpleButton();
		//but.downState = Draw.rect(0, 0, 50, 20, 0xff0000,0.5);
		//but.upState = Draw.rect(0, 0, 50, 20, 0xFF0000);
		//but.overState=Draw.rect(0, 0, 50, 20, 0xFF0000,0,75);
		//
		//but.name = "Menu button";
		//
		//ms.addButton(but);
		//
		//but= new SimpleButton();
		//but.downState = Draw.rect(0, 0, 50, 20, 0xffff00,0.5);
		//but.upState = Draw.rect(0, 0, 50, 20, 0xFFff00);
		//but.overState=Draw.rect(0, 0, 50, 20, 0xFFff00,0,75);
		//
		//but.name = "Help button";
		//
		//ms.addButton(but);
		//
	}
	
	
}
