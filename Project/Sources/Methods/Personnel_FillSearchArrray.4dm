//%attributes = {"invisible":true,"executedOnServer":true}
//Method: Personnel_FillSearchArrray
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 09/17/20, 12:28:59
	// ----------------------------------------------------
	//Created : 
	Mods_2020_09  //Add search picker to personnel output list box
	//Modified by: CJ (9/17/20 13:44:01)
	
End if 
//


ARRAY TEXT:C222($PersonnelSearchArray_atxt; 0)
ARRAY LONGINT:C221($personID_aL; 0)


Begin SQL
	select 
	[Personnel].[Person ID],
	CONCAT(CONCAT('~!~',[Personnel].[First Name]),
	CONCAT('~!~',[Personnel].[Last Name]))
	FROM
	[Personnel]
	INTO
	:$personID_aL,
	:$PersonnelSearchArray_atxt;
	
	
End SQL
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($personID_aL))
	$PersonnelSearchArray_atxt{$loop_L}:=String:C10($personID_aL{$loop_L})+$PersonnelSearchArray_atxt{$loop_L}
End for 
ARRAY TEXT:C222(<>PersonnelSearchArray_atxt; 0)
COPY ARRAY:C226($PersonnelSearchArray_atxt; <>PersonnelSearchArray_atxt)
//End Personnel_FillSearchArrray