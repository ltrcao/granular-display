// ===========================================================================
// Configuration file for the whole XY-stage design.
// ===========================================================================

// Parameters for stepper bracket
BRACKET_EDGE_LENGTH = 42.3;
BRACKET_DIAMETER = 22;
BRACKET_THICKNESS = 4;
SCREW_DIAMETER = 3;
SCREW_DISTANCE = 31;
SHAFT_HEIGHT = 24;
// ------------------------------

// Parameters for anchor
ANCHOR_THICKNESS = 4;
ANCHOR_SHAFT_OVERHEAD = 4;
ANCHOR_WIDTH = 40;
ANCHOR_SCREW_MARGIN = 7;
ANCHOR_SCREW_DIAMETER = 3;
// ---------------------

// Parameter for pulleys
PULLEY_INNER_DIAMETER = 8;
PULLEY_OUTER_DIAMETER = 25;
PULLEY_WIDTH = 9;
PULLEY_MARGIN = 3;
PULLEY_BACK_THICKNESS = 5;
PULLEY_DISTANCE = 3;
// ---------------------

PULLEY_CENTER = (PULLEY_MARGIN + PULLEY_OUTER_DIAMETER) / 2;
PULLEY_HEIGHT = 2 * PULLEY_WIDTH + 2 * ANCHOR_THICKNESS + PULLEY_DISTANCE;
PULLEY_EDGE_LENGTH = PULLEY_OUTER_DIAMETER + PULLEY_MARGIN;
