size(5cm, 0); // Set image size

// triple camera_direction = (10.6,-5.2,5.4);
triple camera_direction = (5, 3, 3);

currentprojection = orthographic(camera_direction, up=Z);
currentlight=nolight;

// Graphing the plane on rectangle
real a = -1.25;
real b = -1.25;
real c = 1.25;
real d = 1.25;
real r = 1.1;

// Target function
real f(pair p){
	return 2*(p.x^2 + p.y^2);
}

// Parametrization of domain; polar coordinates
pair phi(pair p){
	return (p.x * cos(p.y), p.x * sin(p.y));
}

// Target function pulled back to rectangle
triple g(pair p){
	pair z = phi(p);
	return (z.x, z.y, f(z));
}

// Indicator function
int find_domain(triple p){
	if (p.z <= f((1,0)))
		return emph_ind;
	else if(p.z <= f((r,0)))
		return grey_ind;
	else
		return trns_ind;
}

real choosecolor(triple p){
	return find_domain(p);
}

// Need nu and nv to be large, so that boundary is sharp
surface s = surface(g, (0, 0), (r, 2*pi), nu=resx, nv=resy);
set_surface_colors(s, choosecolor, surface_pens);
draw(s);

draw_axes((a, b, 0), (c, d, 3.3),
					new real[] {-1, 1}, new real[] {-1, 1}, new real[] {1, 2, 3},
					camera_direction);

int nr = 3;
int nth = 12;

// Mesh lines, r=const
for(int j = 1; j <= nr; ++j){
  real r = j * 1 / nr;
	draw(circle(O, r, normal=Z), support_lines_pen);
	draw(graph(new triple(real t) {return (r*cos(t), r*sin(t), f((r*cos(t),r*sin(t))));},
						 0, 2*pi), mesh_pen);
}

// th-const
for(int j = 0; j < nth; ++j){
	real th = j * 2*pi / nth;
	path3 p = (0, 0, 0) -- (cos(th), sin(th), 0);
	draw(p, support_lines_pen);
	draw(graph(new triple(real t) {return (t*cos(th), t*sin(th),
																				 f((t*cos(th),t*sin(th))));},
					 0, r), mesh_pen);
}

// Bounding circle in xy-plane and on graph
draw(circle(O, 1, normal=Z), mesh_pen);
draw(graph(new triple(real t) {return (cos(t), sin(t), f((cos(t),sin(t))));},
					 0, 2*pi),mesh_pen);
draw(graph(new triple(real t) {return (r*cos(t), r*sin(t), f((r*cos(t),r*sin(t))));},
					 0, 2*pi), mesh_pen);


path3 p = plane(O = (-1.25,-1.25,2), u=(2.5,0,0), v=(0,2.5,0));
draw(surface(p), aux_surface_pen);
