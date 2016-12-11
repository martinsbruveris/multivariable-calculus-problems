size(5cm, 0); // Set image size

// triple camera_direction = (10.6,-5.2,5.4);
triple camera_direction = (5, 3, 3);

currentprojection = orthographic(camera_direction, up=Z);
currentlight=nolight;

draw(scale3(sqrt(0.5))*unitsphere, surface_pens[1]);

draw_axes((-0.1,-0.1,-0.1), (1.3, 1.3, 1.3),
					new real[] {1}, new real[] {1}, new real[] {1},
					camera_direction);

int nth = 8;
int nphi = 8;
real r = sqrt(0.5);

// phi-const
for(int j = 1; j < nphi; ++j){
  real phi = j * pi / nphi;
	draw(graph(new triple(real t) {return r*(cos(t)*sin(phi), sin(t)*sin(phi), cos(phi));},
					 0, 2*pi), mesh_pen);
}

// th-const
for(int j = 0; j < nth; ++j){
	real th = j * 2*pi / nth;
	draw(graph(new triple(real t) {return r*(cos(th)*sin(t), sin(th)*sin(t), cos(t));},
					 0, pi), mesh_pen);
}

draw((0,0,r) -- (0,0,r+1), arrow=Arrow3(), p=black+linewidth(1.2pt));
