size(4.5cm, 0); // Set image size

triple camera_direction = (5.31, -3.64, 3.03);

currentprojection = orthographic(camera_direction, up=Z);
currentlight=nolight;

// Target function
real f(pair p){
	return 4*(p.x^2 + p.y^2);
}

// Parametrization of domain; polar coordinates
pair phi(pair p){
	return (p.x * cos(p.y), p.x * sin(p.y));
}

// Target function pulled back to rectangle
triple g(pair p){
	pair z = phi(p);
	return (f(z), z.x, z.y);
}

real a = 0;
real b = 0;
real c = 0.4;
real d = 2*pi;

// Need nu and nv to be large, so that boundary is sharp
surface s = surface(g, (a, b), (c, d), nu=resx, nv=resy);
draw(s, surface_pens[grey_ind]);

draw_axes((-0.1, -0.1, -0.1), (1.2, 0.75, 0.4),
					new real[] {}, new real[] {}, new real[] {},
					camera_direction);

int nx = 6;
int ny = 10;

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
