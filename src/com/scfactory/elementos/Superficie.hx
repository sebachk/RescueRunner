package com.scfactory.elementos;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;

/**
 * ...
 * @author Sebachk
 */
class Superficie extends Plataforma
{
	var plataformas:Array<Plataforma>;
	var imagen:Image;
	
	public function new(x:Float=0, y:Float=0, graphic:Image=null, mask:Mask=null,tipo:String="piso") 
	{
		super(x, y, null, null, tipo);
		imagen = graphic;
		
		if (graphic == null) {
			graphic = Image.createRect(HXP.width, HXP.height, 0xFF0000);
		}
		
		plataformas = new Array<Plataforma>();
		
		var cant:Int = cast((Math.fceil(HXP.width / graphic.width)+2),Int);
		
		var p:Plataforma;
		
		for (i in 0...cant) {
					
			p = new Plataforma((i-1) * graphic.width+x, y, graphic, mask, tipo);
			p.setHitbox(graphic.width, graphic.height);
			this.addGraphic(p.graphic);
			plataformas.push(p);
		
		}
	}
	
	override public function update():Void 
	{
		super.update();
		if (this.x-this._camera.x < -imagen.width){
		
			this.x += imagen.width;
			var e:Iterator<Plataforma>  = plataformas.iterator();
			while (e.hasNext()) {
				var p:Plataforma = e.next();
				p.x += p.width;
			}
		}
	}
	
	
	override public function added():Void 
	{
		super.added();
		this.scene.addList(plataformas);
		
	}
}