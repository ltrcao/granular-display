// Using a portion of the servo arm mount from http://www.thingiverse.com/thing:1156995

// Mount piece for ball caster
cube([15, 5, 15]);

// TODO Figure out where the screw holes go on the ball caster.

// Eye-balling shenanigans to get the arm mount to sit flush against the xz-plane on one side.
translate([-0.3, -7.68, 0]) {
    rotate([0, 0, -2.2]) {
        import("servo_arm_mount.stl");
    }
}
