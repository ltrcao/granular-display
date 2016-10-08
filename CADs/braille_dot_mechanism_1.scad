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

// Create lever arms with pin on
union() {
    // braille pins
    color("aqua") 
        for (centerX = [CELL_MARGIN_LENGTH : DOT_DISTANCE : CELL_MARGIN_LENGTH + 2 * DOT_DISTANCE]) 
            for (centerY = [CELL_MARGIN_WIDTH : DOT_DISTANCE : CELL_MARGIN_WIDTH + DOT_DISTANCE]) 
                translate([centerX, centerY, DOT_RADIUS * DOT_RADIUS_RATIO]) {
                    sphere(r=DOT_RADIUS * DOT_RADIUS_RATIO);
                    cylinder(r=DOT_RADIUS * DOT_RADIUS_RATIO, h=DOT_HEIGHT - DOT_RADIUS * DOT_RADIUS_RATIO);
                }

    // closer lever arms
    color("greenyellow")
        for (offset = [0 : DOT_DISTANCE : 2 * DOT_DISTANCE])
            translate([CELL_MARGIN_WIDTH - DOT_RADIUS * DOT_RADIUS_RATIO + offset, -LEVER_ARM_LENGTH + CELL_MARGIN_WIDTH + DOT_RADIUS, 0])
                rotate([atan(DOT_HEIGHT / LEVER_ARM_LENGTH), 0, 0])
                    cube([DOT_RADIUS * DOT_RADIUS_RATIO * 2, LEVER_ARM_LENGTH, 1]);

    // lever base
    color("white")
        for (offset = [0 : DOT_DISTANCE : 2 * DOT_DISTANCE])
            translate([CELL_MARGIN_WIDTH - DOT_RADIUS * DOT_RADIUS_RATIO + offset, -LEVER_ARM_LENGTH + CELL_MARGIN_WIDTH + DOT_RADIUS, 0])
                cube([DOT_RADIUS * DOT_RADIUS_RATIO * 2, LEVER_ARM_LENGTH - CELL_MARGIN_WIDTH - DOT_RADIUS, 1]);
        
}
