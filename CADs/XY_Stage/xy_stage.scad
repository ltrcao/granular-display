// ===========================================================================
// Visualize the whole XY-stage
// ===========================================================================

include <stepper_bracket.scad>;
include <double_pulley.scad>;
include <stage_bracket.scad>;
include <platform.scad>;

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
        cylinder(r=STEPPER_MOTOR_PULLEY_DIAMETER / 2, h=STEPPER_MOTOR_PULLEY_HEIGHT);
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

// Horizontal rod brackets
module full_stage_bracket() {
    stage_bracket();

    translate([PULLEY_CENTER + PULLEY_BACK_THICKNESS, PULLEY_CENTER, 0]) {
        // M8 screw
        cylinder(r=PULLEY_INNER_DIAMETER / 2, h=PULLEY_HEIGHT);

        // 608ZZ bearings
        translate([0, 0, ANCHOR_THICKNESS + 1])
            cylinder(r=PULLEY_OUTER_DIAMETER / 2, h=PULLEY_WIDTH - 2);
        translate([0, 0, ANCHOR_THICKNESS + PULLEY_WIDTH + PULLEY_DISTANCE + 1])
            cylinder(r=PULLEY_OUTER_DIAMETER / 2, h=PULLEY_WIDTH - 2);
    }
}

color("yellow")
translate([0, 0, STAGE_THICKNESS])
union() {
    translate([BRACKET_EDGE_LENGTH / 2, STAGE_LENGTH / 2, 0])
        full_stage_bracket();
        
    translate([STAGE_LENGTH - BRACKET_EDGE_LENGTH / 2, STAGE_LENGTH / 2, 0])
        translate([0, PULLEY_EDGE_LENGTH, 0])
            rotate([0, 0, 180])
                full_stage_bracket();
}

// Platform
translate([172, 174, STAGE_THICKNESS]) {
    rotate([0, 0, 180])
        platform();
}

// Timing belts. These are manually placed so changing configurations might mess them up.
color("lightcyan") {
    translate([BRACKET_EDGE_LENGTH / 2 - 2 - STEPPER_MOTOR_PULLEY_DIAMETER / 2, 65, STAGE_THICKNESS + ANCHOR_THICKNESS + 1])
        cube([2, 175, 6]);

    translate([BRACKET_EDGE_LENGTH / 2 + STEPPER_MOTOR_PULLEY_DIAMETER / 2, 65, STAGE_THICKNESS + ANCHOR_THICKNESS + 1])
        cube([2, 90, 6]);
        
    translate([STAGE_LENGTH - BRACKET_EDGE_LENGTH / 2 - 2 + STEPPER_MOTOR_PULLEY_DIAMETER / 2, 
               65, 
               STAGE_THICKNESS + ANCHOR_THICKNESS + 1 + PULLEY_WIDTH + PULLEY_DISTANCE])
        cube([2, 175, 6]);

    translate([STAGE_LENGTH - BRACKET_EDGE_LENGTH / 2 - STEPPER_MOTOR_PULLEY_DIAMETER / 2,
               65, 
               STAGE_THICKNESS + ANCHOR_THICKNESS + 1 + PULLEY_WIDTH + PULLEY_DISTANCE])
        cube([2, 90, 6]);

    translate([20,
               252,
               STAGE_THICKNESS + ANCHOR_THICKNESS + 1])
        cube([250, 2, 6]);

    translate([20,
               252,
               STAGE_THICKNESS + ANCHOR_THICKNESS + 1 + PULLEY_WIDTH + PULLEY_DISTANCE])
        cube([250, 2, 6]);
        
    translate([32,
               165,
               STAGE_THICKNESS + ANCHOR_THICKNESS + 1 + PULLEY_WIDTH + PULLEY_DISTANCE])
        rotate([0, 0, 15])
        cube([2, 75, 6]);

    translate([268,
               165,
               STAGE_THICKNESS + ANCHOR_THICKNESS + 1])
        rotate([0, 0, -15])
        cube([2, 75, 6]);
        
    translate([167,
               155,
               STAGE_THICKNESS + ANCHOR_THICKNESS + 1])
        cube([100, 2, 6]);
        
    translate([32,
               155,
               STAGE_THICKNESS + ANCHOR_THICKNESS + 1 + PULLEY_WIDTH + PULLEY_DISTANCE])
        cube([100, 2, 6]);
        
    translate([170,
               172, 
               STAGE_THICKNESS + ANCHOR_THICKNESS + 1 + PULLEY_WIDTH + PULLEY_DISTANCE])
        cube([90, 2, 6]);

    
    translate([40, 172, STAGE_THICKNESS + ANCHOR_THICKNESS + 1])
        cube([90, 2, 6]);
        
}

// Horizontal rod
translate([BRACKET_EDGE_LENGTH / 2, 
           STAGE_LENGTH / 2 + PULLEY_EDGE_LENGTH / 2, 
           PULLEY_HEIGHT + ROD_BRACKET_DIAMETER / 2 + ROD_BRACKET_THICKNESS / 2 + STAGE_THICKNESS])
    rotate([0, 90, 0])
        cylinder(r=ROD_BRACKET_DIAMETER / 2, h=260);
