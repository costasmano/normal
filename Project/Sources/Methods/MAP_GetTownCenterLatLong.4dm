//%attributes = {"invisible":true}
//Method: MAP_GetTownCenterLatLong
//Description
//  ` Load the center lat and long of a town - uses only NBI records with ite16a, 17a > 0 and gets the average
// Parameters
// $1 : $townName_txt
// $2 : $Lat_ptr
// $3 : $Lon_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/02/13, 11:00:06
	// ----------------------------------------------------
	//Created : 
	Mods_2013_12
End if 
//
C_TEXT:C284($1; $townName_txt)
C_POINTER:C301($2; $3)

ARRAY LONGINT:C221($it16a_aL; 0)
ARRAY LONGINT:C221($it16b_aL; 0)
ARRAY REAL:C219($it16c_ar; 0)
ARRAY LONGINT:C221($it17a_aL; 0)
ARRAY LONGINT:C221($it17b_aL; 0)
ARRAY REAL:C219($it17c_ar; 0)

$townName_txt:=$1
Begin SQL
	select Item16A, Item16B, Item16C, Item17A, Item17B, Item17C 
	from [Bridge MHD NBIS] 
	where [Bridge MHD NBIS].[Town Name] = :$townName_txt
	and [Bridge MHD NBIS].Item16A > 0
	and [Bridge MHD NBIS].Item17A > 0
	and  CAST([Bridge MHD NBIS].FHWARecord as INT) = 1 
	into :$it16a_aL , :$it16b_aL, :$it16C_ar, :$it17a_aL, :$it17b_aL, :$it17C_ar ;
	
End SQL
C_REAL:C285($lat_r; $lon_r; $centLat_r; $centLon_r)
C_LONGINT:C283($loop_L; $count_L)
$centLat_r:=0
$centLon_r:=0
$count_L:=0

For ($loop_L; Size of array:C274($it16a_aL); 1; -1)
	$lat_r:=ut_DegMinSecToDeg($it16a_aL{$loop_L}; $it16b_aL{$loop_L}; $it16c_ar{$loop_L})
	$lon_r:=ut_DegMinSecToDeg($it17a_aL{$loop_L}; $it17b_aL{$loop_L}; $it17c_ar{$loop_L})
	
	If (MAP_OutOfStateBoundary_b($lat_r; $lon_r))
	Else 
		$centLat_r:=$centLat_r+$lat_r
		$centLon_r:=$centLon_r+$lon_r
		$count_L:=$count_L+1
		
	End if 
	
End for 

$centLat_r:=$centLat_r/$count_L
$centLon_r:=$centLon_r/$count_L

$2->:=$centLat_r
$3->:=$centLon_r
//End MAP_GetTownCenterLatLong