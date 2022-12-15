color CouleurFaction(Faction faction) {
  switch(faction) {
  case Ally : 
    return ally;
  case Ennemy : 
    return ennemy;
  case NeutralA : 
    return neutA;
  case NeutralP : 
    return neutP;
  }
  return white;
}
