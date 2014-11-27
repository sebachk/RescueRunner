package com.scfactory.characters;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.atlas.TextureAtlas;
import com.haxepunk.graphics.atlas.TileAtlas;
import com.haxepunk.graphics.TiledSpritemap;
import com.haxepunk.Mask;

/**
 * ...
 * @author Sebachk
 */
class AnimatedCharacter extends Entity
{
	var anim:TiledSpritemap;
	
	
	
	public function new(tile:TileType,fw:Int,fh:Int,w:Int,h:Int,cb:Void->Void,x:Float=0, y:Float=0, graphic:Graphic=null, mask:Mask=null) 
	{
		
		super(x, y, graphic, mask);
		
		anim = new TiledSpritemap(tile, fw, fh, w, h, cb);
		
		anim.active = true;
		
		anim.visible = true;
		
		trace(anim.frameCount);
		this.graphic = anim;
		
		
		
	}
	
	override public function update():Void 
	{
		super.update();
		this.animar();
		
		height = anim.height;
	}
	
	private function animar() {
		anim.play("normal");
		
	}
}