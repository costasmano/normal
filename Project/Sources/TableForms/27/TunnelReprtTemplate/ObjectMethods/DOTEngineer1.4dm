//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/23/13, 15:46:08
//----------------------------------------------------
//Method: Object Method: [Inspections].TunnelRoutinePg1.Insp_DIE_txt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_04  //r001 ` 
	//Modified by: Charles Miller (4/23/13 15:46:09)
	
End if 
Insp_DIE_txt:=fn_ReturnName(->[TunnelInspection:152]QA_QC_L:2)
READ ONLY:C145([Personnel:42])
QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=[TunnelInspection:152]QA_QC_L:2)
ARRAY LONGINT:C221($Pos_aL; 0)
ARRAY LONGINT:C221($left_aL; 0)

If (Match regex:C1019("(.*)(P\\.E\\.)(.*)"; [Personnel:42]Suffix:6; 1; $Pos_aL; $left_aL))
	Insp_DIE_txt:=Insp_DIE_txt+Substring:C12([Personnel:42]Suffix:6; 1; ($left_aL{1}+$left_aL{2}))
End if 

//End Object Method: [Inspections].TunnelRoutinePg1.Insp_DIE_txt