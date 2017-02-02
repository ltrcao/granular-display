// The design is parametric, so only the constants below need to be changed.
//// Dimension configuration ////
//$fn = 40; // Set $fn to 40 before exporting to .stl to round the pinheads.
NUM_GRID_X = 24;
NUM_GRID_Y = 18;
GRID_LENGTH_X = 10;
GRID_LENGTH_Y = 10;
THREAD_WIDTH_X = 2;
THREAD_WIDTH_Y = 2;
THREAD_THICKNESS_X = 2.5;
THREAD_THICKNESS_Y = 2.5;
WALL_THICKNESS = 10;
WALL_HEIGHT = 5;

PIN_RADIUS = 2.5;
PIN_HEIGHT = 15;
PIN_CONNECTION_THICKNESS = 0.25;
PIN_CONNECTION_WIDTH = 0.25;
////////////////////////////////


//// Render toggle ////
RENDER_SUPPORTIVE_GRID = true;
RENDER_PIN_GRID = true;
///////////////////////


if (RENDER_SUPPORTIVE_GRID) {
    supportive_grid();
}

if (RENDER_PIN_GRID) {
    pin_grid();
}

// Create the supportive grid/frame to hold granular material.
module supportive_grid() {
    // create grids
    for (offsetX = [0 : GRID_LENGTH_X : GRID_LENGTH_X * NUM_GRID_X])
        translate([offsetX, 0, 0])
            cube([THREAD_WIDTH_X, GRID_LENGTH_Y * NUM_GRID_Y + THREAD_WIDTH_Y, THREAD_THICKNESS_X]);

    for (offsetY = [0 : GRID_LENGTH_Y : GRID_LENGTH_Y * NUM_GRID_Y])
        translate([0, offsetY, 0])
            cube([GRID_LENGTH_X * NUM_GRID_X + THREAD_WIDTH_X, THREAD_WIDTH_Y, THREAD_THICKNESS_Y]);
    // done creating grids


    // create walls
    union() {
        for (offsetX = [-WALL_THICKNESS, THREAD_WIDTH_Y + GRID_LENGTH_X * NUM_GRID_X])
            translate([offsetX, -WALL_THICKNESS, 0])
                cube([WALL_THICKNESS, GRID_LENGTH_Y * NUM_GRID_Y + THREAD_WIDTH_Y + 2 * WALL_THICKNESS, WALL_HEIGHT]);

        for (offsetY = [-WALL_THICKNESS, THREAD_WIDTH_X + GRID_LENGTH_Y * NUM_GRID_Y])
            translate([-WALL_THICKNESS, offsetY, 0])
                cube([GRID_LENGTH_X * NUM_GRID_X + THREAD_WIDTH_X + 2 * WALL_THICKNESS, WALL_THICKNESS, WALL_HEIGHT]);
    }
    // done creating walls
}

// Create push pins with connection lines
module pin_grid() {
    for (offsetX = [0 : GRID_LENGTH_X : GRID_LENGTH_X * NUM_GRID_X - 0.001]) 
        for (offsetY = [0 : GRID_LENGTH_Y : GRID_LENGTH_Y * NUM_GRID_Y - 0.001]) 
            translate([offsetX + THREAD_WIDTH_X / 2, offsetY + THREAD_WIDTH_Y / 2, 0])
                union() {
                    translate([GRID_LENGTH_X / 2, GRID_LENGTH_Y / 2, -PIN_HEIGHT]) {
                        hull() {
                            // Actual pin
                            cylinder(r=PIN_RADIUS, h=PIN_HEIGHT);

                            // Rounded pinhead
                            translate([0, 0, PIN_HEIGHT])
                                sphere(r=PIN_RADIUS);
                        }
                    }

                    // Connection lines
                    translate([GRID_LENGTH_X / 2 - PIN_CONNECTION_WIDTH / 2, 0, -PIN_HEIGHT])
                        cube([PIN_CONNECTION_WIDTH, GRID_LENGTH_X, PIN_CONNECTION_THICKNESS]);
                    translate([0, GRID_LENGTH_Y / 2 - PIN_CONNECTION_WIDTH / 2, -PIN_HEIGHT])
                        cube([GRID_LENGTH_Y, PIN_CONNECTION_WIDTH, PIN_CONNECTION_THICKNESS]);
                }
}
