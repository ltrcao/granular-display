// ===========================================================================
// Double pulleys shown in the corner opposite of the stepper motors.
// Reference: http://www.corexy.com/theory.html
//
// Assuming 608ZZ bearings are used. Dimensions may be modified in the config.
// ===========================================================================

include <config.scad>;

$fn = 20;

// Double pulley
module double_pulley() {
    difference() {
        // Double pulley base
        cube([PULLEY_EDGE_LENGTH, PULLEY_EDGE_LENGTH, PULLEY_HEIGHT]);

        // Pulley screw
        translate([PULLEY_CENTER, PULLEY_CENTER, 0])
            cylinder(r=PULLEY_INNER_DIAMETER / 2, h=PULLEY_HEIGHT);

        // Lower pulley opening
        translate([0, 0, ANCHOR_THICKNESS])
            cube([PULLEY_EDGE_LENGTH, PULLEY_EDGE_LENGTH, PULLEY_WIDTH]);

        // Upper pulley opening
        translate([0, 0, PULLEY_HEIGHT - ANCHOR_THICKNESS - PULLEY_WIDTH])
            cube([PULLEY_EDGE_LENGTH, PULLEY_EDGE_LENGTH, PULLEY_WIDTH]);
    }

    // Pulley back structure
    translate([PULLEY_EDGE_LENGTH, 0, 0])
        cube([PULLEY_BACK_THICKNESS, PULLEY_EDGE_LENGTH, PULLEY_HEIGHT]);

    // Pulley anchor
    translate([PULLEY_EDGE_LENGTH + PULLEY_BACK_THICKNESS, 0, 0]) {
        difference() {
            // Anchor base
            cube([ANCHOR_WIDTH, PULLEY_EDGE_LENGTH, ANCHOR_THICKNESS]);

            // Screw holes
            translate([ANCHOR_SCREW_MARGIN, ANCHOR_SCREW_MARGIN, 0])
                cylinder(r=ANCHOR_SCREW_DIAMETER / 2, h = ANCHOR_THICKNESS);
                
            translate([ANCHOR_WIDTH - ANCHOR_SCREW_MARGIN, ANCHOR_SCREW_MARGIN, 0])
                cylinder(r=ANCHOR_SCREW_DIAMETER / 2, h = ANCHOR_THICKNESS);
                
            translate([ANCHOR_WIDTH - ANCHOR_SCREW_MARGIN, PULLEY_EDGE_LENGTH - ANCHOR_SCREW_MARGIN, 0])
                cylinder(r=ANCHOR_SCREW_DIAMETER / 2, h = ANCHOR_THICKNESS);

            translate([ANCHOR_SCREW_MARGIN, PULLEY_EDGE_LENGTH - ANCHOR_SCREW_MARGIN, 0])
                cylinder(r=ANCHOR_SCREW_DIAMETER / 2, h = ANCHOR_THICKNESS);
        }
    }
}
