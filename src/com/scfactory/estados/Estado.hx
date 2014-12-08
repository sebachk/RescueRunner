package com.scfactory.estados;


/**
 * ...
 * @author Sebachk
 */
class Estado
{
	public var actual(default, set):String;
	
	
	
	public function set_actual(value:String):String {
		if (value != this.actual) {
			this.actual = value;
			onChange();
		}
		return this.actual;
	}
	
	public function onChange() {
		
	}
	
	public function new() 
	{
		
	}
	
}