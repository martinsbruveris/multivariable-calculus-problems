size(4.5cm, 0); // Set image size

triple camera_direction = (5.55,-3.8,2.32);

currentprojection = orthographic(camera_direction, up=Z);
currentlight=nolight;

// Limits
real a = 0;
real b = 0;
real c = 2.;
real d = 2*pi;

// Bounding cylinder
triple start = (a,0,0);
real length = c-a;
real radius = 1.;
triple ax = X;
revolution r = cylinder(start,radius,length,ax);
draw(surface(r), surface_pens[grey_ind]);

// Coordinate axes
draw_axes((-0.1, -0.1, -0.1), (3.4, 2.4, 1.2),
					new real[] {}, new real[] {}, new real[] {},
					camera_direction);

int nx = 4;
int ny = 10;

// y-const
for(int j = 0; j <= nx; ++j){
  real x = a + j * (c-a) / nx;
	draw(graph(new triple(real t) {return (x, radius*cos(t), radius*sin(t));},
						 b, d), mesh_pen);
}

// th-const
for(int j = 0; j <= ny; ++j){
	real y = b + j * (d-b) / ny;
	draw(graph(new triple(real t) {return (t, radius*cos(y), radius*sin(y));},
						 a, c), mesh_pen);
}

