// ===========================================================================
// Stage bracket with pulleys. These move the gantry vertically.
// Reference: http://www.corexy.com/theory.html
// ===========================================================================

include <config.scad>;

$fn = 20;

// Stage bracket
module stage_bracket() {
    // Offset for easier use in other codes
    translate([PULLEY_BACK_THICKNESS, 0, 0]) {
        // Double pulley
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

        // Rod bracket
        difference() {
            // Rod bracket base
            union() {
                translate([0, PULLEY_EDGE_LENGTH / 2 - ROD_BRACKET_LENGTH / 2, PULLEY_HEIGHT])
                    cube([ROD_BRACKET_WIDTH, ROD_BRACKET_LENGTH, ROD_BRACKET_LENGTH]);
            }

            // Opening for the actual rod
            translate([0, 
                       PULLEY_EDGE_LENGTH / 2, 
                       PULLEY_HEIGHT + ROD_BRACKET_DIAMETER / 2 + ROD_BRACKET_THICKNESS / 2])
                rotate([0, 90, 0])
                    cylinder(r=ROD_BRACKET_DIAMETER / 2, h=PULLEY_EDGE_LENGTH);
        }

        // Back structure
        translate([-PULLEY_BACK_THICKNESS, 0, 0])
            cube([PULLEY_BACK_THICKNESS, PULLEY_EDGE_LENGTH, PULLEY_HEIGHT + ROD_BRACKET_LENGTH]);
    }
}
