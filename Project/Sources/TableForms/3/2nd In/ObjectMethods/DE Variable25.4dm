//Script for CheckBox Item 10 

Case of 
	: (CBItem10=1)
		[NBIS Secondary:3]Item10:9:=99.99
	: (CBItem10=0)
		[NBIS Secondary:3]Item10:9:=0
End case 
PushChange(1; ->[NBIS Secondary:3]Item10:9)