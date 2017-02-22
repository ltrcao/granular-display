// Using a portion of the servo arm mount from http://www.thingiverse.com/thing:1156995
MOUNT_THICKNESS = 5;

difference() {
    // Mount piece for ball caster
    cube([15, MOUNT_THICKNESS, 15]);

    // 1st bolt hole's xy-coordinate
    x = 2.5; y = 4.5;
    // Mounting screws' triangle edge length
    l = 10; // TODO Determine this from the actual ball caster

    // 1st M3 bolt hole
    translate([x, MOUNT_THICKNESS, y]) {
        rotate([90, 0, 0]) {
            cylinder(r=1.5, h=MOUNT_THICKNESS, $fn=40);
        }
    }

    // 2nd M3 bolt hole
    translate([x, MOUNT_THICKNESS, y]) {
        rotate([90, 0, 0]) {
            translate([l, 0, 0]) {
                cylinder(r=1.5, h=MOUNT_THICKNESS, $fn=40);
            }
        }
    }

    // 3rd M3 bolt hole
    translate([x, MOUNT_THICKNESS, y]) {
        rotate([90, -60, 0]) {
            translate([l, 0, 0]) {
                cylinder(r=1.5, h=MOUNT_THICKNESS, $fn=40);
            }
        }
    }
}

// Eye-balling shenanigans to get the arm mount to sit flush against the xz-plane on one side.
translate([-0.3, -7.68, 0]) {
    rotate([0, 0, -2.2]) {
        import("servo_arm_mount.stl");
    }
}
