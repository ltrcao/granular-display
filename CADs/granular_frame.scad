//// Dimension configuration ////
CELL_RADIUS = 1.5;
FRAME_THICKNESS = 2;
NUM_CELL_X = 3;
NUM_CELL_Y = 3;
CELL_SEPARATION_DISTANCE = 0.5;
FRAME_MARGIN_X = 1;
FRAME_MARGIN_Y = 1;

MOLD_THICKNESS = 1;
MOLD_HEIGHT = 1;

PIN_RADIUS = 1;
PIN_LOCK_RADIUS = 1.45;
PIN_LOCK_HEIGHT = 1;
PIN_HEIGHT = 8;
PIN_CONNECTION_THICKNESS = 0.45;
PIN_CONNECTION_WIDTH = 0.45;
PIN_GUIDE_RADIUS = 2;
PIN_GUIDE_LOCK_RADIUS = 1.6;
PIN_GUIDE_LOCK_HEIGHT = 0.75;
PIN_GUIDE_THICKNESS = 0.6;
PIN_GUIDE_FOUNDATION_THICKNESS = 1;
PIN_GUIDE_TOTAL_HEIGHT = 1 + PIN_GUIDE_FOUNDATION_THICKNESS;
/////////////////////////////////


//// Render configuration ////
RENDER_FRAME = true;
RENDER_MARGIN = false;
RENDER_MOLD = false;
RENDER_PUSH_PIN_GUIDE = false;
RENDER_PUSH_PIN = true;
RENDER_PUSH_PIN_CONNECTION = true;
RENDER_PUSH_PIN_LOCK = false;

RENDER_EXPLODE = false;
//////////////////////////////


$fn = 20;

cellSideLength = CELL_RADIUS * 2 + CELL_SEPARATION_DISTANCE * 2;


// create individual cells
if (RENDER_FRAME) {
    color("lavender") {
        for (offsetX = [0 : cellSideLength : cellSideLength * NUM_CELL_X - 0.001]) 
            for (offsetY = [0 : cellSideLength : cellSideLength * NUM_CELL_Y - 0.001]) 
                translate([offsetX, offsetY, 0])
                    difference() {
                        cube([cellSideLength, cellSideLength, FRAME_THICKNESS]);
                        translate([CELL_RADIUS + CELL_SEPARATION_DISTANCE, CELL_RADIUS + CELL_SEPARATION_DISTANCE, 0])
                            cylinder(r=CELL_RADIUS, h=FRAME_THICKNESS);
                    }
    }
}
// done creating individual cells


// create margins
if (RENDER_FRAME && RENDER_MARGIN) {
    color("aqua") {
        for (offsetX = [-FRAME_MARGIN_X, cellSideLength * NUM_CELL_X])
            union() {
                translate([offsetX, -FRAME_MARGIN_Y, 0])
                    cube([FRAME_MARGIN_X, cellSideLength * NUM_CELL_Y + FRAME_MARGIN_Y * 2, FRAME_THICKNESS]);
            }
        for (offsetY = [-FRAME_MARGIN_Y, cellSideLength * NUM_CELL_Y])
            union() {
                translate([-FRAME_MARGIN_X, offsetY, 0])
                    cube([cellSideLength * NUM_CELL_X + FRAME_MARGIN_X * 2, FRAME_MARGIN_Y, FRAME_THICKNESS]);
            }
    }
}
// done creating margins


// create mold
if (RENDER_MOLD) {
    color("gold") {
        translate([-FRAME_MARGIN_X, -FRAME_MARGIN_Y, -FRAME_THICKNESS])
            cube([cellSideLength * NUM_CELL_X + 2 * FRAME_MARGIN_X, cellSideLength * NUM_CELL_Y + 2 * FRAME_MARGIN_Y, MOLD_THICKNESS]);
        for (offsetX = [-FRAME_MARGIN_X - MOLD_THICKNESS, cellSideLength * NUM_CELL_X + FRAME_MARGIN_X])
            translate([offsetX, -FRAME_MARGIN_Y - MOLD_THICKNESS, -FRAME_THICKNESS])
                cube([MOLD_THICKNESS, 2 * MOLD_THICKNESS + cellSideLength * NUM_CELL_Y + 2 * FRAME_MARGIN_Y, MOLD_HEIGHT + FRAME_THICKNESS]);
        for (offsetY = [cellSideLength * NUM_CELL_Y + FRAME_MARGIN_Y, -FRAME_MARGIN_Y - MOLD_THICKNESS])
            translate([-FRAME_MARGIN_X - MOLD_THICKNESS, offsetY, -FRAME_THICKNESS])
                cube([2 * MOLD_THICKNESS + cellSideLength * NUM_CELL_X + 2 * FRAME_MARGIN_X, MOLD_THICKNESS, MOLD_HEIGHT + FRAME_THICKNESS]);
    }
}
// done creating mold


