// z = x + 2

size(5cm, 0); // Set image size

triple camera_direction = (-2.4, 12.2, 1.84);

currentprojection = orthographic(camera_direction, up=Z);
currentlight=nolight;

// Graphing the plane on boundary triangle (a,b) -- (c,b) -- (a,d)
real a = -2;
real b = 0;
real c = 2;
real d = 4;

// Target function
real f(pair p){
	return p.x + 2;
}

// Parametrization of domain; [a,c] x [b,d] --> triangle
pair phi(pair p){
	return p;
}

// Target function pulled back to rectangle
triple g(pair p){
	pair z = phi(p);
	return (z.x, z.y, f(z));
}

// Need nu and nv to be large, so that boundary is sharp
surface s = surface(g, (a,b), (c,d), nu=resx, nv=resy);
draw(s, surface_pens[grey_ind]);

draw_axes((-2.2, -0.1, -0.1), (2.4, 4.6, 2.5),
					new real[] {-2, 2}, new real[] {2, 4}, new real[] {2},
					 camera_direction);

int nx = 6;
int ny = 6;

// x-const
for(int j = 0; j <= nx; ++j){
  real x = a + j * (c-a) / nx;
	draw(graph(new triple(real t) {return g((x, t));},
						 b, d), mesh_pen);
	draw(graph(new triple(real t) {return (x, t, 0);},
						 b, d), xygrid_pen);
}

// y-const
for(int j = 0; j <= ny; ++j){
	real y = b + j * (d-b) / ny;
	draw(graph(new triple(real t) {return g((t, y));},
						 a, c), mesh_pen);
	draw(graph(new triple(real t) {return (t, y, 0);},
						 a, c), xygrid_pen);
}
