rangees_longueur = 10;
rangees_largeur =4;
epaisseur = 2;
difference(){
cube([5+rangees_longueur*8, rangees_largeur*8,epaisseur]);

union(){
for(i = [0:rangees_longueur-1]){
    for(j=[0: rangees_largeur]){
        translate([2.5+4+i*8, 4+j*8, -1]){
            cylinder(h=epaisseur+2, r= 2);
            }
        }
    }
}
}