

// configuration
space = 4;
hole = 4;
pad = space / 2;

length = 6;
width = 1;
thickness = pad;


// design
difference(){
    cube([
        length*hole + (length-1)*space + 2*pad,
        width*hole + (width-1)*space + 2*pad,
        thickness
    ]);

    for(i = [0:length-1]){
        for(j=[0: width-1]){
            translate([
                i * (space + hole) + pad + hole/2,
                j * (space + hole) + pad + hole/2,
                -thickness])
            {
                cylinder(
                    h = thickness * 3,
                    r= hole/2 + 0.2);
                }
            }
        }
}
