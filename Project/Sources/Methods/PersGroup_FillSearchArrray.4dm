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
	Mods_2020_09  //Add search picker to [PERS_Groups] output list box
	//Modified by: CJ (9/17/20 13:44:01)
	
End if 
//


ARRAY TEXT:C222($GroupSearchArray_atxt; 0)
ARRAY LONGINT:C221($GroupID_aL; 0)

Begin SQL
	select 
	[PERS_Groups].[PERS_GroupID_I],
	[PERS_Groups].[PERS_GroupName_s]
	FROM
	[PERS_Groups]
	INTO
	:$GroupID_aL,
	:$GroupSearchArray_atxt;
	
	
End SQL
ARRAY LONGINT:C221(<>GroupID_aL; 0)
ARRAY TEXT:C222(<>GroupsSearchArray_atxt; 0)
COPY ARRAY:C226($GroupSearchArray_atxt; <>GroupsSearchArray_atxt)
COPY ARRAY:C226($GroupID_aL; <>GroupID_aL)
//End Personnel_FillSearchArrray