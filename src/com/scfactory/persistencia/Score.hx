package com.scfactory.persistencia;
import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
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
	private var panel:Graphic;
	
	
	private function updateLabel() {
		label.text = "Metros: " + Std.int(score);
	}
	
	public function new() 
	{
		super();
		label = new Text();
		lastScore = 0;
		score = 0;
		//this.graphic = label;
		this.followCamera = true;
		panel = new Image("img/escena_juego/panel_puntos.png");
		this.addGraphic(panel);
		this.addGraphic(label);
		
		
		this.label.size = 20;
		this.label.font = "font/METALSTORM_0.TTF";
	}
	
	public function add(value:Int) {
		score = lastScore;
		lastScore += value;
		
		Actuate.stop(this);
		Actuate.tween(this, 0.3, { score:lastScore } );
		
		//this.score = value;
	}
	
	
	public function get():Int {
		
		return lastScore;
	}
	
	override public function update():Void 
	{
		super.update();
		label.updateBuffer();
		label.update();
		updateLabel();
	}
	
	public function reset() {
		score = 0;
		lastScore = 0;
	}
	
}
	
