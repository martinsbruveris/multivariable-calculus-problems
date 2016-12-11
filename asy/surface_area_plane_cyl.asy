// x + 2y + 2z = 3 inside x^2+y^2=1
//   --> z = 0.5*(3-x-2y)

size(5cm, 0); // Set image size

triple camera_direction = (5, 3, 5);

currentprojection = orthographic(camera_direction, up=Z);
currentlight=nolight;

// Graphing the plane on boundary triangle (a,b) -- (c,b) -- (a,d)
real a = -1.25;
real b = -1.25;
real c = 1.25;
real d = 1.25;

// Target function
real f(pair p){
	return 0.5*(3 - p.x - 2 * p.y);
}

// Parametrization of domain; equals identity here
pair phi(pair p){
	return (p.x, p.y);
}

// Target function pulled back to rectangle
triple g(pair p){
	pair z = phi(p);
	return (z.x, z.y, f(z));
}

// Indicator function
int find_domain(triple p){
	if (p.x*p.x + p.y*p.y <= 1)
		return emph_ind;
	else
		return trns_ind;
}

real choosecolor(triple p){
	return find_domain(p);
}


// Need nu and nv to be large, so that boundary is sharp
surface s = surface(g, (a,b), (c,d), nu=resx, nv=resy);
set_surface_colors(s, choosecolor, surface_pens);
draw(s);

draw_axes((a, b, 0), (c, d, 3.3),
					new real[] {-1, 1}, new real[] {-1, 1}, new real[] {1, 2, 3},
					camera_direction);

int nx = 4;
int ny = 4;

// Mesh lines
for(int j = 0; j < nx; ++j){
  real x = -1 + j * 2 / nx;
  path3 p = (x, -sqrt(1-x^2), 0) -- (x, sqrt(1-x^2), 0);
  draw(p, support_lines_pen);
	draw(graph(new triple(real y) {return (x,y,f((x,y)) );},
						 -sqrt(1-x^2), sqrt(1-x^2)), mesh_pen);
}

for(int j = 0; j < ny; ++j){
	real y = -1 + j * 2 / ny;
	path3 p = (-sqrt(1-y^2), y, 0) -- (sqrt(1-y^2), y, 0);
	draw(p, support_lines_pen);
	draw(graph(new triple(real x) {return (x,y,f((x,y)) );},
						 -sqrt(1-y^2), sqrt(1-y^2)), mesh_pen);
}

// Bounding circle in xy-plane and on graph
draw(circle(O, 1, normal=Z), mesh_pen);
draw(graph(new triple(real t) {return (cos(t), sin(t), f((cos(t),sin(t))));},
					 0, 2*pi), mesh_pen);

// Bounding cylinder
triple start = (0,0,0);
real length = 3;
real radius = 1;
triple ax = Z;
revolution r = cylinder(start,radius,length,ax);
draw(surface(r), aux_surface_pen);

int nz = 4;

for(int j = 1; j < nz; ++j){
	real z = j * length / nz;
	draw(circle((0,0,z), 1, normal=Z), aux_mesh_pen);
}
