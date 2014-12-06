package com.scfactory.escenas;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.Tween;
import haxe.ds.HashMap;
import motion.Actuate;

/**
 * ...
 * @author Sebachk
 */
class SceneManager
{

	var current:GameScene;
	var escenas:Map<String,GameScene>;
	
	
	private static var instance:SceneManager;
	
	public static function getInstance():SceneManager {
		if (instance == null) {
			instance = new SceneManager();
		}
		return instance;
	}
	public function new() 
	{
		this.escenas = new Map<String,GameScene>();
		
		
	}
	
	public function addScene(name:String, escena:GameScene):Bool {
		var nueva:Bool = true;
		if (escenas.get(name) != null) {
			nueva = false;
		}
		
		escenas.set(name, escena);
		
		return nueva;
	}
	
	public function changeScene(name:String) {
		var aux:GameScene  = escenas.get(name);
		if (aux == null) return;
		if(current!=null){
			current.onEndScene();
			current = aux;		
		}else {
			current = aux;	
			putScene();
		}
		
	}
	
	public function putScene() {
		//HXP.scene.sprite.alpha = 1;
		//trace(current);
		
		HXP.scene = current;
	}
}