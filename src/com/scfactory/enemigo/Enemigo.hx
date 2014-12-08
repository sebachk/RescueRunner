package com.scfactory.enemigo;
import com.haxepunk.Graphic;
import com.haxepunk.Graphic.TileType;
import com.haxepunk.Mask;
import com.scfactory.characters.AnimatedCharacter;
import com.scfactory.elementos.ElementManager;

/**
 * ...
 * @author Sebachk
 */
class Enemigo extends AnimatedCharacter
{
	private inline static var ESTADO_ENEMISTANDO:String = "soy un enemigo";
	

	public function new(tile:TileType, fw:Int, fh:Int, w:Int, h:Int, cb:Void->Void, x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask = null)
	{
		super(tile, fw, fh, w, h, cb, x, y, graphic, mask);
		this.state.actual = ESTADO_ENEMISTANDO;
	}
	
	
	override public function update():Void 
	{
		//super.update();
		
		if (this.x+300 < this._camera.x) {
			trace("kill");
			ElementManager.get_Instance().killFaller(this);
		}
	}
	
	public function collideCharacter(ac:AnimatedCharacter) {
		ac.morir();
	}
	
}