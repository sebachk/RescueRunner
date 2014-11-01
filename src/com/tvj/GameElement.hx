package com.tvj;

import flash.display.Sprite;

class GameElement extends Sprite{
	
	var hijos:Array<GameElement>;
	
	public function new () {
		super();		
		hijos=new Array<GameElement>();
	}
	
	public function updateLogic(time:Float){
		var hijo:GameElement;
		for(hijo in hijos){
			hijo.updateLogic(time);
		}
	}

	public function addHijo(element:GameElement) {
		hijos.push(element);
	}
	
}
