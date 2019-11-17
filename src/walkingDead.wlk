class Sobreviviente{
	
	var resistencia
	var property carisma
	var estado
	var property armas
	var puntos
	var caminantes
	var property lugar
	method puedeAtacar()=resistencia>12
	method atacar(caminante){
		if(self.puedeAtacar()){
			resistencia-=2
			estado.efecto()
		}
	}
	
	method poderOfensivo(){
		//elijo arma random
		var arma=armas.atRandom()
		//El poder ofensivo  se calcula como el poder de alguna de sus armas + su poder propio
		return arma.poderOfensivo()+self.poder()
	}
	
	//el poder propio es una cantidad base de puntos del sobreviviente * (1 + carisma / 100).
	method 	poder()=puntos*(1 + carisma / 100)
	
	method estaJodido()=resistencia<40
}

 //sobrevivientes especiales
 class Predador inherits Sobreviviente{
 	//al atacar un caminante, además de lo anterior, intenta esclavizarlo
 	override method atacar(caminante){
 		super(caminante)
 		//Solo puede puede esclavizarlo si el caminante está débil 
 		if(caminante.estaDebil()){
 			self.esclavizar(caminante)
 		}
 	}
 	
 	method esclavizar(caminate){}
 	//Para este tipo de sobrevivientes su poder ofensivo es la mitad del poder de un sobreviviente 
 	//común más la sumatoria del poder corrosivo de sus caminantes.
 	override method poderOfensivo(){
 		var poderCorrosivoCaminantes=caminantes.sum({caminante=>caminante.poderCorrosivo()})
 		return super()/2+poderCorrosivoCaminantes
 	}
 	
 	method tieneArmaRuidosa(){
 		armas.any({arma=>arma.esRuidosa()})
 	}
 }

class Saludable{
	method atacar(sobreviviente){}
	method comer(sobreviviente){}
}

class Arrebatado{
	method atacar(sobreviviente){
		sobreviviente.carisma(sobreviviente.carisma()+1)
	}
	
	method comer(sobreviviente){
		sobreviviente.carisma(sobreviviente.carisma()+20)
		sobreviviente.resistencia(sobreviviente.resistencia()+50)
	}
}

class Infectado{
	var cantidadAtaques=0
	var desmayado=new Desmayado()
	method atacar(sobreviviente){
		sobreviviente.resistencia(sobreviviente.resistencia()+3)
		cantidadAtaques+=1
		if(cantidadAtaques>4){
			sobreviviente.estado(desmayado)
		}
	}
	
	method comer(sobreviviente){
		if(cantidadAtaques>3){
			cantidadAtaques=0
		}
		
		sobreviviente.resistencia(sobreviviente.resistencia()+40)
	}
}

class Desmayado{
	var saludable=new Saludable()
	method atacar(sobreviviente){}
	method comer(sobreviviente){
		sobreviviente.estado(saludable)
	}
}

class Arma{
	var calibre
	var potencia
	method poderOfensivo()=2*calibre+potencia
	
}

class ArmaRuidosa inherits Arma{
	method esRuidosa()=true
}

class ArmaSilenciosa inherits Arma{
	method esRuidosa()=false
}
class Caminante{
	var sedSangre
	var somnoliento
	var cantidadDientes
	method poderCorrosivo()=2*sedSangre*cantidadDientes
	//esta debil? (es decir que su sed de sangre es menor a 15 y está somnoliento).
	method estaDebil()=sedSangre<15 && somnoliento
}

class Grupo{
	var sobrevivientes
	method lider(){
		return sobrevivientes.max({sobreviviente=>sobreviviente.carisma()})
	}
	
	method poderesOfensivos(){
		var lider=self.lider()
		return sobrevivientes.sum({sobreviviente=>sobreviviente.poderOfensivo()})+lider.carisma()
	}
	
	method puedenTomarLugar(lugar)=self.poderesOfensivos()>lugar.poderesCorrosivos()
	
	method masDebil(){
		return sobrevivientes.min({sobreviviente=>sobreviviente.poderOfensivo()})
	}
	
	method poseeArmaRuidosa()=sobrevivientes.any({sobreviviente=>sobreviviente.tieneArmaRuidosa()})
	
	method atacantes(grupo){
		return grupo.filter({persona=>persona.puedeAtacar()})
	}
	
	method tomarLugar(lugar){
		if(self.puedenTomarLugar(lugar)){
			self.moverseA(lugar)
			self.atacarCaminantes(lugar.caminantes())
			lugar.esTomado(self)
		}
		else{
			var infectado=new Infectado()
			self.integrantesJodidos().forEach({integrante=>integrante.estado(infectado)})
		}
	}
	
	method moverseA(lugar){
		sobrevivientes.forEach({persona=>persona.lugar(lugar)})
	}
	
	method atacarCaminantes(caminantes){
		
	}
	
	method integrantesJodidos(){
		return sobrevivientes.filter({persona=>persona.estaJodido()})
	}
}

class Lugar{
	var caminantes
	method poderesCorrosivos(){
		return caminantes.sum({caminante=>caminante.poderCorrosivo()})
	}

}

class Prision inherits Lugar{
	var pabellones
	var _armas
	method puedeSerTomado(grupo)=grupo.poderCorrosivo()>2*pabellones
		
	method esTomada(grupo){
		if(self.puedeSerTomado(grupo) && grupo.puedenTomarLugar(self)){
			grupo.masDebil().armas().add(_armas)
		}
	}
}

class Granja inherits Lugar{
	method esTomado(grupo){
		if(grupo.puedenTomarLugar(self)){
			grupo.forEach({integrante=>integrante.comer()})
		}
	}
}

class Bosque inherits Lugar{
	var property tieneNiebla
	method esTomado(grupo){
		if(grupo.puedenTomarLugar(self) && !grupo.poseeArmasRuidosas()){
			if(self.tieneNiebla()){
				// si el bosque tiene niebla entonces un integrante del grupo cualquiera            
				//perderá cualquiera de sus armas. 
			}
		}
	}
}

