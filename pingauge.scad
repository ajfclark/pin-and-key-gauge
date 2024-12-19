/* [Margins] */
Thickness=2; // 0.1
Border=2; //0.1

/* [Pin Parameters] */
// Pin Type/Name
Title="Lockwood";
// Number of different pin heights
Number_of_Bittings=11;
// The number to denote the first pin
Pin_Numbering_Start=0;
// The diameter of the pins (in inches)
Pin_Diameter=0.115; // 0.001
// Height of the first pin (in inches)
Pin_Height_Base=0.150; // 0.001

// Change in height between pins (in inches)
Pin_Height_Step=0.015; // 0.001

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
num=Number_of_Bittings;
r=d/2;

difference() {
	translate([-Border,-Font_Size-Border*2,0])
		cube([num*d+Border*2,b+num*s+Font_Size*2+Border*3,Thickness]);
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
			translate([i*d+r,-Border,0])
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
			text(str(i+Pin_Numbering_Start),size=Font_Size,halign="center", valign="top",font="DejaVu Sans:style=Bold");
}

module title() {
	color("blue")
		linear_extrude(height=abs(Font_Depth))
			text(Title,size=Font_Size,halign="left", valign="bottom",font="DejaVu Sans:style=Bold");
}
