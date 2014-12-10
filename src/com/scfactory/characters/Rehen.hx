package com.scfactory.characters;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.scfactory.const.ConstantManager;
import com.scfactory.estados.EstadoCharacter;
import openfl.Vector;

/**
 * ...
 * @author Sebachk
 */
class Rehen extends AnimatedCharacter
{

	public var adelante(default,default):AnimatedCharacter;

	var XX:Array<Float>;
	var YY:Array<Float>;
	
	public function new(adelante:AnimatedCharacter = null , x:Float = 0, y:Float = 0, graphic:Graphic = null, mask:Mask = null) 
	{
		super("img/runner2.png", 40, 51, 40, 51, null, x, y, graphic, mask);
		this.anim.add("normal", [0, 1, 2, 3, 4, 5, 6, 7, 8],13);
		
		this.estado = AnimatedCharacter.ESTADO_R_ESPERANDO;
		this.state.actual = EstadoCharacter.ESTADO_R_EPERANDO;
		this.setHitbox(40, 50);
		this.adelante = adelante;
		
		this.x = x;
		this.y = y;
		this.XX = new Array<Float>();
		this.YY = new Array<Float>();
		
		
		this.type="solid";
	}
	
	override public function update():Void 
	{
		super.update();
		if (state.actual ==EstadoCharacter.ESTADO_R_EPERANDO) {
			moveBy(0, 30, [ConstantManager.TIPO_FLOOR, ConstantManager.TIPO_PISO]);
		}
		else if(state.actual !=EstadoCharacter.ESTADO_MUERTO){
			var xx, yy:Float;
				xx = XX.shift();
				yy = YY.shift();
				
				XX.push(adelante.x);
				YY.push(adelante.y);
				
			
				
			if (xx < this.x) {
				this.anim.flipped = true;
			}
			else {
				this.anim.flipped = false;
			}
			
			if (xx > this.x) {
				while (xx - this.x > 6)
					xx--;
			}
			else {
				while (xx - this.x < -6)
					xx++;
			}
			
			if (yy > this.y) {
				while (yy - this.y > 6) {
					yy--;
				}
			}
			else {
				while (yy - this.y < -6) {
					yy++;
				}
			}
			
			moveTo(xx, yy,[ConstantManager.TIPO_FLOOR,ConstantManager.TIPO_PISO]);
		}
		
		
		
		
	}
	
	override public function moveCollideY(e:Entity):Bool 
	{
		return super.moveCollideY(e);
		
	}
	
	override public function moveCollideX(e:Entity):Bool 
	{
		return false;
	}
	
	public function rescatar() {
		this.estado = AnimatedCharacter.ESTADO_R_SIGUIENDO;
		state.actual = EstadoCharacter.ESTADO_R_SIGUIENDO;
		anim.play("rescatando");
		if (this.lScene != null) {
			
			lScene.rescatarRehen(this);
		}
		
		
		XX.push(x);
		XX.push(x);
		XX.push(x);
		XX.push(x);
		XX.push(x);
		XX.push(x);
		XX.push(x);
		XX.push(x);
		XX.push(x);
		
		
		YY.push(y);
		YY.push(y);
		YY.push(y);
		YY.push(y);
		YY.push(y);
		YY.push(y);
		YY.push(y);
		YY.push(y);
		YY.push(y);
		
	}
	
	override public function added():Void 
	{
		super.added();
		this.state.actual = EstadoCharacter.ESTADO_R_EPERANDO;
		this.XX = new Array<Float>();
		this.YY = new Array<Float>();
	
	}
	
	public function salvar() {
		state.actual = EstadoCharacter.ESTADO_R_EPERANDO;
		adelante = null;
	}
	
}