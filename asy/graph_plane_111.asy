// x + y + z = 2 in first octant
//   --> z = 2 - x - y
// x-axis: x=2
// y-axis: y=2
// z-axis: z=2

size(5cm, 0); // Set image size

triple camera_direction = (9.3, -5.1, 5.1);

currentprojection = orthographic(camera_direction, up=Z);
currentlight=nolight;

// Graphing the plane on boundary triangle (a,b) -- (c,b) -- (a,d)
real a = -0.2;
real b = -0.2;
real c = 2.4;
real d = 2.4;

// Target function
real f(pair p){
	return 2 - p.x - p.y;
}

// Parametrization of domain; [a,c] x [b,d] --> triangle
pair phi(pair p){
	return (p.x, (b-p.y)*(p.x-a)/(c-a) + p.y);
}

// Target function pulled back to rectangle
triple g(pair p){
	pair z = phi(p);
	return (z.x, z.y, f(z));
}

// Indicator function
int find_domain(triple p){
	if (0 <= p.x && p.x <= 2 && 0 <= p.y && p.y <= 2-p.x)
		return grey_ind;
	else
		return grtr_ind;
}

real choosecolor(triple p){
	return find_domain(p);
}

// Need nu and nv to be large, so that boundary is sharp
surface s = surface(g, (a,b), (c,d), nu=resx, nv=resy);
set_surface_colors(s, choosecolor, surface_pens);
draw(s);

draw_axes((-0.2, -0.2, -0.2), (2.4, 2.4, 2.4),
					 new real[] {1, 2}, new real[] {1, 2}, new real[] {1, 2, 3},
					 camera_direction);

int nx = 4;
int ny = 4;

for(int j = 0; j <= nx; ++j){
real x = j * 2 / nx;
draw(graph(new triple(real y) {return (x,y,f((x,y)) );},
					 0, 2-x), mesh_pen);
}

for(int j = 0; j <= ny; ++j){
real y = j * 2 / ny;
draw(graph(new triple(real x) {return (x,y,f((x,y)) );},
					 0, 2-y), mesh_pen);
}

draw((0,2,0) -- (2,0,0), mesh_pen);
