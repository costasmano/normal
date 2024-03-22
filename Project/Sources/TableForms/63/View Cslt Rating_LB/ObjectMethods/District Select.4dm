//Drop down to filter Conslt Ratings by districts available
//Object Method: aDistrictSelect 
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(10/17/11 11:21:47)
	Mods_2011_10
	//  `Added a 6th district
	// Modified by: Costas Manousakis-(Designer)-(2021-10-05T00:00:00 09:28:58)
	Mods_2021_10
	//  `added default sort ; unload record and reset headers
End if 

C_TEXT:C284(sDistrict)  // Command Replaced was o _ C_STRING length was 2

Case of 
	: (Self:C308->=1)
		sDistrict:="@"
	: (Self:C308->=2)
		sDistrict:="01"
	: (Self:C308->=3)
		sDistrict:="02"
	: (Self:C308->=4)
		sDistrict:="03"
	: (Self:C308->=5)
		sDistrict:="04"
	: (Self:C308->=6)
		sDistrict:="05"
	: (Self:C308->=7)
		sDistrict:="06"
End case 

M_GetRegion
QUERY SELECTION:C341([Conslt Rating:63]; [Bridge MHD NBIS:1]Item2:60=sDistrict)

//vbSortedHeader:=False  //set to re sort according to current header
ORDER BY:C49([Conslt Rating:63]; [Bridge MHD NBIS:1]BDEPT:1; >)
UNLOAD RECORD:C212(Current form table:C627->)
LB_ResetHeaders("List box")
REDRAW WINDOW:C456
RegionTitle