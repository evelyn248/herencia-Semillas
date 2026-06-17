// ---1. PLANTAS---
class Planta {
  const añoDeObtencion
  var altura

  method horasDeSolQueTolera()
  method esFuerte() = self.horasDeSolQueTolera() > 10
  method daNuevasSemillas() = self.esFuerte() or self.condicionEspecial()
  method condicionEspecial()
}

class Menta inherits Planta {
  
  override method horasDeSolQueTolera() = 6
  override method condicionEspecial() = altura > 0.4
  method espacioQueOcupa() = altura * 3

  //---4. PARCELAS IDEALES--- 

  method esParcelaIdeal(unaParcela) = unaParcela.superficieDeParcela() > 6
  
}
class Soja inherits Planta {

 override method horasDeSolQueTolera() =
    if (altura < 0.5) 6
    else if (altura.between(0.5, 1)) 7
    else 9
  
  override method condicionEspecial() = añoDeObtencion > 2007 and altura > 1
  method espacioQueOcupa() = altura /2
}

class Quinoa inherits Planta {

  var horasDeSol

  override method horasDeSolQueTolera() = horasDeSol
  method espacioQueOcupa() = 0.5
  override method condicionEspecial() = añoDeObtencion < 2005
  method esParcelaIdeal(unaParcela) = not unaParcela.tieneAlgunaPlantaMasAltaQue(1.5)

}


//---2. VARIEDADES---

class SojaTransgenica inherits Soja {
  override method daNuevasSemillas() = false

}
class Hierbabuena inherits Menta {
  override method espacioQueOcupa() = super() * 2
}

//---3. PARCELAS ---

class Parcela {

  const ancho
  const largo
  const horasDeSolQueRecibePorDia
  const plantasQueTiene  = []

  method  superficieDeParcela() = ancho * largo
  
  method cantidadMaximaDePlantasQueTolera() =
    if (ancho > largo) {
      self.superficieDeParcela() / 5
    } else {
      (self.superficieDeParcela() / 3) + largo
    }  

    method tieneComplicaciones(){
      plantasQueTiene.any({p => p.horasDeSolQueTolera() < horasDeSolQueRecibePorDia})
    }

    method plantarPlanta(unaPlanta){
      if (self.puedePlantar(unaPlanta)){
        plantasQueTiene.add(unaPlanta)
      } else {
        self.error("No es posible plantar la planta")
      }
    }

    method puedePlantar(unaPlanta) =
      plantasQueTiene.size() < self.cantidadMaximaDePlantasQueTolera() and
      horasDeSolQueRecibePorDia < (unaPlanta.horasDeSolQueTolera() + 2)

    method tieneAlgunaPlantaMasAltaQue(unaAltura) = 
        plantasQueTiene.any({ p => p.altura() > unaAltura })
}



