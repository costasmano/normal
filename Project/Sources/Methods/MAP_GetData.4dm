//%attributes = {"invisible":true}
//Method: MAP_GetData
//Description
//  ` collect data in arrays from a list of bridge records to be passed on to a html template
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/02/13, 11:01:30
	// ----------------------------------------------------
	//Created : 
	Mods_2013_12
End if 
//

C_LONGINT:C283(MAP_BridgeCount_L)
C_DATE:C307(MAP_Date_d)

C_REAL:C285(MAP_CenterLat_r; MAP_CenterLon_r)
ARRAY REAL:C219(MAP_ArrayLat_ar; 0)
ARRAY REAL:C219(MAP_ArrayLon_ar; 0)
ARRAY TEXT:C222(MAP_ArrayDesc_atxt; 0)
ARRAY TEXT:C222(MAP_ArrayInfoWin_atxt; 0)
ARRAY TEXT:C222(MAP_ArrayBIN_atxt; 0)
ARRAY TEXT:C222($Bdepts_atxt; 0)
ARRAY TEXT:C222($item7_atxt; 0)
ARRAY TEXT:C222($item6a_atxt; 0)
ARRAY INTEGER:C220($it16a_aL; 0)
ARRAY INTEGER:C220($it16b_aL; 0)
ARRAY REAL:C219($it16c_ar; 0)
ARRAY INTEGER:C220($it17a_aL; 0)
ARRAY INTEGER:C220($it17b_aL; 0)
ARRAY REAL:C219($it17c_ar; 0)
ARRAY TEXT:C222($item8_atxt; 0)
ARRAY TEXT:C222($Town_atxt; 0)

