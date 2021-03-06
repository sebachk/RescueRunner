package com.scfactory.characters;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.atlas.TextureAtlas;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.TiledSpritemap;
import com.haxepunk.HXP;
import com.haxepunk.Mask;
import com.scfactory.escenas.LevelScene;
import com.scfactory.estados.EstadoCharacter;
import openfl._v2.geom.Point;

/**
 * ...
 * @author Sebachk
 */
class AnimatedCharacter extends Entity
{
	var anim:TiledSpritemap;
	
	var lScene:LevelScene;

	static inline var NAME_HERO:String = "hero";
	static inline var NAME_REHEN:String = "rehen";
	
	
	
	
	
	//Movimiento
	
	var velocidad:Point;
	var acceleracion:Point;
	var estado:String;
	var state:EstadoCharacter;
	
	static var ESTADO_CORRIENDO:String = "CORRIENDO";
	static var ESTADO_SALTANDO:String = "SALTANDO";
	
	static var ESTADO_R_ESPERANDO:String = "ESPERANDO";
	static var ESTADO_R_SIGUIENDO:String = "SIGUIENDO";
	
	static var ESTADO_MUERTO:String = "MUERTO";
	
	
	static inline var GRAVITY:Float = 0.1;
	static inline var DRAG:Float = 0.2;
	
	static inline var MAXVEL:Float = 6;
	
	public function new(tile:TileType,fw:Int,fh:Int,w:Int,h:Int,cb:Void->Void,x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		
		super(x, y, graphic, mask);
		state = new EstadoCharacter();
		
		anim = new TiledSpritemap(tile, fw, fh, w, h, cb);
		
		
		this.graphic = anim;
		
		
		velocidad = new Point();
		acceleracion = new Point();
		
		estado = ESTADO_SALTANDO;
		state.actual = EstadoCharacter.ESTADO_SALTANDO;
		
	}
	
	override public function update():Void 
	{
		if(!state.isMuerto()){
			super.update();
			this.animar();
			
			height = anim.height;
		}
		

	}
	
	private function animar() {
		anim.play("normal");
	}
	
	
	public function morir():Bool {
		
		state.actual = EstadoCharacter.ESTADO_MUERTO;
		//estado = ESTADO_MUERTO;
		if(lScene!=null)
			lScene.MatarCharacter(this);
		//cast(this.scene, LevelScene).MatarCharacter(this);
		return true;
		
		
	}
	
	override public function added():Void 
	{
		super.added();
		
		this.lScene = cast(this.scene, LevelScene);
	}

}