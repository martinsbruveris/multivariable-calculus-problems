size(5cm, 0); // Set image size

triple camera_direction = rotate(30, Z) * (2, 0, 1);

currentprojection = orthographic(camera_direction, up=Z);
currentlight=nolight;

// Graphing the plane on boundary triangle (a,b) -- (c,b) -- (a,d)
real a = -1.5;
real b = -0.5;
real c = 1.5;
real d = 2.5;

// Target function
real f(pair p){
	return sqrt(4-p.x^2);
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
real find_domain(triple p){
	if (-1 <= p.x && p.x <= 1 && 0 <= p.y && p.y <= 2)
		return emph_ind;
	else
		return grey_ind;
}

real choosecolor(triple p){
	return find_domain(p);
}


// Need nu and nv to be large, so that boundary is sharp
surface s = surface(g, (a,b), (c,d), nu=resx, nv=resy);
set_surface_colors(s, choosecolor, surface_pens);
draw(s);

draw_axes((a, b, 0), (c, d, 2.5),
					new real[] {-1, 1}, new real[] {1, 2}, new real[] {1},
					camera_direction);

int nx = 6;
int ny = 6;

// Mesh lines
for(int j = 0; j <= nx; ++j){
  real x = a + j * (c-a) / nx;
	draw(graph(new triple(real y) {return (x,y,f((x,y)) );},
						 b, d), mesh_pen);
}

for(int j = 0; j <= ny; ++j){
	real y = b + j * (d-b) / ny;
	draw(graph(new triple(real x) {return (x,y,f((x,y)) );},
						 a, c), mesh_pen);
}

// Grid lines in xy-plane
real dx = (c-a) / nx;
real dy = (d-b) / ny;
for(int j = 1; j <= nx-1; ++j){
  real x = a + j * dx;
  path3 p = (x, b+dx, 0) -- (x, d-dx, 0);
  draw(p, support_lines_pen);
}

for(int j = 1; j <= ny-1; ++j){
	real y = b + j * (d-b) / ny;
	path3 p = (a+dy, y, 0) -- (c-dy, y, 0);
	draw(p, support_lines_pen);
}

// Remove the margin now
a = a+dx;
b = b+dy;
c = c-dx;
d = d-dy;

// Vertical lines in corners
draw((a,b,0) -- (a,b,f((a, b))), support_lines_pen);
draw((a,d,0) -- (a, d,f((a, d))), support_lines_pen);
draw((c,b,0) -- (c, b,f((c, b))), support_lines_pen);
draw((c,d,0) -- (c, d,f((c, d))), support_lines_pen);





// Where to plot the graph
pair bl = (-1,0);  // bottom left
pair tr = (1,2);   // top right
int nx = 4;        // subdivisions
int ny = 4;
int nx_ml = 1;     // subdivisions for margins
int nx_mr = 1;
int ny_mb = 1;
int ny_mt = 1;
real zmin = 0;
real zmax = 2.5;

// draw_graph_area(f, bl, tr, nx, ny, nx_ml, nx_mr, ny_mb, ny_mt);
// draw_axes2(bl, tr, nx, ny, nx_ml, nx_mr, ny_mb, ny_mt,
// 					zmin, zmax, xticks = new real[] {1}, yticks = new real[] {1, 2},
// 					zticks = new real[] {1}, camera_direction=camera_direction);
