function thou(inch)=inch*25.4;

diameter=thou(.115);
r=diameter/2;
step=thou(.015);
base=thou(0.150);
$fn=32;

difference() {
	cube([12*diameter,base+12*step+2.5,r*.5]);
	translate([r,step,-1])
	for (i=[0:10]) {
		h=base + step * i;
		color("blue")
		translate([i*diameter,0,0]) {
		cube([diameter*1.01,h,diameter]);
		if(i<10) {
			offset=.8;
		translate([offset,base+11*step,r])
		linear_extrude(1)
		text(str(i),size=2);
		}
		else {
			offset= .1;
		translate([offset,base+11*step,r*1.1])
		linear_extrude(1)
		text(str(i),size=2);
		}
		}
	}
}