// create push pins with connection lines
if (RENDER_PUSH_PIN) {
    color("greenyellow") 
    translate([0, 0, RENDER_EXPLODE ? -15 : 0]) {
        for (offsetX = [0 : cellSideLength : cellSideLength * NUM_CELL_X - 0.001]) 
            for (offsetY = [0 : cellSideLength : cellSideLength * NUM_CELL_Y - 0.001]) 
                translate([offsetX, offsetY, 0])
                    union() {
                        translate([CELL_RADIUS + CELL_SEPARATION_DISTANCE, CELL_RADIUS + CELL_SEPARATION_DISTANCE, -PIN_HEIGHT])
                            cylinder(r=PIN_RADIUS, h=PIN_HEIGHT);

                        if (RENDER_PUSH_PIN_CONNECTION) {
                            translate([CELL_SEPARATION_DISTANCE + CELL_RADIUS - PIN_CONNECTION_WIDTH / 2, 0, -PIN_HEIGHT])
                                cube([PIN_CONNECTION_WIDTH, cellSideLength, PIN_CONNECTION_THICKNESS]);
                            translate([0, CELL_SEPARATION_DISTANCE + CELL_RADIUS - PIN_CONNECTION_WIDTH / 2, -PIN_HEIGHT])
                                cube([cellSideLength, PIN_CONNECTION_WIDTH, PIN_CONNECTION_THICKNESS]);
                        }

                        if (RENDER_PUSH_PIN_LOCK) {
                            translate([CELL_RADIUS + CELL_SEPARATION_DISTANCE, CELL_RADIUS + CELL_SEPARATION_DISTANCE, 1 - PIN_LOCK_HEIGHT])
                                resize(newsize=[PIN_LOCK_RADIUS * 2, PIN_LOCK_RADIUS * 2, PIN_LOCK_HEIGHT * 2])
                                    sphere();
                        }
                    }
    }
}
// done creating push pins


// create push pin guide
if (RENDER_PUSH_PIN_GUIDE) {
    color("magenta") 
    translate([0, 0, RENDER_EXPLODE ? -5 : 0]) {
        for (offsetX = [0 : cellSideLength : cellSideLength * NUM_CELL_X - 0.001]) 
            for (offsetY = [0 : cellSideLength : cellSideLength * NUM_CELL_Y - 0.001]) 
                translate([offsetX, offsetY, 0]) {
                    union() {
                        translate([CELL_RADIUS + CELL_SEPARATION_DISTANCE, CELL_RADIUS + CELL_SEPARATION_DISTANCE, -PIN_GUIDE_TOTAL_HEIGHT]) {
                            difference() {
                                cylinder(r=PIN_GUIDE_RADIUS + PIN_GUIDE_THICKNESS, h=PIN_GUIDE_TOTAL_HEIGHT);
                                cylinder(r=PIN_GUIDE_RADIUS, h=PIN_GUIDE_TOTAL_HEIGHT);
                            }
                        }

                        difference() {
                            translate([CELL_SEPARATION_DISTANCE + CELL_RADIUS - cellSideLength / 2, 0, -PIN_GUIDE_TOTAL_HEIGHT])
                                cube([cellSideLength, cellSideLength, PIN_GUIDE_FOUNDATION_THICKNESS]);
                            translate([CELL_RADIUS + CELL_SEPARATION_DISTANCE, CELL_RADIUS + CELL_SEPARATION_DISTANCE, -PIN_GUIDE_TOTAL_HEIGHT - PIN_GUIDE_FOUNDATION_THICKNESS]) 
                                cylinder(r=PIN_GUIDE_RADIUS, h=PIN_GUIDE_TOTAL_HEIGHT);
                        }

                        if (RENDER_PUSH_PIN_LOCK) {
                            difference() {
                                translate([CELL_SEPARATION_DISTANCE + CELL_RADIUS - cellSideLength / 2, 0, -PIN_GUIDE_TOTAL_HEIGHT - PIN_GUIDE_LOCK_HEIGHT])
                                    cube([cellSideLength, cellSideLength, PIN_GUIDE_LOCK_HEIGHT]);
                                translate([CELL_RADIUS + CELL_SEPARATION_DISTANCE, CELL_RADIUS + CELL_SEPARATION_DISTANCE, -PIN_GUIDE_TOTAL_HEIGHT - PIN_GUIDE_LOCK_HEIGHT]) 
                                    cylinder(r=PIN_GUIDE_LOCK_RADIUS, h=PIN_GUIDE_LOCK_HEIGHT);
                            }
                        }
                    }
                }
    }
}
// done creating push pin guide
