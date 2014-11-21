
intake_material_thickness=2;
intake_diameter=120;
intake_length=100;

outake_diameter=60;
outake_length=100;

fan_diameter_inner = 125;
fan_diameter_outer = 250;
fan_base_thickness = 15;
fan_blades = 36;
fan_blade_thickness = 4;
fan_height = 50;

box_size = 300;




module intake_assembly() {
	box_height = intake_material_thickness + fan_base_thickness + fan_height + 10;

	module intake_box() {
		translate([-box_size/2,-box_size/2,0]) {
			difference() {
				cube([box_size,box_size,box_height]);
				translate([
					intake_material_thickness, 
					intake_material_thickness, 
					intake_material_thickness])
				cube([
					box_size-intake_material_thickness*2,
					box_size-intake_material_thickness*2,
					box_height-intake_material_thickness]);
			}
		}
	}

	module intake_port() {
		translate([0,0, box_height])
		difference() {
			cylinder(h=intake_length, d=intake_diameter);
			cylinder(
				h=intake_length, 
				d=intake_diameter-intake_material_thickness*2
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
		translate([box_size/2,0,(box_height)/2]) {
			rotate([0,90,0])
			difference() {
			cylinder(
				h=outake_length,
				d=outake_diameter
			);
			cylinder(
				h=outake_length,
				d=outake_diameter - intake_material_thickness/2
			);
			}
			
		}
	}

	intake_box();
	intake_port();
	intake_fan();
	output_port();
}

intake_assembly();
