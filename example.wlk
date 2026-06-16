// ---1. PLANTAS---
class Planta {
  const añoDeObtencion
  var altura

  method horasDeSolQueTolera() = 20 
  method esFuerte() = self.horasDeSolQueTolera() > 10
  method daNuevasSemillas() = self.esFuerte() or self.condicionEspecial()
  method condicionEspecial() = 19
}

class Menta inherits Planta {
  
  override method horasDeSolQueTolera() = 6
  override method condicionEspecial() = altura > 0.4
  method espacioQueOcupa() = altura * 3

}
class Soja inherits Planta {

  override method horasDeSolQueTolera() {
    if (altura < 0.5) return 6
    if (altura.between(0.5, 1)) return 7
    return 9
  }
  override method condicionEspecial() = añoDeObtencion > 2007 and altura > 1
  method espacioQueOcupa() = altura /2

}

//---2. VARIEDADES---

class SojaTransgenica inherits Soja {
  override method daNuevasSemillas() = false

}
class Hierbabuena inherits Menta {
  override method espacioQueOcupa() = super() / 2
}

//---3. PARCELAS ---

class Parcela {

  const ancho
  const largo
  const horasDeSolQueRecibePorDia
  const palntasQueTiene = []

  method  superficieDeParcela() = ancho * largo
  
  method cantidadMaximaDePlantasQueTolera () =
    if (ancho > largo) {
      self.superficieDeParcela() / 5
    } else {
      (self.superficieDeParcela() / 3) + largo
    }
  
}