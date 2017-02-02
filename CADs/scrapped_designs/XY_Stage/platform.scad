// ===========================================================================
// Platform moving on the horizontal gantry.
// ===========================================================================

include <config.scad>;

$fn = 40;

// Timing belt trappers
module timing_belt_trapper() {
    difference() {
        union() {
            translate([-TIMING_BELT_TRAP_THICKNESS - TIMING_BELT_CREST + TIMING_BELT_TROUGH, 0, 0]) {
                cube([TIMING_BELT_TRAP_THICKNESS + TIMING_BELT_CREST, TIMING_BELT_TRAP_WIDTH, ANCHOR_THICKNESS]);
            }
            
            translate([TIMING_BELT_TROUGH - TIMING_BELT_TRAP_THICKNESS - TIMING_BELT_CREST, 0, ANCHOR_THICKNESS]) {
                cube([TIMING_BELT_TRAP_THICKNESS, TIMING_BELT_TRAP_WIDTH, PULLEY_WIDTH]);
            }
        }

        //translate([TIMING_BELT_TROUGH, 0, 0]) {
        //    rotate([0, -125, 0])
        //        cube([100, 100, 100]);
        //}
    }

    for (offset = [0 : TIMING_BELT_PITCH : 5 * TIMING_BELT_PITCH]) {
        translate([0, offset, ANCHOR_THICKNESS]) {
            cube([TIMING_BELT_TROUGH, TIMING_BELT_PITCH / 2, PULLEY_WIDTH]);
        }
    }
}

// Platform
module platform() {
    // Rod bracket
    difference() {
        // Rod bracket base
        union() {
            translate([0, 0, PULLEY_HEIGHT])
                cube([PLATFORM_LENGTH, LINEAR_BEARING_BRACKET_WIDTH, LINEAR_BEARING_BRACKET_WIDTH]);

            // Platform base
            cube([PLATFORM_LENGTH, PLATFORM_WIDTH, PULLEY_HEIGHT]);

        }

        // Opening for the actual rod & linear bearing
        translate([0, 
                   LINEAR_BEARING_BRACKET_WIDTH / 2, 
                   PULLEY_HEIGHT + ROD_BRACKET_DIAMETER / 2 + ROD_BRACKET_THICKNESS / 2])
            rotate([0, 90, 0])
                cylinder(r=LINEAR_BEARING_OUTER_DIAMETER / 2, h=PLATFORM_LENGTH);

        // Opening to insert the linear bearings
        translate([0, 
                   LINEAR_BEARING_BRACKET_WIDTH / 2 - 0.05 * LINEAR_BEARING_BRACKET_WIDTH, 
                   PULLEY_HEIGHT + LINEAR_BEARING_BRACKET_WIDTH / 2])
            cube([PLATFORM_LENGTH, 0.1 * LINEAR_BEARING_BRACKET_WIDTH, LINEAR_BEARING_BRACKET_WIDTH]);

    }

    // Timing belt trappers
    translate([-TIMING_BELT_TROUGH, LINEAR_BEARING_BRACKET_WIDTH, 0]) {
        timing_belt_trapper();
    }
    
    translate([PLATFORM_LENGTH + TIMING_BELT_TROUGH, TIMING_BELT_TRAP_WIDTH, 0]) {
        rotate([0, 0, 180])
            timing_belt_trapper();
    }
    
    translate([-TIMING_BELT_TROUGH, 0, PULLEY_DISTANCE + PULLEY_WIDTH]) {
        timing_belt_trapper();
    }
    
    translate([PLATFORM_LENGTH + TIMING_BELT_TROUGH, TIMING_BELT_TRAP_WIDTH + LINEAR_BEARING_BRACKET_WIDTH, PULLEY_DISTANCE + PULLEY_WIDTH]) {
        rotate([0, 0, 180])
            timing_belt_trapper();
    }

}

platform();
