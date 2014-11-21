include <constants.scad>
include <intake.scad>
include <plenum.scad>

plenum_show_section=1;

translate([plenum_diameter/2,intake_port2_diameter/2,plenum_taper - intake_box_size/2]) rotate([90,-90,90]) intake_assembly();
plenum();
