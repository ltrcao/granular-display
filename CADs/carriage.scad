// Basing on C-Bot Bowden carriage design at http://openbuilds.com/builds/c-bot.1146/

print_tray();
//render();

// Assemble the plates on a tray for printing
module print_tray() {
    translate([5, 0, 5])
        rotate([0, 90, 0]) 
            front_plate();

    translate([0, 0, 0])
        rotate([0, -90, 0]) 
            rear_plate();
}

// Visualize carriage with plastic overhang
module render() {
    front_plate();
    translate([5 + 6.5 * 2 + 9, 0, 0]) { // plate thickness + 2 * spacers + wheel thickness
        rear_plate();
    }
}

// Platform/Overhang plastic for placing the imprint actuator
module platform() {
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
        platform();
    }
}

// Modify original rear plate to fit the granular display imprint actuator
module rear_plate() {
    rear_plate_template();
    
    // Overhanging platform
    translate([5, 60, 50]) {
        rotate([0, 0, 180])
        platform();
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
