// configuration
space = 4;
hole = 4;
pad = space/2;
left = true;

// motor size
motor_length = 18.8;
motor_width = 22.5;

// distances between holes
// 2 front holes - 1 back hole
front_hole_dist = 17.5;
front_back_dist = 31.8 + 2;  // 1 = distance motor block - back hole
back_axis_dist = 11.2;

// hole diameters
tie_hole = 3;
axis_hole = 7.2;
picot_hole = 5;


// sizes after to adaption to hole scheme
vert_offset = 6;     // from border to tie hole center
piece_height = 2*vert_offset + front_back_dist;
hh = ceil((piece_height - 2*pad + space) / (space+hole));
h = hh*hole + (hh-1)*space + 2*pad;
l = motor_length + 2*pad;
w = motor_width + pad + pad + hole + pad + pad;
tie_offset = (motor_width - front_hole_dist)/2 + pad;
mw = motor_width + pad;


difference() {
    cube([l, w, h]);
    
    // motor hollow
    translate([pad, -pad, -pad]) {
        cube([motor_length, mw + pad, h + 2*pad]);
    };

    // bar hollow
    bar_offx = left ? pad : (l - 3*pad - hole);
    translate([bar_offx, w - hole - 2*pad, -pad]) {
        cube([hole+2*pad, hole+3*pad, h + 2*pad]);
    };

    // outside bar hollow
    hollow_offx = left ? hole + 4*pad : -pad;
    translate([
        hollow_offx,
        w - hole - 2*pad,
        -pad
    ]) {
        cube([
            l - hole - 3*pad,
            hole+3*pad,
            h + 2*pad]
        );
    };

    // bar holes
    for(i=[1:hh]) {
        translate([
            (l + 2*pad)/2 - pad,
            w - pad - hole/2,
            i*hole + (i-1)*space - hole/2 + pad
        ]) {
            rotate([0, 90, 0]) {
                translate([0, 0, -(l + 2*pad)/2]) {
                    cylinder(h=w + 2*pad, r=hole/2 + 0.2);
                };
            };
        };
    };

    // tie hole (bottom)
    translate([
        (l + 2*pad)/2 - pad,
        tie_offset,
        vert_offset
    ]) {
        rotate([0, 90, 0]) {
            translate([
                0,
                0,
                -(l + 2*pad)/2
            ]) {
                cylinder(
                    h=l + 2*pad,
                    r=tie_hole/2 + 0.2
                );
            };
        };
    };

    // tie hole (top)
    translate([
        (l + 2*pad)/2 - pad,
        tie_offset + front_hole_dist,
        vert_offset
    ]) {
        rotate([0, 90, 0]) {
            translate([
                0,
                0,
                -(l + 2*pad)/2
            ]) {
                cylinder(
                    h = l + 2*pad,
                    r = tie_hole/2 + 0.2
                );
            };
        };
    };



    // back hole
    translate([
        (l + 2*pad)/2 - pad,
        tie_offset + front_hole_dist/2,
        vert_offset + front_back_dist])
    {
        rotate([0, 90, 0]) {
            translate([
                0,
                0,
                -(l + 2*pad)/2
            ]) {
                cylinder(
                    h = l + 2*pad,
                    r = tie_hole/2 + 0.2
                );
            };
        };
    };

    // main hollow
    translate([
        -pad, 
        -pad,
        2*vert_offset
    ]) {
        cube([
            l + 2*pad,
            mw + pad,
            front_back_dist - 2*vert_offset
        ]);
    }
    
    // back main hollow
    translate([
        -pad,
        -2*pad,
        vert_offset + front_back_dist - vert_offset - pad
    ]) {
        cube([
            l + 2*pad,
            tie_offset + front_hole_dist/2 + 2*pad - tie_offset,
            h - vert_offset - front_back_dist + vert_offset + 2*pad
        ]);
    }

};

