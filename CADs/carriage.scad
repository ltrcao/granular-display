// Basing on C-Bot Bowden carriage design at http://openbuilds.com/builds/c-bot.1146/
// Also using servo bracket from http://www.thingiverse.com/thing:1310167
MOUNT_THICKNESS = 5;
MOUNT_DISTANCE = 12;
BRIDGE_THICKNESS = 20;


//print_tray();
//render();

translate([0,0,00]) platform(true);
//platform(true);



// Assemble printables on a tray for easy printing
module print_tray() {
    translate([5, 0, 5])
        rotate([0, 90, 0]) 
            front_plate();

    translate([0, 0, 0])
        rotate([0, -90, 0]) 
            rear_plate();

    translate([0, 85, 0])
        platform();
}

// Visualize carriage with plastic overhang
module render() {
    front_plate();
    translate([5 + 6.5 * 2 + 9, 0, 0]) { // plate thickness + 2 * spacers + wheel thickness
        rear_plate();
    }
    translate([-13, 20, 72.5]) {
        platform();
    }
}

// Platform to be screwed on top of overhang
module platform(stabilizers=false) {
    width = 5 * 2 + 6.5 * 2 + 9 + 13 * 2; // plate thickness + gap distance + 2 * overhang width

    difference() {
        // Platform itself
        cube([width, 40, 5]);

        // M5 bolt holes
        translate([width / 2, 20, 0]) {
            translate([0, -12, 0]) {
                translate([-23, 0, 0])
                    cylinder(r=2.5, h=5);
                translate([23, 0, 0])
                    cylinder(r=2.5, h=5);
            }
            translate([0, 12, 0]) {
                translate([-23, 0, 0])
                    cylinder(r=2.5, h=5);
                translate([23, 0, 0])
                    cylinder(r=2.5, h=5);
            }
            translate([0,0,0]){
                cylinder(r=2.5, h=5);
            }
        }
        
        if(!stabilizers){
            translate([width/2-8.1,32,0]){
                rotate([90,0,0]){
                    // 1st bolt hole's xy-coordinate
                    x = 2; y = 7.5;
                    // Mounting screws' triangle edge length
                    l = 12; // 1" ball caster has 12mm center-to-center distance
                    b = 1.5; // 1" ball caster uses M3 bolts

                    // 1st M3 bolt hole
                    translate([x, MOUNT_THICKNESS, y]) {
                        rotate([90, 0, 0]) {
                            translate([0, 0, -MOUNT_THICKNESS]) {
                                cylinder(r=b, h=3*MOUNT_THICKNESS, $fn=40);
                            }
                        }
                    }

                    // 2nd M3 bolt hole
                    translate([x, MOUNT_THICKNESS, y]) {
                        rotate([90, 0, 0]) {
                            translate([l, 0, -MOUNT_THICKNESS]) {
                                cylinder(r=b, h=3*MOUNT_THICKNESS, $fn=40);
                            }
                        }
                    }

                    // 3rd M3 bolt hole
                    translate([x, MOUNT_THICKNESS, y]) {
                        rotate([90, -60, 0]) {
                            translate([l, 0, -MOUNT_THICKNESS]) {
                                cylinder(r=b, h=3*MOUNT_THICKNESS, $fn=40);
                            }
                        }
                    }
                }
            }
        
            translate([width/2-20.25,(40/2)-4.25,-10]){
                cube([8.5,8.5,30]);
                translate([30.25,0,0]) cube([8.5,8.5,30]);
            }
        }
    }
    
    //horizontal stabilizers
    if(stabilizers){
        translate([width/2-20,(40/2)-4,0]){
            cube([8,8,30]);
            translate([30,0,0]) cube([8,8,30]);
        }
    }else{
        translate([20,32,10]){
            rotate([90,0,0]) {
                //import("onein_ball_mount.stl");
            }
        }
    }

    translate([24.25, -5, 1]) {
        // Trimmed servo bracket
        difference() {
            servo_bracket();
            cube([10, 8.3, 5.5]);
            translate([0, 41.7, 0])
                cube([10, 8.3, 6]);
        }
    }
}


// Arrange M3 bolt holes spaced by a 12mm distance center-to-center on a block
module one_inch_block() {
    difference() {
        // Mount piece for ball caster
        cube([16, MOUNT_THICKNESS, 22]);

    }
}

// Servo bracket translated to origin
module servo_bracket() {
    translate([10, 25, 15]) {
        import("servo_bracket.stl", convexity=3);
    }
}

// Overhang for placing the imprint actuator
module overhang() {
    difference() {
        union() {
            cube([5, 40, 15 + 2]);
            translate([-13, 0, 15 + 2]) {
                cube([5 + 13, 40, 5]);
            }
        }

        // M5 bolt holes
        translate([-7, 20, 15 + 2]) {
            translate([0, -12, 0]) {
                cylinder(r=2.5, h=5);
            }
            translate([0, 12, 0]) {
                cylinder(r=2.5, h=5);
            }
        }
    }
}

// Modify original front plate to fit the granular display imprint actuator
module front_plate() {
    // Remove hotend brace
    difference() {
        front_plate_template();
        translate([-10, 25, 50])
            cube([10, 30, 15]);
    }

    // Overhanging platform
    translate([0, 20, 50]) {
        overhang();
    }
}

// Modify original rear plate to fit the granular display imprint actuator
module rear_plate() {
    rear_plate_template();
    
    // Overhanging platform
    translate([5, 60, 50]) {
        rotate([0, 0, 180])
        overhang();
    }
}

// Import rear plate, translate to origin, and rotate upright
module rear_plate_template() {
    translate([0, -130, 132.5]) {
        rotate([0, 90, 0]) {
            import("C-Bot_carriage/template/C-Bot Bowden Carriage Rear Plate (x1).stl", convexity=5);
        }
    }
}

// Import front plate, translate to origin, and rotate upright
module front_plate_template() {
    translate([5, -130, -67]) {
        rotate([0, -90, 0]) {
            import("C-Bot_carriage/template/C-Bot Bowden Single Front Plate (x1).stl", convexity=5);
        }
    }
}

// Import V-Wheel spacer, translate to origin, and rotate upright
module spacer() {
    translate([0, -165, 105]) {
        rotate([0, 90, 0]) {
            import("C-Bot_carriage/C-Bot V-Wheel Spacer (x8).stl");
        }
    }
}
