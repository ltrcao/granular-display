// Parametric variables
MOUNT_HEIGHT = 30;
MOUNT_THICKNESS = 5;
MOUNT_TOP_WIDTH = 90;
MOUNT_TOP_LENGTH = 60;


// Constants below shouldn't be changed. They're specific to the C-Bot corner pieces.
MOUNT_TOTAL_HEIGHT = 85 + MOUNT_HEIGHT; // 85 is height of the C-Bot corner pieces.
MOUNT_SIDE_WIDTH = 35;

visualize();

module visualize() {
    rear_idler();
    translate([-MOUNT_THICKNESS, -MOUNT_SIDE_WIDTH + 5, 0]) {
        rear_mount();
    }

    

    //translate([150, 0, 0]) {
    //    rear_idler_f();
    //}
}

// Display mount to be attached to rear idler
module rear_mount() {
    // Part for mounting to rear idler's side
    difference() {
        cube([MOUNT_THICKNESS, MOUNT_SIDE_WIDTH, MOUNT_TOTAL_HEIGHT]);

        // Bottom M5 hole
        translate([-MOUNT_THICKNESS, (MOUNT_SIDE_WIDTH - 5) / 2, 10]) {
            rotate([0, 90, 0]) {
                cylinder(r=2.5, h=2 * MOUNT_THICKNESS, $fn=40);
            }
        }

        // Top M5 hole
        translate([-MOUNT_THICKNESS, (MOUNT_SIDE_WIDTH - 5) / 2, 30]) {
            rotate([0, 90, 0]) {
                cylinder(r=2.5, h=2 * MOUNT_THICKNESS, $fn=40);
            }
        }
    }

    // Part for clamping granular display
    translate([0, -MOUNT_TOP_LENGTH + MOUNT_SIDE_WIDTH, MOUNT_TOTAL_HEIGHT]) {
        cube([MOUNT_TOP_WIDTH, MOUNT_TOP_LENGTH, MOUNT_THICKNESS]);

        translate([MOUNT_THICKNESS, MOUNT_TOP_LENGTH - MOUNT_THICKNESS, -MOUNT_HEIGHT]) {
            rotate([-90, -90, 0]) {
                supportive_arch(MOUNT_HEIGHT, MOUNT_TOP_WIDTH - MOUNT_THICKNESS, MOUNT_THICKNESS);
            }
        }

        translate([0, MOUNT_TOP_LENGTH - MOUNT_SIDE_WIDTH, -MOUNT_HEIGHT]) {
            rotate([180, -90, 0]) {
                supportive_arch(MOUNT_HEIGHT, MOUNT_TOP_LENGTH - MOUNT_SIDE_WIDTH, MOUNT_THICKNESS);
            }
        }
    }
}

// Triangular arch for supporting top platforms
module supportive_arch(length, width, thickness) {
    difference() {
        cube([length, width, thickness]);
        rotate([0, 0, atan2(width, length)]) {
            cube([length * 4, width * 4, thickness]);
        }
    }
}

// Translate/rotate left motor mount .stl so that it sits at origin
module motor_mount_left() {
    // TODO Actually translate/rotate
    import("C-Bot_base/C-BOT XY Motor Mount Left (x1).stl", convexity=3);
}

// Translate/rotate rear idler .stl so that it sits at origin
module rear_idler() {
    translate([-55, 0, -127.562]) { 
        rotate([90, 0, 0]) {
            import("C-Bot_base/C-BOT XY Rear Idler (x1).stl", convexity=3);
        }
    }
}

// Translate/rotate rear idler 2 .stl so that it sits at origin
module rear_idler_f() {
    translate([-55, 0, -127.562]) { 
        rotate([90, 0, 0]) {
            import("C-Bot_base/C-BOT XY Rear Idler F (x1).stl", convexity=3);
        }
    }
}
