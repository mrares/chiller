include <constants.scad>
include <lib/polygon.scad>

section=1;

nozzle_nut_size=20;
nozzle_nut_height=10;
//Hexagon(nozzle_nut_size,h=nozzle_nut_height);

nozzle_dia = 30;
nozzle_height = 40;
nozzle_port_dia = 4;

nozzle_water_port_dia = 3/8 * 25.4;
nozzle_water_pinhole_dia=0.1;
nozzle_air_pinhole_dia=0.2;

nozzle_wall_thickness = 4;
nozzle_inner_wall_thickness = 2;

nozzle_tip_height = 15;

module nozzle() {
	
	module nozzle_outer_body() {
		cylinder(
			h=nozzle_height,
			d=nozzle_dia
		);
		translate([
			0,0,nozzle_height/2
		]) Hexagon(nozzle_dia*0.55, h=nozzle_height/2);
	}

	module nozzle_body_hole(){
		translate([0,0,nozzle_wall_thickness]) cylinder(
			h=nozzle_height+1,
			d=nozzle_dia-nozzle_wall_thickness*2
		);
		translate([0,0,-1])
			cylinder(
				h=nozzle_wall_thickness+2,
				d=nozzle_water_port_dia
			);
	}

	module nozzle_water_body() {
		difference() {
		union() {
			cylinder(
				h=nozzle_height,
				d=nozzle_water_port_dia + nozzle_inner_wall_thickness
			);
		}
		translate([0,0,-1])
			cylinder(
				h=nozzle_height+2,
				d=nozzle_water_port_dia
			);
		}
	}

	module nozzle_water_cap() {
		translate([0,0,nozzle_height])
		difference() {
			cylinder(
				h=nozzle_tip_height-4,
				d1=nozzle_water_port_dia + nozzle_inner_wall_thickness,
				d2=nozzle_water_pinhole_dia+1
			);
			translate([0,0,-0.01])
			cylinder(
				h=nozzle_tip_height-3.7,
				d1=nozzle_water_port_dia,
				d2=nozzle_water_pinhole_dia
			);
		}
	}

	module nozzle_air_cap() {
		translate([0,0,nozzle_height])		
		difference() {
			cylinder(
				h=nozzle_tip_height,
				d1=nozzle_dia,
				d2=10
			);
			translate([0,0,-0.01])
			cylinder(
				h=nozzle_tip_height+1,
				d1=nozzle_dia-nozzle_wall_thickness*2,
				d2=nozzle_air_pinhole_dia
			);

		}
	}

	module nozzle_body() {
		difference() {
			nozzle_outer_body();
			nozzle_body_hole();
		}
		nozzle_water_body();
		nozzle_water_cap();

		nozzle_air_cap();
	}

	nozzle_body();
}

difference() {
	nozzle();
	if(section)translate([-100, 0,-1]) cube(200);
}