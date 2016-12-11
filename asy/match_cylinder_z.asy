size(4.5cm, 0); // Set image size

triple camera_direction = (5.55,-3.8,2.32);

currentprojection = orthographic(camera_direction, up=Z);
currentlight=nolight;

// Limits
real a = -1.;
real b = 0;
real c = 1.;
real d = 2*pi;

// Bounding cylinder
triple start = (0,0,a);
real length = c-a;
real radius = 1.;
triple ax = Z;
revolution r = cylinder(start,radius,length,ax);
draw(surface(r), surface_pens[grey_ind]);

// Coordinate axes
draw_axes((-0.1, -0.1, -0.1), (1.2, 1.4, 1.45),
					new real[] {}, new real[] {}, new real[] {},
					camera_direction);

int nx = 4;
int ny = 10;

// y-const
for(int j = 0; j <= nx; ++j){
  real x = a + j * (c-a) / nx;
	draw(graph(new triple(real t) {return (radius*cos(t), radius*sin(t), x);},
						 b, d), mesh_pen);
}

// th-const
for(int j = 0; j <= ny; ++j){
	real y = b + j * (d-b) / ny;
	draw(graph(new triple(real t) {return (radius*cos(y), radius*sin(y), t);},
						 a, c), mesh_pen);
}

