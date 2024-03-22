//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 02/29/16, 11:21:53
//----------------------------------------------------
//Method: LSS_CompareImportTableCounts
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_02_bug  // 
	//Modified by: administrator (2/29/16 11:21:55)
	
End if 
ARRAY TEXT:C222($TableNames_atxt; 0)
ARRAY LONGINT:C221($LocalCountImp001_aL; 0)
ARRAY LONGINT:C221($LocalCountImp002_aL; 0)
ARRAY LONGINT:C221($LocalCountImp003_aL; 0)
ARRAY LONGINT:C221($LocalCountImp004_aL; 0)

APPEND TO ARRAY:C911($TableNames_atxt; "[LSS_DMeter]")
APPEND TO ARRAY:C911($LocalCountImp001_aL; LSS_ReturnCount("[LSS_DMeter]"; "[LSS_DMeter].[LSS_DMeterId_s]"; "IMPORT001%"))
APPEND TO ARRAY:C911($LocalCountImp002_aL; LSS_ReturnCount("[LSS_DMeter]"; "[LSS_DMeter].[LSS_DMeterId_s]"; "IMPORT002%"))
APPEND TO ARRAY:C911($LocalCountImp003_aL; LSS_ReturnCount("[LSS_DMeter]"; "[LSS_DMeter].[LSS_DMeterId_s]"; "IMPORT003%"))
APPEND TO ARRAY:C911($LocalCountImp004_aL; LSS_ReturnCount("[LSS_DMeter]"; "[LSS_DMeter].[LSS_DMeterId_s]"; "IMPORT004%"))

APPEND TO ARRAY:C911($TableNames_atxt; "[LSS_ElementInspection]")
APPEND TO ARRAY:C911($LocalCountImp001_aL; LSS_ReturnCount("[LSS_ElementInspection]"; "[LSS_ElementInspection].[LSS_ElementInspectionId_s]"; "IMPORT001%"))
APPEND TO ARRAY:C911($LocalCountImp002_aL; LSS_ReturnCount("[LSS_ElementInspection]"; "[LSS_ElementInspection].[LSS_ElementInspectionId_s]"; "IMPORT002%"))
APPEND TO ARRAY:C911($LocalCountImp003_aL; LSS_ReturnCount("[LSS_ElementInspection]"; "[LSS_ElementInspection].[LSS_ElementInspectionId_s]"; "IMPORT003%"))
APPEND TO ARRAY:C911($LocalCountImp004_aL; LSS_ReturnCount("[LSS_ElementInspection]"; "[LSS_ElementInspection].[LSS_ElementInspectionId_s]"; "IMPORT004%"))

APPEND TO ARRAY:C911($TableNames_atxt; "[LSS_Inspection]")
APPEND TO ARRAY:C911($LocalCountImp001_aL; LSS_ReturnCount("[LSS_Inspection]"; "[LSS_Inspection].[LSS_InspectionId_s]"; "IMPORT001%"))
APPEND TO ARRAY:C911($LocalCountImp002_aL; LSS_ReturnCount("[LSS_Inspection]"; "[LSS_Inspection].[LSS_InspectionId_s]"; "IMPORT002%"))
APPEND TO ARRAY:C911($LocalCountImp003_aL; LSS_ReturnCount("[LSS_Inspection]"; "[LSS_Inspection].[LSS_InspectionId_s]"; "IMPORT003%"))
APPEND TO ARRAY:C911($LocalCountImp004_aL; LSS_ReturnCount("[LSS_Inspection]"; "[LSS_Inspection].[LSS_InspectionId_s]"; "IMPORT004%"))

APPEND TO ARRAY:C911($TableNames_atxt; "[LSS_Inventory]")
APPEND TO ARRAY:C911($LocalCountImp001_aL; LSS_ReturnCount("[LSS_Inventory]"; "[LSS_Inventory].[LSS_InventoryId_s]"; "IMPORT001%"))
APPEND TO ARRAY:C911($LocalCountImp002_aL; LSS_ReturnCount("[LSS_Inventory]"; "[LSS_Inventory].[LSS_InventoryId_s]"; "IMPORT002%"))
APPEND TO ARRAY:C911($LocalCountImp003_aL; LSS_ReturnCount("[LSS_Inventory]"; "[LSS_Inventory].[LSS_InventoryId_s]"; "IMPORT003%"))
APPEND TO ARRAY:C911($LocalCountImp004_aL; LSS_ReturnCount("[LSS_Inventory]"; "[LSS_Inventory].[LSS_InventoryId_s]"; "IMPORT004%"))

