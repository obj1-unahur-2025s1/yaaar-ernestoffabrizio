class Barco{
  var mision
  var capacidad
  var piratas
  method cambiarMision(nuevaMision){
  mision = nuevaMision
  piratas = piratas.filter{p =>p.esUtilParaMision(nuevaMision)}
  }
  method anclarse(unaCiudad){
  piratas.all{p => p.tomarGrogXD()
  piratas.all{p => p.gastarMonedas(1)}
  piratas.remove(self.pirataMasEbrio())
  unaCiudad.añadirHabitante()
  }
  }
  method piratas() = piratas
  method esTemible() = self.puedeRealizarMision()
  method puedeRealizarMision() = mision.puedeRealizarla(self)
  method tieneSuficienteTripulacion() = piratas.size() >= capacidad*0.9
  method puedeAtacarlo(unPirata) = unPirata.estaPasadoDeGrogXD()
  method esVulnerableA(unBarco) = self.piratas().size() < unBarco.piratas().size()*0.5
  method hayLugar() = self.piratas() < capacidad
  method añadirPirata(unPirata){
    if (self.hayLugar() and unPirata.esUtilParaMision(mision)){piratas.add(unPirata)}
  }
  method pirataMasEbrio() = piratas.max{p=>p.ebriedad()}
}
class Pirata{
  var mision
  var items
  var ebriedad
  var dinero
  method estaPasadoDeGrogXD() = ebriedad >= 90
  method gastarMonedas(unaCantidad) {dinero = dinero-unaCantidad}
  method tomarGrogXD(){ebriedad = ebriedad+5}
  method ebriedad() = ebriedad
  method inventario() = items
  method esUtilParaMision() = mision.esUtil(self)
}
class Espias inherits Pirata{
  override method estaPasadoDeGrogXD() = false
  
}
class Mision{
  method puedeRealizarla(unBarco) = unBarco.tieneSuficienteTripulacion()
}
class BusquedaDelTesoro inherits Mision{
  method esUtil(unPirata) = 
  unPirata.inventario().contains(brujula) or
  unPirata.inventario().contains(mapa) or
  unPirata.inventario().contains(botella) and
  unPirata.dinero() < 5
  override method puedeRealizarla(unBarco) = 
  super(unBarco) and 
  unBarco.piratas().any{p =>p.inventario().contains(llave)}
}
class ConvertirseEnLeyenda inherits Mision{
  const itemNecesario
  method esUtil(unPirata) =
  unPirata.inventario().size() >= 10 and
  unPirata.inventario().contains(itemNecesario)
}
class Saqueos inherits Mision{
  const objetivo
  var cantidadRequerida
  method cambiarCantidad(unaCantidad){cantidadRequerida = unaCantidad}
  method esUtil(unPirata) =
  unPirata.dinero() < cantidadRequerida and
  objetivo.puedeAtacarlo(unPirata)
  override method puedeRealizarla(unBarco) =
  super(unBarco) and
  objetivo.esVulnerableA(unBarco)
}
class CiudadCostera{
  var habitantes
  method añadirHabitante(){habitantes = habitantes+1}
  method puedeAtacarlo(unPirata) =  unPirata.ebriedad() >= 50
  method esVulnerableA(unBarco) = 
  unBarco.piratas().size() >= habitantes*0.4 or
  unBarco.piratas().all{p =>p.estaPasadoDeGrogXD()}
}










object brujula{}
object mapa{}
object botella{}
object llave{}