//%attributes = {"invisible":true}
//Method: ut_TwoPointDist
//Description
//  ` Get the distance between two points specified as Lat Long in decimal degrees.
// Parameters
// $0 : $Dist_r
// $1 : $Lat1_Deg_r
// $2 : $Lon1_Deg_r
// $3 : $Lat2_Deg_r
// $4 : $Lon2_Deg_r
// $5 : $Units_txt (Optional "FT" | "MT" | "MI" | "KM"
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/08/12, 15:07:41
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//
C_REAL:C285($1; $Lat1_Deg_r; $2; $Lon1_Deg_r; $3; $Lat2_Deg_r; $4; $Lon2_Deg_r)
C_REAL:C285($0; $Dist_r)
$Lat1_Deg_r:=$1
$Lon1_Deg_r:=$2
$Lat2_Deg_r:=$3
$Lon2_Deg_r:=$4
C_TEXT:C284($Units_txt)
$Units_txt:="FT"
If (Count parameters:C259>4)
	C_TEXT:C284($5)
	$Units_txt:=$5
End if 
C_REAL:C285($EarthRad_r)
$EarthRad_r:=20902230.97104
Case of 
	: ($Units_txt="FT")
	: ($Units_txt="MT")
		$EarthRad_r:=6371*1000
	: ($Units_txt="MI")
		$EarthRad_r:=3958.755864232
	: ($Units_txt="KM")
		$EarthRad_r:=6371
End case 
C_REAL:C285($Dlat_r; $Dlon_r; $a_r; $C_r)
$Dlat_r:=(($Lat2_Deg_r-$Lat1_Deg_r)*Pi:K30:1)/180
$Dlon_r:=(($Lon2_Deg_r-$Lon1_Deg_r)*Pi:K30:1)/180
//SIN(U2/2)*SIN(U2/2)+COS(M2)*COS(Q2)*SIN(V2/2)*SIN(V2/2)
$a_r:=Sin:C17($Dlat_r/2)*Sin:C17($Dlat_r/2)+(Cos:C18($Lat1_Deg_r*Pi:K30:1/180)*Cos:C18($Lat2_Deg_r*Pi:K30:1/180)*Sin:C17($Dlon_r/2)*Sin:C17($Dlon_r/2))
//2*ASIN(MIN(1,SQRT(W2)))
$C_r:=2*(ArcSin(MinNum(1; Square root:C539($a_r))))

$Dist_r:=$EarthRad_r*$C_r

$0:=$Dist_r

//End ut_TwoPointDist