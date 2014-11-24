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

	var current:Scene;
	var escenas:Map<String,Scene>;
	
	
	private static var instance:SceneManager;
	
	public static function getInstance():SceneManager {
		if (instance == null) {
			instance = new SceneManager();
		}
		return instance;
	}
	public function new() 
	{
		this.escenas = new Map<String,Scene>();
		
		
	}
	
	public function addScene(name:String, escena:Scene):Bool {
		var nueva:Bool = true;
		if (escenas.get(name) != null) {
			nueva = false;
		}
		
		escenas.set(name, escena);
		
		return nueva;
	}
	
	public function changeScene(name:String) {
		var aux:Scene  = escenas.get(name);
		if (aux == null) return;
		current = aux;
		
		Actuate.tween(HXP.scene.sprite,0.2,{alpha:0}).onComplete(putScene);
	}
	
	public function putScene() {
		HXP.scene = current;
	}
}