CELL_LENGTH = 10;
CELL_WIDTH = 7;
COVER_HEIGHT = 1;
CELL_MARGIN_LENGTH = 2;
CELL_MARGIN_WIDTH = 2;
DOT_RADIUS = 1;
DOT_RADIUS_RATIO = 0.7;
DOT_DISTANCE = 3; // center-to-center distance
LEVER_ARM_LENGTH = 30;
DOT_HEIGHT = COVER_HEIGHT * 2 + 2;

$fn = 20;

// Create a cell surface with 6 dot holes
difference() {
    // cell surface
    color("lavender")
        cube([CELL_LENGTH, CELL_WIDTH, COVER_HEIGHT]);

    // 6 dot holes
    for (centerX = [CELL_MARGIN_LENGTH : DOT_DISTANCE : CELL_MARGIN_LENGTH + 2 * DOT_DISTANCE]) 
        for (centerY = [CELL_MARGIN_WIDTH : DOT_DISTANCE : CELL_MARGIN_WIDTH + DOT_DISTANCE]) 
            translate([centerX, centerY, 0]) 
                cylinder(r=DOT_RADIUS, h=COVER_HEIGHT);
}
