include <constants.scad>

module intake_assembly() {
	box_height = intake_material_thickness + max(fan_base_thickness+fan_height, intake_port2_diameter) + 10;

	module intake_box() {
		translate([-intake_box_size/2,-intake_box_size/2,0]) {
			difference() {
				cube([intake_box_size,intake_box_size,box_height]);
				translate([
					intake_material_thickness,
					intake_material_thickness,
					intake_material_thickness])
				cube([
					intake_box_size-intake_material_thickness*2,
					intake_box_size-intake_material_thickness*2,
					box_height-intake_material_thickness]);
			}
		}
	}

	module intake_port() {
		translate([0,0, box_height])
		difference() {
			cylinder(h=intake_port1_length, d=intake_port1_diameter);
			cylinder(
				h=intake_port1_length,
				d=intake_port1_diameter-intake_material_thickness*2
			);
		}
	}

	module intake_fan() {
		module fan_blade() {
			translate([fan_diameter_inner/2, -fan_blade_thickness/2, 0])
			cube([
				(fan_diameter_outer-fan_diameter_inner)/2,
				fan_blade_thickness,
				fan_height
			]);
		}

		translate([0,0,intake_material_thickness]) {
			cylinder(h=fan_base_thickness, d=fan_diameter_outer);

			translate([0,0,fan_base_thickness]) {
			for(i=[0:fan_blades])
				rotate([0,0, (360/fan_blades)*i]) {
				fan_blade();
				}
			}

		}

	}

	module output_port() {
		translate([intake_box_size/2,0,(box_height)/2]) {
			rotate([0,90,0])
			difference() {
			cylinder(
				h=intake_port2_length,
				d=intake_port2_diameter
			);
			cylinder(
				h=intake_port2_length,
				d=intake_port2_diameter - intake_material_thickness/2
			);
			}

		}
	}

	intake_box();
	output_port();
	intake_port();
	intake_fan();

}
