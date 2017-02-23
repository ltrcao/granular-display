rear_idler();

// Translate/rotate rear idler .stl so that it sits at origin
module rear_idler() {
    translate([-55, 0, -127.562]) { 
        rotate([90, 0, 0]) {
            import("C-Bot_base/C-BOT XY Rear Idler (x1).stl", convexity=3);
        }
    }
}
