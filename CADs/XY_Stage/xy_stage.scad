// ===========================================================================
// Visualize the whole XY-stage
// ===========================================================================

include <stepper_bracket.scad>;
include <double_pulley.scad>;

STAGE_LENGTH = 300;
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
module stepper_motor(pulleyOffset) {
    // Motor body
    cube([BRACKET_EDGE_LENGTH, BRACKET_EDGE_LENGTH, BRACKET_EDGE_LENGTH]);

    // Shaft with pulleys
    translate([BRACKET_EDGE_LENGTH / 2, BRACKET_EDGE_LENGTH / 2, -SHAFT_HEIGHT]) {
        cylinder(r=2.5, h=SHAFT_HEIGHT);
    }
    
    translate([BRACKET_EDGE_LENGTH / 2, BRACKET_EDGE_LENGTH / 2, -SHAFT_HEIGHT + pulleyOffset]) {
        cylinder(r=10, h=12);
    }
}

color("gold")
union() {
    translate([0, ANCHOR_WIDTH + ANCHOR_THICKNESS, STAGE_THICKNESS + ANCHOR_SHAFT_OVERHEAD + SHAFT_HEIGHT]) {
        stepper_motor(0);
    }

    translate([STAGE_LENGTH - BRACKET_EDGE_LENGTH, ANCHOR_WIDTH + ANCHOR_THICKNESS, STAGE_THICKNESS + ANCHOR_SHAFT_OVERHEAD + SHAFT_HEIGHT]) {
        stepper_motor(PULLEY_WIDTH - 2 + PULLEY_DISTANCE);
    }
}

// Double pulleys with M8 screws and 608ZZ bearings
module full_double_pulley() {
    // Double pulley
    rotate([0, 0, 90])
        double_pulley();

    translate([-PULLEY_CENTER, PULLEY_CENTER, 0]) {
        // M8 screw
        cylinder(r=PULLEY_INNER_DIAMETER / 2, h=PULLEY_HEIGHT);

        // 608ZZ bearings
        translate([0, 0, ANCHOR_THICKNESS + 1])
            cylinder(r=PULLEY_OUTER_DIAMETER / 2, h=PULLEY_WIDTH - 2);
        translate([0, 0, ANCHOR_THICKNESS + PULLEY_WIDTH + PULLEY_DISTANCE + 1])
            cylinder(r=PULLEY_OUTER_DIAMETER / 2, h=PULLEY_WIDTH - 2);
    }

}
color("thistle")
union() {
    translate([PULLEY_EDGE_LENGTH / 2 + BRACKET_EDGE_LENGTH / 2, 
               STAGE_LENGTH - PULLEY_EDGE_LENGTH - ANCHOR_WIDTH - PULLEY_BACK_THICKNESS, 
               STAGE_THICKNESS]) {
        full_double_pulley();
    }
             
    translate([STAGE_LENGTH + PULLEY_EDGE_LENGTH / 2 - BRACKET_EDGE_LENGTH / 2, 
               STAGE_LENGTH - PULLEY_EDGE_LENGTH - ANCHOR_WIDTH - PULLEY_BACK_THICKNESS, 
               STAGE_THICKNESS]) {
        full_double_pulley();
    }
}