C_LONGINT:C283($start_L; $end_L)
$start_L:=1
$end_L:=Records in selection:C76([Bridge MHD NBIS:1])
SELECTION RANGE TO ARRAY:C368($start_L; $end_L; [Bridge MHD NBIS:1]BIN:3; MAP_ArrayBIN_atxt; [Bridge MHD NBIS:1]BDEPT:1; $Bdepts_atxt; [Bridge MHD NBIS:1]Item7:65; $item7_atxt; [Bridge MHD NBIS:1]Item6A:63; $item6a_atxt)
SELECTION RANGE TO ARRAY:C368($start_L; $end_L; [Bridge MHD NBIS:1]Item16A:68; $it16a_aL; [Bridge MHD NBIS:1]Item16B:69; $it16b_aL; [Bridge MHD NBIS:1]Item16C:109; $it16c_ar; [Bridge MHD NBIS:1]Item17A:70; $it17a_aL; [Bridge MHD NBIS:1]Item17B:71; $it17b_aL; [Bridge MHD NBIS:1]Item17C:136; $it17c_ar)
SELECTION RANGE TO ARRAY:C368($start_L; $end_L; [Bridge MHD NBIS:1]Item8:206; $item8_atxt; [Bridge MHD NBIS:1]Town Name:175; $Town_atxt)
ARRAY REAL:C219(MAP_ArrayLat_ar; Size of array:C274(MAP_ArrayBIN_atxt))
ARRAY REAL:C219(MAP_ArrayLon_ar; Size of array:C274(MAP_ArrayBIN_atxt))
ARRAY TEXT:C222(MAP_ArrayDesc_atxt; Size of array:C274(MAP_ArrayBIN_atxt))
ARRAY TEXT:C222(MAP_ArrayInfoWin_atxt; Size of array:C274(MAP_ArrayBIN_atxt))
MAP_Date_d:=Current date:C33(*)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274(MAP_ArrayBIN_atxt))
	$item7_atxt{$loop_L}:=Replace string:C233($item7_atxt{$loop_L}; "'"; " ")
	$item6a_atxt{$loop_L}:=Replace string:C233($item6a_atxt{$loop_L}; "'"; " ")
	MAP_ArrayDesc_atxt{$loop_L}:=$Bdepts_atxt{$loop_L}+" "+MAP_ArrayBIN_atxt{$loop_L}+" "+Replace string:C233($item7_atxt{$loop_L}; "  "; " ")+" over "+Replace string:C233($item6a_atxt{$loop_L}; "  "; " ")
	MAP_ArrayInfoWin_atxt{$loop_L}:="<b>"+$Bdepts_atxt{$loop_L}+" ("+MAP_ArrayBIN_atxt{$loop_L}+") Item 8 : "+$item8_atxt{$loop_L}+"</b><br>"+Replace string:C233($item7_atxt{$loop_L}; "  "; " ")+" over "+Replace string:C233($item6a_atxt{$loop_L}; "  "; " ")+"<br>"+$Town_atxt{$loop_L}+"<br>"
	If (($it16a_aL{$loop_L}#0) & ($it17a_aL{$loop_L}#0))
		MAP_ArrayLat_ar{$loop_L}:=ut_DegMinSecToDeg($it16a_aL{$loop_L}; $it16b_aL{$loop_L}; $it16c_ar{$loop_L})
		MAP_ArrayLon_ar{$loop_L}:=-(ut_DegMinSecToDeg($it17a_aL{$loop_L}; $it17b_aL{$loop_L}; $it17c_ar{$loop_L}))
	Else 
		MAP_ArrayLon_ar{$loop_L}:=0
		MAP_ArrayLat_ar{$loop_L}:=0
	End if 
	
End for 

For ($loop_L; Size of array:C274(MAP_ArrayLat_ar); 1; -1)
	
	If (MAP_ArrayLat_ar{$loop_L}=0)
		DELETE FROM ARRAY:C228(MAP_ArrayBIN_atxt; $loop_L; 1)
		DELETE FROM ARRAY:C228(MAP_ArrayLat_ar; $loop_L; 1)
		DELETE FROM ARRAY:C228(MAP_ArrayLon_ar; $loop_L; 1)
		DELETE FROM ARRAY:C228(MAP_ArrayDesc_atxt; $loop_L; 1)
		DELETE FROM ARRAY:C228(MAP_ArrayInfoWin_atxt; $loop_L; 1)
		
	End if 
End for 

MAP_CenterLat_r:=0
MAP_CenterLon_r:=0
MAP_BridgeCount_L:=Size of array:C274(MAP_ArrayLat_ar)
For ($loop_L; 1; Size of array:C274(MAP_ArrayLat_ar))
	MAP_CenterLat_r:=MAP_CenterLat_r+MAP_ArrayLat_ar{$loop_L}
	MAP_CenterLon_r:=MAP_CenterLon_r+MAP_ArrayLon_ar{$loop_L}
End for 
MAP_CenterLat_r:=MAP_CenterLat_r/MAP_BridgeCount_L
MAP_CenterLon_r:=MAP_CenterLon_r/MAP_BridgeCount_L

C_TEXT:C284($map_tml_txt)
$map_tml_txt:=ut_GetSysParameter("MAP_Template1")

MAP_HTMLOutputFile_txt:=""
If ($map_tml_txt="")
	ALERT:C41("Parameter MAP_Template1 does not exist ir is blank!")
Else 
	C_BLOB:C604($htmlfile_blb)
	TEXT TO BLOB:C554($map_tml_txt; $htmlfile_blb; UTF8 text without length:K22:17)
	
	PROCESS 4D TAGS:C816($htmlfile_blb; $htmlfile_blb)
	//TEXT TO BLOB($map_tml_txt;$htmlfile_blb;UTF8 text without length )
	C_TEXT:C284($tempName_txt)
	$tempName_txt:=Substring:C12(String:C10(Current date:C33(*); ISO date:K1:8); 1; 10)+" "+String:C10(Current time:C178(*); HH MM SS:K7:1)
	$tempName_txt:=Replace string:C233($tempName_txt; ":"; "")
	$tempName_txt:=Replace string:C233($tempName_txt; "-"; "")
	$tempName_txt:=String:C10(Current process:C322; "00000")+"-"+$tempName_txt
	$tempName_txt:=Temporary folder:C486+$tempName_txt+".html"
	C_TIME:C306($doc_t)
	$doc_t:=Create document:C266($tempName_txt)
	CLOSE DOCUMENT:C267($doc_t)
	BLOB TO DOCUMENT:C526($tempName_txt; $htmlfile_blb)
	MAP_HTMLOutputFile_txt:=$tempName_txt
End if 

//End MAP_GetData