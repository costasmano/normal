
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/13/16, 11:50:04
//----------------------------------------------------
//Method: Object Method: ConvertPicture.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_05  // 
	//Modified by: administrator (5/13/16 11:50:07)
	
End if 
ARRAY LONGINT:C221(CNV_RecordNumber_aL; 0)
If (CNV_StandardPhotos_L=1)
	ColumnWidths_txt:="Standard Photos"
	LONGINT ARRAY FROM SELECTION:C647([Standard Photos:36]; CNV_RecordNumber_aL)
Else 
	ColumnWidths_txt:="Inventory Photos"
	LONGINT ARRAY FROM SELECTION:C647([InventoryPhotos:113]; CNV_RecordNumber_aL)
End if 
ACCEPT:C269
//End Object Method: ConvertPicture.Button1

