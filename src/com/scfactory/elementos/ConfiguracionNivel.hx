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
	
	
	
	public function new() 
	{
		pos_plataformas = new Array<Point>();
		n_plataforma = 0;
	}
	
	public function add_plataforma(x:Int, y:Int) {	
		//Point last = pos_plataformas.pop();
		//if (last != null) {
			//if (x <= last.x)
				//return;
			//pos_plataformas.push(last);
		//}
		pos_plataformas.push(new Point(x, y));
		
		pos_plataformas.sort(function (a:Point, b:Point):Int { return Std.int(a.x - b.x); } );
	}
	
	public function x_Actual():Float {
		if(n_plataforma<pos_plataformas.length)
			return pos_plataformas.slice(n_plataforma, n_plataforma + 1).pop().x;
		return null;
	}
	
	public function get_Next():Point {
		if(n_plataforma<pos_plataformas.length){
			n_plataforma++;
			return pos_plataformas.slice(n_plataforma - 1, n_plataforma).pop();
		}
		
		return null;
	}
	
	public function resetPosiciones(x:Float) {
		for (p in pos_plataformas) {
			p.x += x;
		}
		n_plataforma = 0;
	}
	
}