APPEND TO ARRAY:C911($TableNames_atxt; "[LSS_Photos]")
APPEND TO ARRAY:C911($LocalCountImp001_aL; LSS_ReturnCount("[LSS_Photos]"; "[LSS_Photos].[LSS_PhotoId_s]"; "IMPORT001%"))
APPEND TO ARRAY:C911($LocalCountImp002_aL; LSS_ReturnCount("[LSS_Photos]"; "[LSS_Photos].[LSS_PhotoId_s]"; "IMPORT002%"))
APPEND TO ARRAY:C911($LocalCountImp003_aL; LSS_ReturnCount("[LSS_Photos]"; "[LSS_Photos].[LSS_PhotoId_s]"; "IMPORT003%"))
APPEND TO ARRAY:C911($LocalCountImp004_aL; LSS_ReturnCount("[LSS_Photos]"; "[LSS_Photos].[LSS_PhotoId_s]"; "IMPORT004%"))

APPEND TO ARRAY:C911($TableNames_atxt; "[LSS_SignPanel]")
APPEND TO ARRAY:C911($LocalCountImp001_aL; LSS_ReturnCount("[LSS_SignPanel]"; "[LSS_SignPanel].[LSS_SignPanelId_s]"; "IMPORT001%"))
APPEND TO ARRAY:C911($LocalCountImp002_aL; LSS_ReturnCount("[LSS_SignPanel]"; "[LSS_SignPanel].[LSS_SignPanelId_s]"; "IMPORT002%"))
APPEND TO ARRAY:C911($LocalCountImp003_aL; LSS_ReturnCount("[LSS_SignPanel]"; "[LSS_SignPanel].[LSS_SignPanelId_s]"; "IMPORT003%"))
APPEND TO ARRAY:C911($LocalCountImp004_aL; LSS_ReturnCount("[LSS_SignPanel]"; "[LSS_SignPanel].[LSS_SignPanelId_s]"; "IMPORT004%"))

APPEND TO ARRAY:C911($TableNames_atxt; "[LSS_TeamMembers]")
APPEND TO ARRAY:C911($LocalCountImp001_aL; LSS_ReturnCount("[LSS_TeamMembers]"; "[LSS_TeamMembers].[LSS_InspectionId_s]"; "IMPORT001%"))
APPEND TO ARRAY:C911($LocalCountImp002_aL; LSS_ReturnCount("[LSS_TeamMembers]"; "[LSS_TeamMembers].[LSS_InspectionId_s]"; "IMPORT002%"))
APPEND TO ARRAY:C911($LocalCountImp003_aL; LSS_ReturnCount("[LSS_TeamMembers]"; "[LSS_TeamMembers].[LSS_InspectionId_s]"; "IMPORT003%"))
APPEND TO ARRAY:C911($LocalCountImp004_aL; LSS_ReturnCount("[LSS_TeamMembers]"; "[LSS_TeamMembers].[LSS_InspectionId_s]"; "IMPORT004%"))

APPEND TO ARRAY:C911($TableNames_atxt; "[LSS_TowerDistance]")
APPEND TO ARRAY:C911($LocalCountImp001_aL; LSS_ReturnCount("[LSS_TowerDistance]"; "[LSS_TowerDistance].LSS_TowerDistanceId_s"; "IMPORT001%"))
APPEND TO ARRAY:C911($LocalCountImp002_aL; LSS_ReturnCount("[LSS_TowerDistance]"; "[LSS_TowerDistance].LSS_TowerDistanceId_s"; "IMPORT002%"))
APPEND TO ARRAY:C911($LocalCountImp003_aL; LSS_ReturnCount("[LSS_TowerDistance]"; "[LSS_TowerDistance].LSS_TowerDistanceId_s"; "IMPORT003%"))
APPEND TO ARRAY:C911($LocalCountImp004_aL; LSS_ReturnCount("[LSS_TowerDistance]"; "[LSS_TowerDistance].LSS_TowerDistanceId_s"; "IMPORT004%"))

