//============================================================
// OpenSCAD
// Regular Convex Polygon Library
//============================================================
/*

	Definition

	N = Number of Side N >=3
	A = apothem
		radius of inside circle
	R = circumradius
		Radius of outside circle
	S = Side
		Lenght of a side

	Build polygon with the Apothem :
	N and A is known
	Need to calculate S then R
	use $fn

	Build Polygon with Circumradius
	N and R known
	use $fn

	Build Polygon with Side
	N and S Known
	Need to calculate R and optionaly A
	use $fn	

	TO DO
	ASSIGN Correction - not mandatory


	For more information :
	http://en.wikipedia.org/wiki/Regular_polygon

*/

//------------------------------------------------------------
// Polygon : 
//------------------------------------------------------------
module Polygon(N=3,A=0,R=0,S=0,h=0,debug=false)
{
	N = ( N < 3 ? 3 : N );

	angle = 360/N;
	angleA = angle/2;

	if (debug)
	{
		echo("N = ", N);
		echo("A = ", A);
		echo("S = ", S);
		echo("R = ", R);
	}

	if ( A > 0 )		// if A assign R and S
	{
			assign
			(
				S = 2 * A * tan(angleA),							// assign
				//R = (S/2) / sin(angleA)						// no assign ???
				R = ( A * tan(angleA) ) / sin(angleA)		// asign
			)
			{
				_Build_Polygon(N=N,R=R,h=h);
				if (debug)
				{
					echo("aN = ", N);
					echo("aA = ", A);
					echo("aS = ", S);
					echo("aR = ", R);
					#cylinder(r=A,h=h+1,center=true,$fn=150);
					%cylinder(r=R,h=h+1,center=true,$fn=150);
				}
			}
	}
	else
	{
		if ( S > 0 )		// if S assign R and A
		{
			assign
			(
				R = (S/2) / sin(angleA),			// assign
				A = S / ( 2 * tan(angleA) )		// assign
			)
			{
				_Build_Polygon(N=N,R=R,h=h);
				if (debug)
				{
					echo("sN = ", N);
					echo("sA = ", A);
					echo("sS = ", S);
					echo("sR = ", R);
					#cylinder(r=A,h=h+1,center=true,$fn=150);
					%cylinder(r=R,h=h+1,center=true,$fn=150);
				}
			}
		}
		else
		{
			if ( R == 0 )		// default
			{
				assign
				(
					S = 2 * R * sin(angleA),			// no assign ???
					A = S / ( 2 * tan(angleA) )		// no assign ???
				)
				_Build_Polygon(N=N,h=h);
				if (debug)
				{
					echo("0N = ", N);
					echo("0A = ", A);
					echo("0S = ", S);
					echo("0R = ", R);
					#cylinder(r=A,h=h+1,center=true,$fn=150);
					%cylinder(r=R,h=h+1,center=true,$fn=150);
				}
			}
			else		// build with R
			{

// assign ???
				assign
				(
					S = 2 * R * sin(angleA),
					A = S / ( 2 * tan(angleA) )						// no assign ???
					//A = R * ( sin(angleA) / tan(angleA) )	// no assign ???
				)
				_Build_Polygon(N=N,R=R,h=h);
				if (debug)
				{
					echo("rN = ", N);
					echo("rA = ", A);
					echo("rS = ", S);
					echo("rR = ", R);
					%cylinder(r=R,h=h+1,center=true,$fn=150);
				}




			}
		}
	}

	if (debug)
	{
		echo("fN = ", N);
		echo("fA = ", A);
		echo("fS = ", S);
		echo("fR = ", R);
	}
}

//------------------------------------------------------------
// Build
//------------------------------------------------------------
module _Build_Polygon(N=3,R=1,h=0)
{
	if (h > 0)
	{
		// 3D primitive h>0
		cylinder(r=R,h=h,$fn=N,center=true);
	}
	else
	{
		// 2D primitive h=0
		circle(r=R,$fn=N,center=true);
	}
}

//------------------------------------------------------------
// Building lots from N=3, N=N+1
// http://en.wikipedia.org/wiki/Polygon
//------------------------------------------------------------

module Trigon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=3,A=A,R=R,S=S,h=h,debug=debug);}

module Triangle(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=3,A=A,R=R,S=S,h=h,debug=debug);}

module Tetragon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=4,A=A,R=R,S=S,h=h,debug=debug);}

module Quadrilateral(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=4,A=A,R=R,S=S,h=h,debug=debug);}

module Quadrangle(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=4,A=A,R=R,S=S,h=h,debug=debug);}

module Pentagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=5,A=A,R=R,S=S,h=h,debug=debug);}

module Hexagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=6,A=A,R=R,S=S,h=h,debug=debug);}

module Heptagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=7,A=A,R=R,S=S,h=h,debug=debug);}

module Octagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=8,A=A,R=R,S=S,h=h,debug=debug);}

module Enneagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=9,A=A,R=R,S=S,h=h,debug=debug);}

module Nonagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=9,A=A,R=R,S=S,h=h,debug=debug);}

module Decagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=10,A=A,R=R,S=S,h=h,debug=debug);}

module Handecagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=11,A=A,R=R,S=S,h=h,debug=debug);}

module Dodecagon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=12,A=A,R=R,S=S,h=h,debug=debug);}

// ...

module Hectogon(A=0,R=0,S=0,h=0,debug=false)
	{Polygon(N=100,A=A,R=R,S=S,h=h,debug=debug);}

//==EOF=======================================================