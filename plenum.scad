include <constants.scad>

module plenum() {

	module plenum_cylinder() {

		module plenum_entry_port() {
			translate([plenum_entry_width/2,0,plenum_entry_height - plenum_entry_width]) {
				difference() {
					cylinder(h=plenum_entry_width, d=plenum_diameter+plenum_entry_width);
					translate([0,0,plenum_wall_thickness])
						cylinder(h=plenum_entry_width - plenum_wall_thickness*2, d=plenum_diameter+plenum_entry_width-plenum_wall_thickness*2);
					translate([-(plenum_diameter+plenum_entry_width)/2,0,-1]) cube([plenum_diameter+plenum_entry_width+1, (plenum_diameter+plenum_entry_width)/2  +1, plenum_entry_width+2]);
				}
			}
		}


		module plenum_shell() {
			translate([0,0,plenum_taper])
			cylinder(h=plenum_height-plenum_taper,d=plenum_diameter);
			cylinder(h=plenum_taper, d1=plenum_taper_to, d2=plenum_diameter);
			plenum_entry_port();
		}

		difference() {
			plenum_shell();
			translate([0,0,plenum_wall_thickness]) {
				translate([0,0,plenum_taper-plenum_wall_thickness])
				cylinder(
					h=plenum_height - plenum_wall_thickness - plenum_taper,
					d=plenum_diameter - plenum_wall_thickness*2);
				cylinder(
					h=plenum_taper,
					d1=plenum_taper_to-plenum_wall_thickness,
					d2=plenum_diameter-plenum_wall_thickness
				);
			}

		}
	
	}

	module plenum_output() {
		translate([0,0,plenum_height - plenum_port2_inner_length]){
			difference(){
				cylinder(
					h=plenum_port2_inner_length + plenum_port2_outer_length,
					d=plenum_port2_diameter
				);
				translate([0,0,-1])
				cylinder(
					h=plenum_port2_inner_length + plenum_port2_outer_length +2,
					d=plenum_port2_diameter-plenum_wall_thickness*2
				);
			}
		}
	}

	module solids() {
	plenum_cylinder();
	plenum_output();
	}

	difference () {
		solids();
		if(plenum_show_section) translate([-1500,0,-1]) cube(3000);
	}
}
