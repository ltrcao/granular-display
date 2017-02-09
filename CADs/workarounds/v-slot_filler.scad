// Using V-Slot endcap design from http://www.thingiverse.com/thing:398515
// This module allows customizable endcap length

ENDCAP_LENGTH = 20;

union() {
    translate([40, 10, -10]) {
        import("v-slot_endcap_2020_fixed.stl");
    }

    translate([0, 0, -ENDCAP_LENGTH]) {
        cube([20, 20, ENDCAP_LENGTH + 2]);
    }
}
