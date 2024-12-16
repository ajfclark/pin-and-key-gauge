/* [Title] */
Title="Lockwood";
Thickness=2; // 0.1

/* [Pin Parameters] */
Number_of_Pins=11;
// The diameter of the pins (in inches)
Pin_Diameter=0.115;
// Height of the first pin (in inches)
Pin_Height_Base=0.150;
// Change in height between pins (in inches)
Pin_Height_Step=0.015;

/* [Font] */
Font_Size=1.5; // 0.1
Font_Depth=-0.75; // 0.1

/* [Rendering Options] */
// Number of fragments, expressed as a power of 2
Number_of_Fragments=4;

$fn=pow(2,Number_of_Fragments);
d=thou(Pin_Diameter*2);
s=thou(Pin_Height_Step);
b=thou(Pin_Height_Base);
num=Number_of_Pins;
r=d/2;

difference() {
	translate([-2.5,-Font_Size-1,0])
		cube([num*d+5,b+num*s+Font_Size*2+2,Thickness]);
	pins();
	markings();
}
if(Font_Depth>0) markings();

function thou(inch)=inch*25.4;

module pins() {
	color("red")
	for (i=[0:num-1])
		translate([i*d,0,-Thickness/2])
			cube([d*1.01,b+s*i,Thickness*2]);
}

module markings() {
	translate([0,0,Thickness]) {
		for (i=[0:num-1])
			translate([i*d+r,-0.5,0])
				if(Font_Depth<0)
					translate([0,0,Font_Depth+.01]) number(i=i);
				else
					number(i=i);
		if(Font_Depth<0)
			translate([0,b+num*s,Font_Depth+.01])
				title();
		else
			translate([0,b+num*s,0])
				title();
	}
}

module number(i) {
	color("blue")
		linear_extrude(height=abs(Font_Depth))
			text(str(i),size=Font_Size,halign="center", valign="top",font="DejaVu Sans:style=Bold");
}

module title() {
	color("blue")
		linear_extrude(height=abs(Font_Depth))
			text(Title,size=Font_Size,halign="left", valign="bottom",font="DejaVu Sans:style=Bold");
}
