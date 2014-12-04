package com.scfactory.elementos;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;
import com.haxepunk.utils.Data;
import com.haxepunk.utils.Draw;

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
		
		if (graphic == null) {
			graphic = new Image("img/backgrounds/piso_oscuro_02.png");
		}
		imagen = graphic;
		
		plataformas = new Array<Plataforma>();
		
		var cant:Int = cast((Math.fceil(HXP.width / graphic.width)+2),Int);
		
		var p:Plataforma;
		var yAnt:Float=0;
		for (i in 0...cant) {
			var nuevo:Float = y + ((Math.random() * 3)-1)*25;
			
			p = new Plataforma((i-1) * graphic.width+x, nuevo, graphic, mask, tipo);
			p.setHitbox(graphic.width, graphic.height);
			//this.addGraphic(p.graphic);
			plataformas.push(p);
			yAnt = p.y;		
			
		}
		
		
	}
	
	override public function update():Void 
	{
		super.update();
		
		
		if (this.x-this._camera.x < -imagen.width){
			var p:Plataforma = plataformas.shift();
			p.x += p.width * (plataformas.length+1);
			plataformas.push(p);
			
			this.x += imagen.width;
			//var e:Iterator<Plataforma>  = plataformas.iterator();
			//while (e.hasNext()) {
				//var p:Plataforma = e.next();
				//p.x += p.width;
			//}this
		}
	}
	
	
	override public function added():Void 
	{
		super.added();
		this.scene.addList(plataformas);
		
	}
}