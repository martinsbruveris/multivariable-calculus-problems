size(4.5cm, 0); // Set image size

// triple camera_direction = (10.6,-5.2,5.4);
triple camera_direction = (5.24, -4.73, 0.94);

currentprojection = orthographic(camera_direction, up=Z);
currentlight=nolight;

// Target function
real f(pair p){
	return 1.2*p.y^2 - p.x;
}

// Parametrization of domain; polar coordinates
pair phi(pair p){
	return p;
}

// Target function pulled back to rectangle
triple g(pair p){
	pair z = phi(p);
	return (f(z), z.x, z.y);
}

real a = -1;
real b = -0.5;
real c = 1;
real d = 0.75;

// Need nu and nv to be large, so that boundary is sharp
surface s = surface(g, (a, b), (c, d), nu=resx, nv=resy);
draw(s, surface_pens[1]);

draw_axes((-0.1, -0.1, -0.1), (1.1, 1.1, 0.6),
					new real[] {1}, new real[] {1}, new real[] {0.5},
					camera_direction);

int nx = 8;
int ny = 5;

// x-const
for(int j = 0; j <= nx; ++j){
  real x = a + j * (c-a) / nx;
	draw(graph(new triple(real t) {return (f((x, t)), x, t);},
						 b, d), mesh_pen);
}

// y-const
for(int j = 0; j <= ny; ++j){
	real y = b + j * (d-b) / ny;
	draw(graph(new triple(real t) {return (f((t, y)), t, y);},
						 a, c), mesh_pen);
}

draw((0,0,0) -- sqrt(0.5) * (1, 1, 0), arrow=Arrow3(), p=black+linewidth(1.2pt));
