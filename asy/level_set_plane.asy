// -x+y+z=1
//   --> z = 1+x-y
// x-axis: x=-1
// y-axis: y=1
// z-axis: z=1

size(5cm, 0); // Set image size

triple camera_direction = (3.1, 10.2, 5);

currentprojection = orthographic(camera_direction, up=Z);
currentlight=nolight;

// Graphing the plane on boundary triangle (a,b) -- (c,b) -- (a,d)
real a = 0;
real b = -0;
real c = -1;
real d = 1;

// Target function
real f(pair p){
	return 1 + p.x - p.y;
}

// Parametrization of domain; [a,c] x [b,d] --> triangle
pair phi(pair p){
	return (p.x, (b-p.y)*(p.x-a)/(c-a) + p.y);
}

// Target function pulled back to rectangle
triple g(pair p){
	pair z = phi(p);
	return (z.x, z.y, f(z));
}

// Indicator function
int find_domain(triple p){
	return 1;
	// if (-1.2 <= p.x && p.x <= 0.2 && -0.2 <= p.y && p.y <= 1+p.x)
	// 	return 1;
	// else
	// 	return 1;
}

real choosecolor(triple p){
	return find_domain(p);
}

// Need nu and nv to be large, so that boundary is sharp
surface s = surface(g, (a,b), (c,d), nu=resx, nv=resy);
// s.colors(palette(s.map(choosecolor), graph_colors2)); // Set colors of surface
// draw(s, meshpen = nullpen);
draw(s, surface_pens[1]);

draw_axes((-1.2, -0.2, -0.2), (0.2, 1.2, 1.2),
					 new real[] {-1}, new real[] {1}, new real[] {1},
					 camera_direction);

int nx = 4;
int ny = 4;

// for(int j = 1; j < nx; ++j){
//   real x = -1 + j * 1 / nx;
//   path3 p = (x, 0, 0) -- (x, 1+x, 0);
//   draw(p, support_lines_pen);
// }

// for(int j = 1; j < ny; ++j){
// 	real y = j * 2 / ny;
// 	path3 p = (0, y, 0) -- (2-y, y, 0);
// 	draw(p, support_lines_pen);
// }

for(int j = 0; j <= nx; ++j){
real x = -1 + j * 1 / nx;
draw(graph(new triple(real y) {return (x,y,f((x,y)) );},
					 0, 1+x), mesh_pen);
}

for(int j = 0; j <= ny; ++j){
real y = j * 1 / ny;
draw(graph(new triple(real x) {return (x,y,f((x,y)) );},
					 0, -1+y), mesh_pen);
}

draw( -X -- Y, mesh_pen);

draw((-0.333,0.333,0.333) -- (-0.333,0.333,0.333) + sqrt(0.333)*(-1,1,1),
		 arrow=Arrow3(), p=black+linewidth(1.2pt));
