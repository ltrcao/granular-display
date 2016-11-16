// ===========================================================================
// Visualize the whole XY-stage
// ===========================================================================

include <stepper_bracket.scad>;

STAGE_LENGTH = 400;
STAGE_THICKNESS = 10;

// XY base
color("aqua")
cube([STAGE_LENGTH, STAGE_LENGTH, STAGE_THICKNESS]);

// Stepper brackets
color("greenyellow")
union() {
    translate([BRACKET_EDGE_LENGTH, 0, STAGE_THICKNESS])
        rotate([0, 0, 90])
            stepper_bracket();

    translate([STAGE_LENGTH, 0, STAGE_THICKNESS])
        rotate([0, 0, 90])
            stepper_bracket();
}

// Stepper motor mockups
module stepper_motor() {
    // Motor body
    cube([BRACKET_EDGE_LENGTH, BRACKET_EDGE_LENGTH, BRACKET_EDGE_LENGTH]);

    // Shaft with pulleys
    translate([BRACKET_EDGE_LENGTH / 2, BRACKET_EDGE_LENGTH / 2, -SHAFT_HEIGHT]) {
        cylinder(r=2.5, h=SHAFT_HEIGHT);
    }
    
    translate([BRACKET_EDGE_LENGTH / 2, BRACKET_EDGE_LENGTH / 2, -SHAFT_HEIGHT]) {
        cylinder(r=10, h=12);
    }
}
color("gold")
union() {
    translate([0, ANCHOR_WIDTH + ANCHOR_THICKNESS, STAGE_THICKNESS + ANCHOR_SHAFT_OVERHEAD + SHAFT_HEIGHT]) {
        stepper_motor();
    }

    translate([STAGE_LENGTH - BRACKET_EDGE_LENGTH, ANCHOR_WIDTH + ANCHOR_THICKNESS, STAGE_THICKNESS + ANCHOR_SHAFT_OVERHEAD + SHAFT_HEIGHT]) {
        stepper_motor();
    }
}


