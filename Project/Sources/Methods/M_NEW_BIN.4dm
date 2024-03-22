//%attributes = {"invisible":true}
If (False:C215)
	//GP M_NEW_BIN
	//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
	//modified: 1/6/98 by Albert Leung
	//Create a new BIN record.
	
	Mods_2004_CM11
	// Modified by: costasmanousakis-(Designer)-(6/25/08 13:30:57)
	Mods_2008_CM_5404
	//Add new record to the current list- apply any sort
	Mods_2013_01  //r004 ` Add use of [BridgeInfoLink] table
	//Modified by: Charles Miller (1/17/13 14:55:20)
	// Modified by: Costas Manousakis-(Designer)-(5/12/20 17:26:16)
	Mods_2020_05
	//  `modified code to fix the problem where after getting back to the listbox display,
	//  `doubleclicking on a line was not working correctly and the UserSet set was not maintained
End if 
CREATE SET:C116([Bridge MHD NBIS:1]; "BeginBridgeSet")
COPY SET:C600("UserSet"; "BackupUserSet")
C_LONGINT:C283(vBIN_Dec)  //The decimal value of the BIN.
C_BOOLEAN:C305(OnServer)

OnServer:=False:C215
C_LONGINT:C283($vlWL; $vlWT; $vlWR; $vlWB; $vlFMw; $vlFMh)
GET WINDOW RECT:C443($vlWL; $vlWT; $vlWR; $vlWB)
FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; "BDEPT Input"; $vlFMw; $vlFMh)
$vlFMw:=$vlFMw+10
$vlFMh:=$vlFMh+10
If (($vlWR-$vlWL)>=$vlFMw)
	$vlFMw:=($vlWR-$vlWL)
End if 
If (($vlWB-$vlWT)>=$vlFMh)
	$vlFMh:=($vlWB-$vlWT)
End if 
SET WINDOW RECT:C444($vlWL; $vlWT; $vlWL+$vlFMw; $vlWT+$vlFMh)
FORM SET INPUT:C55([Bridge MHD NBIS:1]; "BDEPT Input")
ADD RECORD:C56([Bridge MHD NBIS:1])
REDRAW WINDOW:C456
FORM SET INPUT:C55(pFile->; DefInLay)

If (OK=1)
	ADD TO SET:C119([Bridge MHD NBIS:1]; "BeginBridgeSet")
	//need to update the search arrays for the search tool
	Bridge_FileBridgeSearchArray
	
	InitChangeStack(2)
	
	CREATE RECORD:C68([BridgeInfoLink:149])
	[BridgeInfoLink:149]BIN:1:=[Bridge MHD NBIS:1]BIN:3
	SAVE RECORD:C53([BridgeInfoLink:149])
	C_POINTER:C301($Field_ptr)
	LogNewRecord(->[BridgeInfoLink:149]BIN:1; ->[BridgeInfoLink:149]BIN:1; ->[BridgeInfoLink:149]BIN:1; 0; "BIN")
	C_LONGINT:C283($Loop_l; $TableNumber_l)
	$TableNumber_l:=Table:C252(->[BridgeInfoLink:149])
	
	For ($Loop_l; 2; Get last field number:C255($TableNumber_l))
		If (Is field number valid:C1000($TableNumber_l; $Loop_l))
			$Field_ptr:=Field:C253($TableNumber_l; $Loop_l)
			$Field_ptr->:=[BridgeInfoLink:149]BIN:1
			
			PushChange(2; $Field_ptr)
		End if 
		
		
	End for 
	FlushGrpChgs(2; ->[BridgeInfoLink:149]BIN:1; ->[BridgeInfoLink:149]BIN:1; ->[BridgeInfoLink:149]BIN:1; 0)
	SAVE RECORD:C53([BridgeInfoLink:149])
	UNLOAD RECORD:C212([BridgeInfoLink:149])
	READ ONLY:C145([BridgeInfoLink:149])
	
End if 

SET WINDOW RECT:C444($vlWL; $vlWT; $vlWR; $vlWB)

USE SET:C118("BeginBridgeSet")
CLEAR SET:C117("BeginBridgeSet")
COPY SET:C600("BackupUserSet"; "UserSet")
CLEAR SET:C117("BackupUserSet")

C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 

RegionTitle