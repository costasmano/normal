//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/07/08, 08:26:49
	// ----------------------------------------------------
	// Method: F_MDistance
	// Description
	// Method to calculate the distance in miles between two LatLon points
	// (3963 : radius of Earth in miles)
	// 
	// Parameters
	// $0 : $Dist in miles
	// $1 : $Lat1 (Decimal degrees)
	// $2 : $Lon1 (Decimal degrees)
	// $3 : $Lat2 (Decimal degrees)
	// $4 : $Lon2 (Decimal degrees)
	// ----------------------------------------------------
	//METHOD: F_MDistance(LatitudeA;LongitudeA;LatitudeB;LongitudeB) `Lats  and Longs in degrees
	
	Mods_2008_CM_5403
End if 

C_REAL:C285($0; $1; $2; $3; $4; $r; $x)
//***** Change Degrees to Radians
$r:=Pi:K30:1/180
//and make an intermediate calculation
$x:=(Sin:C17($1*$r)*Sin:C17($3*$r))+(Cos:C18($1*$r)*Cos:C18($3*$r)*Cos:C18(($4*$r)-($2*$r)))
//then calculate the distance in miles
$0:=3963*Arctan:C20((Square root:C539(1-($x^2)))/$x)  //the distance in miles
