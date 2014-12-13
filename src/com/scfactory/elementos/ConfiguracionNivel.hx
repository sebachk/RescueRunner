package com.scfactory.elementos;
import openfl.geom.Point;

/**
 * ...
 * @author Sebachk
 */
class ConfiguracionNivel
{
	var pos_plataformas :Array<Point>;
	var n_plataforma:Int;
	
	var offset:Float;
	
	var i:Int = 0;
	
	public function new() 
	{
		pos_plataformas = new Array<Point>();
		n_plataforma = 0;
		offset = 0;
	}
	
	public function add_plataforma(x:Int, y:Int) {	

		
		pos_plataformas.push(new Point(x, y));
		
		pos_plataformas.sort(function (a:Point, b:Point):Int { return Std.int(a.x - b.x); } );
	}
	
	public function x_Actual():Float {
		if(n_plataforma<pos_plataformas.length)
			return pos_plataformas.slice(n_plataforma, n_plataforma + 1).pop().x+offset;
		return -1;
	}
	
	public function get_Next():Point {
		if(n_plataforma<pos_plataformas.length){
			n_plataforma++;
			var p:Point = pos_plataformas.slice(n_plataforma - 1, n_plataforma).pop();
		
				
			//trace("plat numero:" + i, "cant:"+pos_plataformas.length,"offset:"+n_plataforma);
			return new Point(p.x+offset,p.y);
		}
		return null;
	}
	
	public function resetPosiciones(x:Float) {
		offset = x;
		n_plataforma = 0;
	}
	
}