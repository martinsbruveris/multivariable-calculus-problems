size(5cm, 0); // Set image size

triple camera_direction = rotate(30, Z) * (2, 0, 1);

currentprojection = orthographic(camera_direction, up=Z);
currentlight=nolight;

// Graphing the plane on boundary triangle (a,b) -- (c,b) -- (a,d)
real a = 0;
real b = 0;
real c = 1.25;
real d = 1.25;

// Target function
real f(pair p){
	return 2/3*(p.x^(3/2) + p.y^(3/2));
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
	if (0 <= p.x && p.x <= 1 && 0 <= p.y && p.y <= 1)
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

draw_axes((a-0.25, b-0.25, 0), (c, d, 1.5),
					new real[] {1}, new real[] {1}, new real[] {1},
					camera_direction);

int nx = 5;
int ny = 5;

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
for(int j = 0; j <= nx-1; ++j){
  real x = a + j * dx;
  path3 p = (x, b, 0) -- (x, d-dx, 0);
  draw(p, support_lines_pen);
}

for(int j = 0; j <= ny-1; ++j){
	real y = b + j * (d-b) / ny;
	path3 p = (a, y, 0) -- (c-dy, y, 0);
	draw(p, support_lines_pen);
}

// Remove the margin now
a = a;
b = b;
c = c-dx;
d = d-dy;

// Vertical lines in corners
draw((a,b,0) -- (a,b,f((a, b))), support_lines_pen);
draw((a,d,0) -- (a, d,f((a, d))), support_lines_pen);
draw((c,b,0) -- (c, b,f((c, b))), support_lines_pen);
draw((c,d,0) -- (c, d,f((c, d))), support_lines_pen);
