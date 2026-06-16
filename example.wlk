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
  method espacioQueOCupa() = altura * 3

}
class Soja inherits Planta {

  override method horasDeSolQueTolera() {
    if (altura < 0.5) return 6
    if (altura.between(0.5, 1)) return 7
    return 9
  }
  override method condicionEspecial() =  añoDeObtencion > 2007 and altura > 1
  method espacioQueOCupa() = altura /2

}