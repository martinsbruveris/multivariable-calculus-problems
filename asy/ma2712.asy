import palette;
import three;
import graph3;
import grid3;

// void draw_graph_area(real f(pair), pair bl, pair tr, int nx=4, int ny=4,
// 										 int nx_ml=1, int nx_mr=1, int ny_mb=1, int ny_mt=1)
// {
// 	real dx = (tr.x - bl.x) / nx;
// 	real dy = (tr.y - bl.y) / ny;
// 	real ml = nx_ml * dx;   // margin width
// 	real mr = nx_mr * dx;
// 	real mb = ny_mb * dy;
// 	real mt = ny_mt * dy;

// 	// Draw surface with two different colors
// 	// Function defines domain of interest on surface
// 	real choosecolor(triple u){
// 		if (bl.x <= u.x && u.x <= tr.x && bl.y <= u.y && u.y <= tr.y)
// 			return 0;
// 		else
// 			return 1;
// 	}

// 	// Need nx and ny to be large, so that boundary is sharp
// 	surface s = surface(f, bl-(ml,mb), tr+(mr,mt), nx=resx, ny=resy, Spline);
// 	s.colors(palette(s.map(choosecolor), graph_colors)); // Set colors of surface
// 	draw(s);

// 	// Draw mesh
// 	for(int j = -nx_ml; j <= nx+nx_mr; ++j) {
// 		real x = bl.x + j*dx;
// 		draw(graph(new triple(real y) {return (x,y,f((x,y)) );},
// 							 bl.y-mb, tr.y+mt), graph_meshpen);
// 	}

// 	for(int j = -ny_mb; j <= ny+ny_mt; ++j) {
// 		real y = bl.y + j*dy;
// 		draw(graph(new triple(real x) {return (x,y,f((x,y)));},
// 							 bl.x-ml, tr.x+mr), graph_meshpen);
// 	}

// 	// Grid in xy-plane
// 	for(int j = 0; j <= nx; ++j){
// 		real x = bl.x + j*dx;
// 		if (abs(x) < 1e-10) // Don't draw over x-axis
// 			continue;
// 		draw((x,bl.y,0) -- (x,tr.y,0), xygrid_pen);
// 	}
// 	for(int j = 1; j <= ny; ++j){
// 		real y = bl.y + j*dy;
// 		if (abs(y) < 1e-10) // Don't draw over y-axis
// 			continue;
// 		draw((bl.x,y,0) -- (tr.x,y,0), xygrid_pen);
// 	}

// 	// Vertical lines in corners
// 	draw((bl.x,bl.y,0) -- (bl.x,bl.y,f(bl)), support_lines_pen);
// 	draw((bl.x,tr.y,0) -- (bl.x,tr.y,f((bl.x,tr.y))), support_lines_pen);
// 	draw((tr.x,bl.y,0) -- (tr.x,bl.y,f((tr.x,bl.y))), support_lines_pen);
// 	draw((tr.x,tr.y,0) -- (tr.x,tr.y,f(tr)), support_lines_pen);
// }

// void draw_axes2(pair bl, pair tr, int nx=4, int ny=4,
// 							 int nx_ml=1, int nx_mr=1, int ny_mb=1, int ny_mt=1,
// 							 real zmin, real zmax,
// 							 real[] xticks, real[] yticks, real[] zticks,
// 							 triple camera_direction)
// {
// 	real dx = (tr.x - bl.x) / nx;
// 	real dy = (tr.y - bl.y) / ny;
// 	real ml = nx_ml * dx;   // margin width
// 	real mr = nx_mr * dx;
// 	real mb = ny_mb * dy;
// 	real mt = ny_mt * dy;
	
// 	// Axes and labels
// 	limits((bl.x-ml, bl.y-mb, zmin), (tr.x+mr, tr.y+mt, zmax));

// 	xaxis3(Ticks3(1, Ticks=xticks),
// 				 arrow=Arrow3(TeXHead2(normal=Z), emissive(black)));
// 	xaxis3("$x$");
// 	yaxis3(Ticks3(1, Ticks=yticks),
// 				 arrow=Arrow3(TeXHead2(normal=Z), emissive(black)));
// 	yaxis3("$y$");

// 	triple arrow_normal = camera_direction - camera_direction.z*Z;
// 	zaxis3(Ticks3(1, Ticks=zticks),
// 				 arrow=Arrow3(TeXHead2(normal=arrow_normal), emissive(black)));
// 	zaxis3("$z$");
// }

void set_surface_colors(surface surf, real f(triple), material[] m){
	for(int i = 0; i < surf.s.length; ++i){
		patch act_patch = surf.s[i];
		triple[] corners = act_patch.corners();
		
		pen[] patch_colors;
		for(int j = 0; j < 4; ++j){
			triple act_corner = corners[j];
			int pen_index = round(f(act_corner));
			pen[] corner_pen_all = act_patch.colors(m[pen_index]);
			patch_colors[j] = corner_pen_all[j];
		}
		
		surf.s[i].colors = patch_colors;
	}
}

// I wonder if this is equivalent to the above function?
surface set_surface_colors(surface s, real domain(triple p), pen[] palette)
{
	surface s2 = s;
	real[][] f = s.map(domain);
	
  int n=f.length;
  int m=n > 0 ? f[0].length : 0;
  pen[][] p=new pen[n][m];
  for(int i=0; i < n; ++i) {
    real[] fi=f[i];
    p[i]=sequence(new pen(int j) {return palette[round(fi[j])];},m);
  }

	s2.colors(p);
	return s2;
}

void draw_axes(triple lower, triple upper,
							  real[] xticks, real[] yticks, real[] zticks,
							  triple camera_direction)
{
	// Axes and labels
	limits(lower, upper);

	xaxis3(Ticks3(1, Ticks=xticks),
				 arrow=Arrow3(TeXHead2(normal=Z), emissive(black)));
	xaxis3("$x$");
	yaxis3(Ticks3(1, Ticks=yticks),
				 arrow=Arrow3(TeXHead2(normal=Z), emissive(black)));
	yaxis3("$y$");

	triple arrow_normal = camera_direction - camera_direction.z*Z;
	zaxis3(Ticks3(1, Ticks=zticks),
				 arrow=Arrow3(TeXHead2(normal=arrow_normal), emissive(black)));
	zaxis3("$z$");
}
