// ===========================================================================
// Platform moving on the horizontal gantry.
// ===========================================================================

include <config.scad>;

$fn = 40;

// Timing belt trappers
module timing_belt_trapper_stub() {
    difference() {
        union() {
            translate([-TIMING_BELT_TRAP_THICKNESS - TIMING_BELT_CREST + TIMING_BELT_TROUGH, 0, 0]) {
                cube([TIMING_BELT_TRAP_THICKNESS + TIMING_BELT_CREST, TIMING_BELT_TRAP_WIDTH, ANCHOR_THICKNESS]);
            }
            
            translate([TIMING_BELT_TROUGH - TIMING_BELT_TRAP_THICKNESS - TIMING_BELT_CREST, 0, ANCHOR_THICKNESS]) {
                cube([TIMING_BELT_TRAP_THICKNESS, TIMING_BELT_TRAP_WIDTH, PULLEY_WIDTH]);
            }
        }
    }

    for (offset = [0 : TIMING_BELT_PITCH : 5 * TIMING_BELT_PITCH]) {
        translate([0, offset, ANCHOR_THICKNESS]) {
            cube([TIMING_BELT_TROUGH, TIMING_BELT_PITCH / 2, PULLEY_WIDTH]);
        }
    }

    translate([TIMING_BELT_TROUGH, 0, 0]) {
        cube([TIMING_BELT_TRAP_THICKNESS, TIMING_BELT_TRAP_WIDTH, PULLEY_WIDTH + ANCHOR_THICKNESS]);
    }
}

timing_belt_trapper_stub();
