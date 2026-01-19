enum TipusLlicencia { compra, lloguer, prova }

class Llicencia {
  final String id;
  final TipusLlicencia tipus;
  int canvisPropietariRestants;
  int horesJocRestants; // -1 para infinito

   Llicencia._(this.id, this.tipus, this.canvisPropietariRestants, this.horesJocRestants);

    Llicencia.compra(this.id) 
      : tipus = TipusLlicencia.compra, 
        canvisPropietariRestants = 3, 
        horesJocRestants = -1;
  
    Llicencia.prova(this.id)
      : tipus = TipusLlicencia.prova,
        canvisPropietariRestants = 0,
        horesJocRestants = 3;
}