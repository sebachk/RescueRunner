package com.scfactory.persistencia;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import motion.Actuate;
import motion.actuators.GenericActuator.IGenericActuator;
import openfl.text.TextField;

/**
 * ...
 * @author Sebachk
 */
class Score extends Entity
{

	var score(default, set):Int;
	
	private var lastScore:Int;
	
	var tweenActual:IGenericActuator;
	
	
	public function set_score(value:Int):Int {
		score = value;
		updateLabel();
		return value;
	}

	private var label:Text;
	
	private function updateLabel() {
		label.text = "Score: " + Std.int(score);
	}
	
	public function new() 
	{
		super();
		label = new Text();
		lastScore = 0;
		score = 0;
		this.graphic = label;
		this.followCamera = true;
	}
	
	public function add(value:Int) {
		score = lastScore;
		lastScore += value;
		
		Actuate.stop(this);
		Actuate.tween(this, 2, { score:lastScore } );
		
		//this.score = value;
	}
	
	
	public function get() {
		trace(score+" score");
		return score;
	}
	
	override public function update():Void 
	{
		super.update();
		label.updateBuffer();
		label.update();
		updateLabel();
	}
	
}
	
