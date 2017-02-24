// Parametric variables
MOUNT_HEIGHT = 30;
MOUNT_TOP_WIDTH = 70;
MOUNT_TOP_LENGTH = 70;


// Constants below shouldn't be changed. They're specific to the C-Bot corner pieces.
MOUNT_TOTAL_HEIGHT = 85 + MOUNT_HEIGHT; // 85 is height of the C-Bot corner pieces.
MOUNT_THICKNESS = 5;
REAR_MOUNT_SIDE_WIDTH = 25 + MOUNT_THICKNESS;
FRONT_MOUNT_SIDE_WIDTH = 20 + 2 * MOUNT_THICKNESS;


//print_tray();
visualize();

// Assemble printables onto a tray
module print_tray() {
    translate([MOUNT_TOTAL_HEIGHT + 10, 0, 0 ]) {
        rotate([0, -90, 0]) {
            rear_mount();
        }
    }

    translate([-MOUNT_TOTAL_HEIGHT - 10, 30, 95]) {
        rotate([0, 90, 0]) {
            rear_mount_f();
        }
    }

    translate([MOUNT_TOTAL_HEIGHT + 10, 45, 0 ]) {
        rotate([0, -90, 0]) {
            front_mount();
        }
    }
    
    translate([-MOUNT_TOTAL_HEIGHT - 10, 45, 0]) {
        rotate([0, 90, 0]) {
            front_mount_f();
        }
    }
}

// Assemble parts into their intended locations for visualization
module visualize() {
    distance = 200;
    rear_idler();
    translate([-MOUNT_THICKNESS, -REAR_MOUNT_SIDE_WIDTH + MOUNT_THICKNESS, 0]) {
        rear_mount();
    }

    translate([distance, 0, 0]) {
        rear_mount_f();
        rear_idler_f();
    }

    translate([0, -distance, 0]) {
        motor_mount_left();
        translate([-MOUNT_THICKNESS, -FRONT_MOUNT_SIDE_WIDTH, 0]) {
            front_mount();
        }
    }
    
    translate([90 + distance, -distance, 0]) {
        motor_mount_right();
        translate([MOUNT_THICKNESS, -FRONT_MOUNT_SIDE_WIDTH, 0]) {
            front_mount_f();
        }
    }
}

// Display mount to be attached to motor mount piece
module front_mount() {
    // Part for mounting to front motor mount's side
    difference() {
        cube([MOUNT_THICKNESS, FRONT_MOUNT_SIDE_WIDTH, MOUNT_TOTAL_HEIGHT]);

        // 2nd M5 hole
        translate([-MOUNT_THICKNESS, 20, 30]) {
            rotate([0, 90, 0]) {
                cylinder(r=2.5, h=3 * MOUNT_THICKNESS, $fn=40);
            }
        }

        translate([-MOUNT_THICKNESS, 20, 10]) {
            rotate([0, 90, 0]) {
                cylinder(r=6, h=3 * MOUNT_THICKNESS);
            }
        }

        translate([-MOUNT_THICKNESS, 20, 50]) {
            rotate([0, 90, 0]) {
                cylinder(r=6, h=3 * MOUNT_THICKNESS);
            }
        }

        translate([-MOUNT_THICKNESS, 20, 70]) {
            rotate([0, 90, 0]) {
                cylinder(r=6, h=3 * MOUNT_THICKNESS);
            }
        }
    }

    // Part for clamping granular display
    translate([0, 0, MOUNT_TOTAL_HEIGHT]) {
        cube([MOUNT_TOP_WIDTH, MOUNT_TOP_LENGTH, MOUNT_THICKNESS]);

        translate([MOUNT_THICKNESS, 0, -MOUNT_HEIGHT]) {
            rotate([-90, -90, 0]) {
                supportive_arch(MOUNT_HEIGHT, MOUNT_TOP_WIDTH - MOUNT_THICKNESS, MOUNT_THICKNESS);
            }
        }

        translate([MOUNT_THICKNESS, FRONT_MOUNT_SIDE_WIDTH, -MOUNT_HEIGHT]) {
            rotate([0, -90, 0]) {
                supportive_arch(MOUNT_HEIGHT, MOUNT_TOP_LENGTH - FRONT_MOUNT_SIDE_WIDTH, MOUNT_THICKNESS);
            }
        }
    }
}

// Flipped front mount piece
module front_mount_f() {
    mirror([1, 0, 0]) {
        front_mount();
    }
}

// Display mount to be attached to rear idler
module rear_mount() {
    // Part for mounting to rear idler's side
    difference() {
        cube([MOUNT_THICKNESS, REAR_MOUNT_SIDE_WIDTH, MOUNT_TOTAL_HEIGHT]);

        // Bottom M5 hole
        translate([-MOUNT_THICKNESS, 10, 10]) {
            rotate([0, 90, 0]) {
                cylinder(r=2.5, h=3 * MOUNT_THICKNESS, $fn=40);
            }
        }

        // Top M5 hole
        translate([-MOUNT_THICKNESS, 10, 30]) {
            rotate([0, 90, 0]) {
                cylinder(r=2.5, h=3 * MOUNT_THICKNESS, $fn=40);
            }
        }
    }

    // Part for clamping granular display
    translate([0, -MOUNT_TOP_LENGTH + REAR_MOUNT_SIDE_WIDTH, MOUNT_TOTAL_HEIGHT]) {
        cube([MOUNT_TOP_WIDTH, MOUNT_TOP_LENGTH, MOUNT_THICKNESS]);

        translate([MOUNT_THICKNESS, MOUNT_TOP_LENGTH - MOUNT_THICKNESS, -MOUNT_HEIGHT]) {
            rotate([-90, -90, 0]) {
                supportive_arch(MOUNT_HEIGHT, MOUNT_TOP_WIDTH - MOUNT_THICKNESS, MOUNT_THICKNESS);
            }
        }

        translate([0, MOUNT_TOP_LENGTH - REAR_MOUNT_SIDE_WIDTH, -MOUNT_HEIGHT]) {
            rotate([180, -90, 0]) {
                supportive_arch(MOUNT_HEIGHT, MOUNT_TOP_LENGTH - REAR_MOUNT_SIDE_WIDTH, MOUNT_THICKNESS);
            }
        }
    }
}

// Flipped rear mount piece
module rear_mount_f() {
    translate([95, -REAR_MOUNT_SIDE_WIDTH + 5, 0]) {
        mirror([1, 0, 0]) {
            rear_mount();
        }
    }
}

// Triangular arch for supporting top platforms
module supportive_arch(length, width, thickness) {
    difference() {
        cube([length, width, thickness]);
        translate([0, 0, -thickness]) {
            rotate([0, 0, atan2(width, length)]) {
                cube([length * 4, width * 4, 3*thickness]);
            }
        }
    }
}

// Translate/rotate left motor mount .stl so that it sits at origin
module motor_mount_left() {
    translate([0, -52.325, 40]) {
        rotate([0, 90, 0]) {
            import("C-Bot_base/C-BOT XY Motor Mount Left (x1).stl", convexity=3);
        }
    }
}

// Translate/rotate left motor mount .stl so that it sits at origin
module motor_mount_right() {
    translate([0, -136.25, 212.5]) {
        rotate([-90, 0, 90]) {
            import("C-Bot_base/C-BOT XY Motor Mount Right (x1).stl", convexity=3);
        }
    }
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
