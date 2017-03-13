// Using a portion of the servo arm mount from http://www.thingiverse.com/thing:1156995
MOUNT_THICKNESS = 5;
MOUNT_DISTANCE = 12;
BRIDGE_THICKNESS = 20;

one_inch_mount();
//three_quarter_mount();

module one_inch_mount() {
    translate([0, MOUNT_DISTANCE, 0]) {
        one_inch_block();
    }
    arm_mount();
}

module three_quarter_mount() {
    translate([0, MOUNT_DISTANCE, 0]) {
        three_quarter_block();
    }
    arm_mount();
}

// Arrange M2 bolt holes spaced by a 15mm distance center-to-center on a block
module three_quarter_block() {
    difference() {
        // Mount piece for ball caster
        translate([-3, 0, 0]) {
            cube([18, MOUNT_THICKNESS, 13]);
        }

        // 1st bolt hole's xy-coordinate
        x = -1.5; y = 7.5;
        // Mounting screws' triangle edge length
        l = 15; // 3/4" ball caster has 15mm center-to-center distance
        b = 1; // 3/4" ball caster uses M2 bolts

        // 1st M2 bolt hole
        translate([x, MOUNT_THICKNESS, y]) {
            rotate([90, 0, 0]) {
                translate([0, 0, -MOUNT_THICKNESS]) {
                    cylinder(r=b, h=3*MOUNT_THICKNESS, $fn=40);
                }
            }
        }

        // 2nd M2 bolt hole
        translate([x, MOUNT_THICKNESS, y]) {
            rotate([90, 0, 0]) {
                translate([l, 0, -MOUNT_THICKNESS]) {
                    cylinder(r=b, h=3*MOUNT_THICKNESS, $fn=40);
                }
            }
        }
    }
}

// Arrange M3 bolt holes spaced by a 12mm distance center-to-center on a block
module one_inch_block() {
    difference() {
        // Mount piece for ball caster
        cube([16, MOUNT_THICKNESS, 22]);

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

module arm_mount() {
    // Eye-balling shenanigans to get the arm mount to sit flush against the xz-plane on one side.
    translate([-0.3, -7.68, 0]) {
        rotate([0, 0, -2.2]) {
            import("servo_arm_mount.stl");
        }
    }

    // Also add a small bridge
    translate([0, -7.5, -BRIDGE_THICKNESS])
    cube([16, MOUNT_DISTANCE + MOUNT_THICKNESS + 7.5, BRIDGE_THICKNESS]);
}
