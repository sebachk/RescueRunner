package com.scfactory.estados;

/**
 * ...
 * @author Sebachk
 */
class EstadoCharacter extends Estado
{
	public static inline var ESTADO_CORRIENDO:String = "Corriendo";
	public static inline var ESTADO_SALTANDO:String = "SALTANDO";
	public static inline var ESTADO_CAYENDO:String = "CAYENDO";
	public static inline var ESTADO_MUERTO:String = "MUERTO";
	public static inline var ESTADO_R_EPERANDO:String = "ESPERANDO";
	public static inline var ESTADO_R_SIGUIENDO:String = "SIGUIENDO";
	
	
	public function enAire():Bool {
		switch (actual) {
			case ESTADO_SALTANDO,ESTADO_CAYENDO:
				return true;
			default:
				return false;
		}
	}
	
	public function esperando():Bool {
		return actual == ESTADO_R_EPERANDO;
	}
	
	public function isMuerto():Bool {
		return actual == ESTADO_MUERTO;
	}
	
	public function puedeTocarPiso():Bool {
		return actual == ESTADO_CAYENDO;
	}
	
	public function new() 
	{
		super();
		
	}
	
}