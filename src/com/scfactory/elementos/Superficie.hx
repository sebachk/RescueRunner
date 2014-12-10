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
	
	var xInicial:Float;
	
	public function new(x:Float=0, y:Float=0, graphic:Image=null, mask:Mask=null,tipo:String="piso") 
	{
		super(x, y, null, null, tipo);
		xInicial = x;
		if (graphic == null) {
			imagen = new Image("img/escena/pisos.png");
		}
		else{
			imagen = graphic;
		}
		plataformas = new Array<Plataforma>();
		
		var p:Plataforma;
		var cant:Int = cast((Math.fceil(HXP.width / imagen.width)+2),Int);
		
		for (i in 0...cant) {
			var nuevo:Float = y;
			
			p = new Plataforma((i-1) * imagen.width+x, nuevo, this.imagen, mask, this.type);
			p.setHitbox(imagen.width, imagen.height);
			//this.addGraphic(p.graphic);
			plataformas.push(p);
			
		}
		reset(x, y);
		
	}
	
	public function reset(x:Float,y:Float) {
		this.x = xInicial;
		
		var xx = this.x-imagen.width;
		for (p in plataformas) {
			p.x = xx;
			xx += p.width;
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
			
			
		}
	}
	
	
	override public function added():Void 
	{
		super.added();
		this.scene.addList(plataformas);
		
	}
}