APPEND TO ARRAY:C911($TableNames_atxt; "[LSS_UT]")
APPEND TO ARRAY:C911($LocalCountImp001_aL; LSS_ReturnCount("[LSS_UT]"; "[LSS_UT].[LSS_UTId_s]"; "IMPORT001%"))
APPEND TO ARRAY:C911($LocalCountImp002_aL; LSS_ReturnCount("[LSS_UT]"; "[LSS_UT].[LSS_UTId_s]"; "IMPORT002%"))
APPEND TO ARRAY:C911($LocalCountImp003_aL; LSS_ReturnCount("[LSS_UT]"; "[LSS_UT].[LSS_UTId_s]"; "IMPORT003%"))
APPEND TO ARRAY:C911($LocalCountImp004_aL; LSS_ReturnCount("[LSS_UT]"; "[LSS_UT].[LSS_UTId_s]"; "IMPORT004%"))

APPEND TO ARRAY:C911($TableNames_atxt; "[LSS_UtResult]")
APPEND TO ARRAY:C911($LocalCountImp001_aL; LSS_ReturnCount("[LSS_UtResult]"; "[LSS_UtResult].[LSS_UTResultId_s]"; "IMPORT001%"))
APPEND TO ARRAY:C911($LocalCountImp002_aL; LSS_ReturnCount("[LSS_UtResult]"; "[LSS_UtResult].[LSS_UTResultId_s]"; "IMPORT002%"))
APPEND TO ARRAY:C911($LocalCountImp003_aL; LSS_ReturnCount("[LSS_UtResult]"; "[LSS_UtResult].[LSS_UTResultId_s]"; "IMPORT003%"))
APPEND TO ARRAY:C911($LocalCountImp004_aL; LSS_ReturnCount("[LSS_UtResult]"; "[LSS_UtResult].[LSS_UTResultId_s]"; "IMPORT004%"))

APPEND TO ARRAY:C911($TableNames_atxt; "[LSS_VerticalClearance]")
APPEND TO ARRAY:C911($LocalCountImp001_aL; LSS_ReturnCount("[LSS_VerticalClearance]"; "[LSS_VerticalClearance].[LSS_VerticalClearanceId_s]"; "IMPORT001%"))
APPEND TO ARRAY:C911($LocalCountImp002_aL; LSS_ReturnCount("[LSS_VerticalClearance]"; "[LSS_VerticalClearance].[LSS_VerticalClearanceId_s]"; "IMPORT002%"))
APPEND TO ARRAY:C911($LocalCountImp003_aL; LSS_ReturnCount("[LSS_VerticalClearance]"; "[LSS_VerticalClearance].[LSS_VerticalClearanceId_s]"; "IMPORT003%"))
APPEND TO ARRAY:C911($LocalCountImp004_aL; LSS_ReturnCount("[LSS_VerticalClearance]"; "[LSS_VerticalClearance].[LSS_VerticalClearanceId_s]"; "IMPORT004%"))


C_TEXT:C284($IPAddress_txt)

