// ---1. PLANTAS---
class Planta {
  const añoDeObtencion
  var altura

  method horasDeSolQueTolera()
  method esFuerte() = self.horasDeSolQueTolera() > 10
  method daNuevasSemillas() = self.esFuerte() or self.condicionEspecial()
  method condicionEspecial()
  method esParcelaIdeal(unaParcela)
}

class Menta inherits Planta {
  
  override method horasDeSolQueTolera() = 6
  override method condicionEspecial() = altura > 0.4
  method espacioQueOcupa() = altura * 3

  //---4. PARCELAS IDEALES--- 

  override method esParcelaIdeal(unaParcela) = unaParcela.superficieDeParcela() > 6
  
}
class Soja inherits Planta {

 override method horasDeSolQueTolera() =
    if (altura < 0.5) 6
    else if (altura.between(0.5, 1)) 7
    else 9
  
  override method condicionEspecial() = añoDeObtencion > 2007 and altura > 1
  method espacioQueOcupa() = altura /2

  //---4. PARCELAS IDEALES--- 
  override method esParcelaIdeal(unaParcela) = unaParcela.horasDeSolPorDia() == self.horasDeSolQueTolera()
}

class Quinoa inherits Planta {

  var horasDeSol

  override method horasDeSolQueTolera() = horasDeSol
  method espacioQueOcupa() = 0.5
  override method condicionEspecial() = añoDeObtencion < 2005

    //---4. PARCELAS IDEALES--- 
  override method esParcelaIdeal(unaParcela) = not unaParcela.tieneAlgunaPlantaMasAltaQue(1.5)

}

//---2. VARIEDADES---

class SojaTransgenica inherits Soja {
  override method daNuevasSemillas() = false

//---4. PARCELAS IDEALES--- 

  override method esParcelaIdeal(unaParcela) = unaParcela.cantidadMaximaDePlantasQueTolera() == 1

}
class Hierbabuena inherits Menta {
  override method espacioQueOcupa() = super() * 2
}

//---3. PARCELAS ---

class Parcela {

  const ancho
  const largo
  const property horasDeSolQueRecibePorDia
  const  plantasQueTiene = []

  method  superficieDeParcela() = ancho * largo
  
  method cantidadMaximaDePlantasQueTolera() =
    if (ancho > largo) {
      self.superficieDeParcela() / 5
    } else {
      (self.superficieDeParcela() / 3) + largo
    }  

    method tieneComplicaciones() =
      plantasQueTiene.any({p => p.horasDeSolQueTolera() < horasDeSolQueRecibePorDia})
  

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

    method seAsociaBien(unaPlanta)
}

//-- 5. ASOCIACION DE PLANTAS --

class ParcelaEcologica inherits Parcela{

  override method seAsociaBien(unaPlanta) {
    not self.tieneComplicaciones() and unaPlanta.esParcelaIdeal(self)
  }

}

class ParcelaIndustrial inherits Parcela{

  override method seAsociaBien(unaPlanta) {
    self.cantidadMaximaDePlantasQueTolera() == 2 and unaPlanta.esFuerte()
  }

}

// -- 6. ESTADISTICAS DEL INTA --

object inta {
  const coleccionDeParcelas = []

  method promedioDePlantas() = 
    coleccionDeParcelas.sum({p => p.plantasQueTiene().size()}) / coleccionDeParcelas.size()

  method parcelaMasAutosustentable() = 
    coleccionDeParcelas.filter({p => p.plantasQueTiene().size() > 4}).max({p => self.porcentajeDeBienAsociadas(p)})
    
  method porcentajeDeBienAsociadas(unaParcela) =
    (unaParcela.cantidadDePlantasBienAsociadas() / unaParcela.plantasQueTiene().size()) * 100
}




