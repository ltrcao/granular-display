// ===========================================================================
// Bracket for stepper motor, including anchor.
//     Stepper motor is assumed to have NEMA 17 dimensions.
//     Metric screws are used. Their diameters may be changed in the config.
// ===========================================================================

// Specifications are for NEMA 17 dimensions.
// Reference: http://www.reprap.org/wiki/File:Step_motor_nema_17_stepper_motor.jpg

include <config.scad>;

$fn = 20;
module stepper_bracket() {
    // Add offset for easier use in other codes
    translate([ANCHOR_THICKNESS + ANCHOR_WIDTH, BRACKET_EDGE_LENGTH, SHAFT_HEIGHT + ANCHOR_SHAFT_OVERHEAD]) {
        // Rotate to place anchor down
        rotate([180, 0, 0]) {
            // Bracket part
            difference() {
                // Bracket base
                cube([BRACKET_EDGE_LENGTH, BRACKET_EDGE_LENGTH, BRACKET_THICKNESS]);

                // Bracket hole 
                translate([BRACKET_EDGE_LENGTH / 2, BRACKET_EDGE_LENGTH / 2, 0])
                    cylinder(r=BRACKET_DIAMETER / 2, h=BRACKET_THICKNESS);

                // Screw holes
                translate([BRACKET_EDGE_LENGTH / 2 - SCREW_DISTANCE / 2, BRACKET_EDGE_LENGTH / 2 - SCREW_DISTANCE / 2, 0])
                    cylinder(r=SCREW_DIAMETER / 2, h=BRACKET_THICKNESS);

                translate([BRACKET_EDGE_LENGTH / 2 + SCREW_DISTANCE / 2, BRACKET_EDGE_LENGTH / 2 - SCREW_DISTANCE / 2, 0])
                    cylinder(r=SCREW_DIAMETER / 2, h=BRACKET_THICKNESS);

                translate([BRACKET_EDGE_LENGTH / 2 - SCREW_DISTANCE / 2, BRACKET_EDGE_LENGTH / 2 + SCREW_DISTANCE / 2, 0])
                    cylinder(r=SCREW_DIAMETER / 2, h=BRACKET_THICKNESS);

                translate([BRACKET_EDGE_LENGTH / 2 + SCREW_DISTANCE / 2, BRACKET_EDGE_LENGTH / 2 + SCREW_DISTANCE / 2, 0])
                    cylinder(r=SCREW_DIAMETER / 2, h=BRACKET_THICKNESS);

                // Only a fraction of the bracket is really necessary
                translate([2 * BRACKET_EDGE_LENGTH / 5, 0, 0])
                    cube([3 * BRACKET_EDGE_LENGTH / 5, BRACKET_EDGE_LENGTH, BRACKET_THICKNESS]);
            }


            // Anchor part
            translate([-ANCHOR_THICKNESS, 0, 0]) {
                union() {
                    // Anchor wall
                    cube([ANCHOR_THICKNESS, BRACKET_EDGE_LENGTH, SHAFT_HEIGHT + ANCHOR_SHAFT_OVERHEAD]);

                    // Anchor
                    translate([-ANCHOR_WIDTH, 0, SHAFT_HEIGHT + ANCHOR_SHAFT_OVERHEAD - BRACKET_THICKNESS])
                    difference() {
                        // Anchor base
                        cube([ANCHOR_WIDTH, BRACKET_EDGE_LENGTH, ANCHOR_THICKNESS]);

                        // Screw holes
                        translate([ANCHOR_SCREW_MARGIN, ANCHOR_SCREW_MARGIN, 0])
                            cylinder(r=ANCHOR_SCREW_DIAMETER / 2, h = ANCHOR_THICKNESS);
                            
                        translate([ANCHOR_WIDTH - ANCHOR_SCREW_MARGIN, ANCHOR_SCREW_MARGIN, 0])
                            cylinder(r=ANCHOR_SCREW_DIAMETER / 2, h = ANCHOR_THICKNESS);
                            
                        translate([ANCHOR_WIDTH - ANCHOR_SCREW_MARGIN, BRACKET_EDGE_LENGTH - ANCHOR_SCREW_MARGIN, 0])
                            cylinder(r=ANCHOR_SCREW_DIAMETER / 2, h = ANCHOR_THICKNESS);

                        translate([ANCHOR_SCREW_MARGIN, BRACKET_EDGE_LENGTH - ANCHOR_SCREW_MARGIN, 0])
                            cylinder(r=ANCHOR_SCREW_DIAMETER / 2, h = ANCHOR_THICKNESS);
                    }
                }
            }
        }
    }
}