$IPAddress_txt:=SQL_TestConnection
If ($IPAddress_txt#"")
	ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
	ARRAY LONGINT:C221($RemoteCountImp001_aL; 0)
	ARRAY LONGINT:C221($RemoteCountImp002_aL; 0)
	ARRAY LONGINT:C221($RemoteCountImp003_aL; 0)
	ARRAY LONGINT:C221($RemoteCountImp004_aL; 0)
	APPEND TO ARRAY:C911($RemoteCountImp001_aL; LSS_ReturnCount("[LSS_DMeter]"; "[LSS_DMeter].[LSS_DMeterId_s]"; "IMPORT001%"))
	APPEND TO ARRAY:C911($RemoteCountImp002_aL; LSS_ReturnCount("[LSS_DMeter]"; "[LSS_DMeter].[LSS_DMeterId_s]"; "IMPORT002%"))
	APPEND TO ARRAY:C911($RemoteCountImp003_aL; LSS_ReturnCount("[LSS_DMeter]"; "[LSS_DMeter].[LSS_DMeterId_s]"; "IMPORT003%"))
	APPEND TO ARRAY:C911($RemoteCountImp004_aL; LSS_ReturnCount("[LSS_DMeter]"; "[LSS_DMeter].[LSS_DMeterId_s]"; "IMPORT004%"))
	
	APPEND TO ARRAY:C911($RemoteCountImp001_aL; LSS_ReturnCount("[LSS_ElementInspection]"; "[LSS_ElementInspection].[LSS_ElementInspectionId_s]"; "IMPORT001%"))
	APPEND TO ARRAY:C911($RemoteCountImp002_aL; LSS_ReturnCount("[LSS_ElementInspection]"; "[LSS_ElementInspection].[LSS_ElementInspectionId_s]"; "IMPORT002%"))
	APPEND TO ARRAY:C911($RemoteCountImp003_aL; LSS_ReturnCount("[LSS_ElementInspection]"; "[LSS_ElementInspection].[LSS_ElementInspectionId_s]"; "IMPORT003%"))
	APPEND TO ARRAY:C911($RemoteCountImp004_aL; LSS_ReturnCount("[LSS_ElementInspection]"; "[LSS_ElementInspection].[LSS_ElementInspectionId_s]"; "IMPORT004%"))
	
	APPEND TO ARRAY:C911($RemoteCountImp001_aL; LSS_ReturnCount("[LSS_Inspection]"; "[LSS_Inspection].[LSS_InspectionId_s]"; "IMPORT001%"))
	APPEND TO ARRAY:C911($RemoteCountImp002_aL; LSS_ReturnCount("[LSS_Inspection]"; "[LSS_Inspection].[LSS_InspectionId_s]"; "IMPORT002%"))
	APPEND TO ARRAY:C911($RemoteCountImp003_aL; LSS_ReturnCount("[LSS_Inspection]"; "[LSS_Inspection].[LSS_InspectionId_s]"; "IMPORT003%"))
	APPEND TO ARRAY:C911($RemoteCountImp004_aL; LSS_ReturnCount("[LSS_Inspection]"; "[LSS_Inspection].[LSS_InspectionId_s]"; "IMPORT004%"))
	
	APPEND TO ARRAY:C911($RemoteCountImp001_aL; LSS_ReturnCount("[LSS_Inventory]"; "[LSS_Inventory].[LSS_InventoryId_s]"; "IMPORT001%"))
	APPEND TO ARRAY:C911($RemoteCountImp002_aL; LSS_ReturnCount("[LSS_Inventory]"; "[LSS_Inventory].[LSS_InventoryId_s]"; "IMPORT002%"))
	APPEND TO ARRAY:C911($RemoteCountImp003_aL; LSS_ReturnCount("[LSS_Inventory]"; "[LSS_Inventory].[LSS_InventoryId_s]"; "IMPORT003%"))
	APPEND TO ARRAY:C911($RemoteCountImp004_aL; LSS_ReturnCount("[LSS_Inventory]"; "[LSS_Inventory].[LSS_InventoryId_s]"; "IMPORT004%"))
	
	
	APPEND TO ARRAY:C911($RemoteCountImp001_aL; LSS_ReturnCount("[LSS_Photos]"; "[LSS_Photos].[LSS_PhotoId_s]"; "IMPORT001%"))
	APPEND TO ARRAY:C911($RemoteCountImp002_aL; LSS_ReturnCount("[LSS_Photos]"; "[LSS_Photos].[LSS_PhotoId_s]"; "IMPORT002%"))
	APPEND TO ARRAY:C911($RemoteCountImp003_aL; LSS_ReturnCount("[LSS_Photos]"; "[LSS_Photos].[LSS_PhotoId_s]"; "IMPORT003%"))
	APPEND TO ARRAY:C911($RemoteCountImp004_aL; LSS_ReturnCount("[LSS_Photos]"; "[LSS_Photos].[LSS_PhotoId_s]"; "IMPORT004%"))
	
	APPEND TO ARRAY:C911($RemoteCountImp001_aL; LSS_ReturnCount("[LSS_SignPanel]"; "[LSS_SignPanel].[LSS_SignPanelId_s]"; "IMPORT001%"))
	APPEND TO ARRAY:C911($RemoteCountImp002_aL; LSS_ReturnCount("[LSS_SignPanel]"; "[LSS_SignPanel].[LSS_SignPanelId_s]"; "IMPORT002%"))
	APPEND TO ARRAY:C911($RemoteCountImp003_aL; LSS_ReturnCount("[LSS_SignPanel]"; "[LSS_SignPanel].[LSS_SignPanelId_s]"; "IMPORT003%"))
	APPEND TO ARRAY:C911($RemoteCountImp004_aL; LSS_ReturnCount("[LSS_SignPanel]"; "[LSS_SignPanel].[LSS_SignPanelId_s]"; "IMPORT004%"))
	
	APPEND TO ARRAY:C911($RemoteCountImp001_aL; LSS_ReturnCount("[LSS_TeamMembers]"; "[LSS_TeamMembers].[LSS_InspectionId_s]"; "IMPORT001%"))
	APPEND TO ARRAY:C911($RemoteCountImp002_aL; LSS_ReturnCount("[LSS_TeamMembers]"; "[LSS_TeamMembers].[LSS_InspectionId_s]"; "IMPORT002%"))
	APPEND TO ARRAY:C911($RemoteCountImp003_aL; LSS_ReturnCount("[LSS_TeamMembers]"; "[LSS_TeamMembers].[LSS_InspectionId_s]"; "IMPORT003%"))
	APPEND TO ARRAY:C911($RemoteCountImp004_aL; LSS_ReturnCount("[LSS_TeamMembers]"; "[LSS_TeamMembers].[LSS_InspectionId_s]"; "IMPORT004%"))
	
	
	APPEND TO ARRAY:C911($RemoteCountImp001_aL; LSS_ReturnCount("[LSS_TowerDistance]"; "[LSS_TowerDistance].LSS_TowerDistanceId_s"; "IMPORT001%"))
	APPEND TO ARRAY:C911($RemoteCountImp002_aL; LSS_ReturnCount("[LSS_TowerDistance]"; "[LSS_TowerDistance].LSS_TowerDistanceId_s"; "IMPORT002%"))
	APPEND TO ARRAY:C911($RemoteCountImp003_aL; LSS_ReturnCount("[LSS_TowerDistance]"; "[LSS_TowerDistance].LSS_TowerDistanceId_s"; "IMPORT003%"))
	APPEND TO ARRAY:C911($RemoteCountImp004_aL; LSS_ReturnCount("[LSS_TowerDistance]"; "[LSS_TowerDistance].LSS_TowerDistanceId_s"; "IMPORT004%"))
	
	
	APPEND TO ARRAY:C911($RemoteCountImp001_aL; LSS_ReturnCount("[LSS_UT]"; "[LSS_UT].[LSS_UTId_s]"; "IMPORT001%"))
	APPEND TO ARRAY:C911($RemoteCountImp002_aL; LSS_ReturnCount("[LSS_UT]"; "[LSS_UT].[LSS_UTId_s]"; "IMPORT002%"))
	APPEND TO ARRAY:C911($RemoteCountImp003_aL; LSS_ReturnCount("[LSS_UT]"; "[LSS_UT].[LSS_UTId_s]"; "IMPORT003%"))
	APPEND TO ARRAY:C911($RemoteCountImp004_aL; LSS_ReturnCount("[LSS_UT]"; "[LSS_UT].[LSS_UTId_s]"; "IMPORT004%"))
	
	
	APPEND TO ARRAY:C911($RemoteCountImp001_aL; LSS_ReturnCount("[LSS_UtResult]"; "[LSS_UtResult].[LSS_UTResultId_s]"; "IMPORT001%"))
	APPEND TO ARRAY:C911($RemoteCountImp002_aL; LSS_ReturnCount("[LSS_UtResult]"; "[LSS_UtResult].[LSS_UTResultId_s]"; "IMPORT002%"))
	APPEND TO ARRAY:C911($RemoteCountImp003_aL; LSS_ReturnCount("[LSS_UtResult]"; "[LSS_UtResult].[LSS_UTResultId_s]"; "IMPORT003%"))
	APPEND TO ARRAY:C911($RemoteCountImp004_aL; LSS_ReturnCount("[LSS_UtResult]"; "[LSS_UtResult].[LSS_UTResultId_s]"; "IMPORT004%"))
	
	
	APPEND TO ARRAY:C911($RemoteCountImp001_aL; LSS_ReturnCount("[LSS_VerticalClearance]"; "[LSS_VerticalClearance].[LSS_VerticalClearanceId_s]"; "IMPORT001%"))
	APPEND TO ARRAY:C911($RemoteCountImp002_aL; LSS_ReturnCount("[LSS_VerticalClearance]"; "[LSS_VerticalClearance].[LSS_VerticalClearanceId_s]"; "IMPORT002%"))
	APPEND TO ARRAY:C911($RemoteCountImp003_aL; LSS_ReturnCount("[LSS_VerticalClearance]"; "[LSS_VerticalClearance].[LSS_VerticalClearanceId_s]"; "IMPORT003%"))
	APPEND TO ARRAY:C911($RemoteCountImp004_aL; LSS_ReturnCount("[LSS_VerticalClearance]"; "[LSS_VerticalClearance].[LSS_VerticalClearanceId_s]"; "IMPORT004%"))
	ut_SQLLogout
	
End if 
C_LONGINT:C283($Loop_L)
C_BLOB:C604($Report_blb)
SET BLOB SIZE:C606($Report_blb; 0)

TEXT TO BLOB:C554("Table name"+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(" Local IMPORT001"+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(" Remote IMPORT001"+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(" Difference Local - Remote"+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(" Local IMPORT002"+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(" Remote IMPORT002"+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(" Difference Local - Remote"+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(" Local IMPORT003"+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(" Remote IMPORT003"+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(" Difference Local - Remote"+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(" Local IMPORT004"+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(" Remote IMPORT004"+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
TEXT TO BLOB:C554(" Difference Local - Remote"+Char:C90(Carriage return:K15:38); $Report_blb; Mac text without length:K22:10; *)

C_LONGINT:C283($Difference_L)

For ($Loop_L; 1; Size of array:C274($TableNames_atxt))
	
	TEXT TO BLOB:C554($TableNames_atxt{$Loop_L}+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
	TEXT TO BLOB:C554(String:C10($LocalCountImp001_aL{$Loop_L})+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
	TEXT TO BLOB:C554(String:C10($RemoteCountImp001_aL{$Loop_L})+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
	$Difference_L:=$LocalCountImp001_aL{$Loop_L}-$RemoteCountImp001_aL{$Loop_L}
	TEXT TO BLOB:C554(String:C10($Difference_L)+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
	TEXT TO BLOB:C554(String:C10($LocalCountImp002_aL{$Loop_L})+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
	TEXT TO BLOB:C554(String:C10($RemoteCountImp002_aL{$Loop_L})+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
	$Difference_L:=$LocalCountImp002_aL{$Loop_L}-$RemoteCountImp002_aL{$Loop_L}
	
	TEXT TO BLOB:C554(String:C10($Difference_L)+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
	
	TEXT TO BLOB:C554(String:C10($LocalCountImp003_aL{$Loop_L})+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
	TEXT TO BLOB:C554(String:C10($RemoteCountImp003_aL{$Loop_L})+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
	$Difference_L:=$LocalCountImp003_aL{$Loop_L}-$RemoteCountImp003_aL{$Loop_L}
	
	TEXT TO BLOB:C554(String:C10($Difference_L)+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
	
	TEXT TO BLOB:C554(String:C10($LocalCountImp004_aL{$Loop_L})+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
	TEXT TO BLOB:C554(String:C10($RemoteCountImp004_aL{$Loop_L})+Char:C90(Tab:K15:37); $Report_blb; Mac text without length:K22:10; *)
	$Difference_L:=$LocalCountImp004_aL{$Loop_L}-$RemoteCountImp004_aL{$Loop_L}
	
	TEXT TO BLOB:C554(String:C10($Difference_L)+Char:C90(Carriage return:K15:38); $Report_blb; Mac text without length:K22:10; *)
	
	
End for 
C_TIME:C306($doc_tm)
$doc_tm:=Create document:C266("")
CLOSE DOCUMENT:C267($doc_tm)
BLOB TO DOCUMENT:C526(Document; $Report_blb)


//End Method: LSS_CompareImportTableCounts

