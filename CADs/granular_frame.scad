CELL_RADIUS = 2.5;
FRAME_THICKNESS = 4;
NUM_CELL_X = 5;
NUM_CELL_Y = 5;
CELL_SEPARATION_DISTANCE = 0.5;
FRAME_MARGIN_X = 1;
FRAME_MARGIN_Y = 1;

MOLD_THICKNESS = 1;
MOLD_HEIGHT = 1;

PIN_RADIUS = 1;
PIN_HEIGHT = 10;
PIN_CONNECTION_THICKNESS = 0.15;
PIN_GUIDE_RADIUS = 1.3;
PIN_GUIDE_THICKNESS = 1;
PIN_GUIDE_HEIGHT = 5;
PIN_GUIDE_FOUNDATION_THICKNESS = 2;

$fn = 20;

cellSideLength = CELL_RADIUS * 2 + CELL_SEPARATION_DISTANCE * 2;

// create individual cells
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
// done creating individual cells


// create margins
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
// done creating margins


// create mold
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
// done creating mold


// create push pins with connection lines
color("greenyellow") 
translate([0, 0, -15]) {
    for (offsetX = [0 : cellSideLength : cellSideLength * NUM_CELL_X - 0.001]) 
        for (offsetY = [0 : cellSideLength : cellSideLength * NUM_CELL_Y - 0.001]) 
            translate([offsetX, offsetY, 0])
                union() {
                    translate([CELL_RADIUS + CELL_SEPARATION_DISTANCE, CELL_RADIUS + CELL_SEPARATION_DISTANCE, -PIN_HEIGHT])
                        cylinder(r=PIN_RADIUS, h=PIN_HEIGHT);
                    translate([CELL_SEPARATION_DISTANCE + CELL_RADIUS - PIN_CONNECTION_THICKNESS / 2, 0, -PIN_HEIGHT - PIN_CONNECTION_THICKNESS])
                        cube([PIN_CONNECTION_THICKNESS, cellSideLength, PIN_CONNECTION_THICKNESS]);
                    translate([0, CELL_SEPARATION_DISTANCE + CELL_RADIUS - PIN_CONNECTION_THICKNESS / 2, -PIN_HEIGHT - PIN_CONNECTION_THICKNESS])
                        cube([cellSideLength, PIN_CONNECTION_THICKNESS, PIN_CONNECTION_THICKNESS]);
                }
}
// done creating push pins


// create push pin guide
color("magenta") 
translate([0, 0, -5]) {
    for (offsetX = [0 : cellSideLength : cellSideLength * NUM_CELL_X - 0.001]) 
        for (offsetY = [0 : cellSideLength : cellSideLength * NUM_CELL_Y - 0.001]) 
            translate([offsetX, offsetY, 0]) {
                union() {
                    translate([CELL_RADIUS + CELL_SEPARATION_DISTANCE, CELL_RADIUS + CELL_SEPARATION_DISTANCE, -PIN_GUIDE_HEIGHT]) {
                        difference() {
                            cylinder(r=PIN_GUIDE_RADIUS + PIN_GUIDE_THICKNESS, h=PIN_GUIDE_HEIGHT);
                            cylinder(r=PIN_GUIDE_RADIUS, h=PIN_GUIDE_HEIGHT);
                        }
                    }

                    difference() {
                        translate([CELL_SEPARATION_DISTANCE + CELL_RADIUS - cellSideLength / 2, 0, -PIN_GUIDE_HEIGHT])
                            cube([cellSideLength, cellSideLength, PIN_GUIDE_FOUNDATION_THICKNESS]);
                        translate([CELL_RADIUS + CELL_SEPARATION_DISTANCE, CELL_RADIUS + CELL_SEPARATION_DISTANCE, -PIN_GUIDE_HEIGHT - PIN_GUIDE_FOUNDATION_THICKNESS]) {
                            cylinder(r=PIN_GUIDE_RADIUS, h=PIN_GUIDE_HEIGHT);
                        }
                    }
                }
            }
}
// done creating push pin guide
