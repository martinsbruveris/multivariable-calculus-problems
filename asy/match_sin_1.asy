size(4.5cm, 0); // Set image size

triple camera_direction = (14,11.7,9.6);

currentprojection = orthographic(camera_direction, up=Z);
currentlight=nolight;

// Target function
real f(pair p){
	return sin(p.x - p.y);
}

// Parametrization of domain; here identity
pair phi(pair p){
	return p;
}

// Target function pulled back to rectangle
triple g(pair p){
	pair z = phi(p);
	return (z.x, z.y, f(z));
}

real a = -2*pi;
real b = -2*pi;
real c = 2*pi;
real d = 2*pi;

// Need nu and nv to be large, so that boundary is sharp
surface s = surface(g, (a, b), (c, d), nu=resx, nv=resy);
draw(s, surface_pens[grey_ind]);

draw_axes((-0.1, -0.1, -0.1), (2.7*pi, 2.7*pi, 5),
					new real[] {}, new real[] {}, new real[] {},
					camera_direction);

int nx = 12;
int ny = 12;

// x-const
for(int j = 0; j <= nx; ++j){
  real x = a + j * (c-a) / nx;
	draw(graph(new triple(real t) {return g((x, t));},
						 b, d), mesh_pen);
}

// y-const
for(int j = 0; j <= ny; ++j){
	real y = b + j * (d-b) / ny;
	draw(graph(new triple(real t) {return g((t, y));},
						 a, c), mesh_pen);
}
