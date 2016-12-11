size(5cm, 0); // Set image size

// triple camera_direction = (10.6,-5.2,5.4);
triple camera_direction = (5.5, 3.5, 2.9);

currentprojection = orthographic(camera_direction, up=Z);
currentlight=nolight;

// Target function
real f(pair p){
	return 0.5 + p.x^2 + p.y^2;
}

// Parametrization of domain; polar coordinates
pair phi(pair p){
	return p;
}

// Target function pulled back to rectangle
triple g(pair p){
	pair z = phi(p);
	return (z.x, z.y, f(z));
}

real a = -0.5;
real b = -0.5;
real c = 0.5;
real d = 0.5;

// Need nu and nv to be large, so that boundary is sharp
surface s = surface(g, (a, b), (c, d), nu=resx, nv=resy);
draw(s, surface_pens[1]);

draw_axes((-0.6, -0.6, -0.1), (0.6, 0.6, 1.2),
					new real[] {0.5}, new real[] {0.5}, new real[] {1},
					camera_direction);

int nx = 8;
int ny = 8;

// x-const
for(int j = 0; j <= nx; ++j){
  real x = a + j * (c-a) / nx;
	draw(graph(new triple(real t) {return (x, t, f((x, t)));},
						 b, d), mesh_pen);
}

// y-const
for(int j = 0; j <= ny; ++j){
	real y = b + j * (d-b) / ny;
	draw(graph(new triple(real t) {return (t, y, f((t, y)));},
						 a, c), mesh_pen);
}

draw((0,0,0.5) -- (0,0,1.5), arrow=Arrow3(), p=black+linewidth(1.2pt));
