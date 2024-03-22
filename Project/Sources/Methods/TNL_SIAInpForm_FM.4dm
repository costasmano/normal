//%attributes = {"invisible":true}
// Method: TNL_SIAInpForm_FM
// Description
// Method for the Tunnel Inventory Input Form
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 04/12/13, 12:42:20
	// ----------------------------------------------------
	// First Release
	Mods_2013_04
	// Modified by: Costas Manousakis-(Designer)-(11/8/13 12:55:37)
	Mods_2013_11
	//  `Added code to catch changes in the  [Bridge MHD NBIS] table
	// Modified by: Costas Manousakis-(Designer)-(11/13/13 14:39:00)
	Mods_2013_11
	//  `if Item 92vb and 93c are 'blank' hide that stuff
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Data Change:K2:15)
		C_LONGINT:C283($TunnelFlds_L; $FldLoop_L; $TunnelTbl_L)
		$TunnelFlds_L:=Get last field number:C255(->[TunnelInfo:151])
		$TunnelTbl_L:=Table:C252(->[TunnelInfo:151])
		C_POINTER:C301($TunnelFld_ptr)
		For ($FldLoop_L; 1; $TunnelFlds_L)
			$TunnelFld_ptr:=Field:C253($TunnelTbl_L; $FldLoop_L)
			If ($TunnelFld_ptr->#Old:C35($TunnelFld_ptr->))
				PushChange(2; $TunnelFld_ptr)
			End if 
		End for 
		
		$TunnelFlds_L:=Get last field number:C255(->[Bridge MHD NBIS:1])
		$TunnelTbl_L:=Table:C252(->[Bridge MHD NBIS:1])
		C_POINTER:C301($TunnelFld_ptr)
		For ($FldLoop_L; 1; $TunnelFlds_L)
			$TunnelFld_ptr:=Field:C253($TunnelTbl_L; $FldLoop_L)
			If ($TunnelFld_ptr->#Old:C35($TunnelFld_ptr->))
				PushChange(1; $TunnelFld_ptr)
			End if 
		End for 
		
	: ($FormEvent_L=On Load:K2:1)
		InitChangeStack(1)  //bridge mhd nbis
		InitChangeStack(2)  //tunnel info
		
		If (Is new record:C668([TunnelInfo:151]))
			[TunnelInfo:151]BIN:1:=[Bridge MHD NBIS:1]BIN:3
			[TunnelInfo:151]CreatedBy_s:18:=<>CurrentUser_Name
			[TunnelInfo:151]CreatedTimeStamp_s:19:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
			PushChange(2; ->[TunnelInfo:151]CreatedBy_s:18)
			PushChange(2; ->[TunnelInfo:151]CreatedTimeStamp_s:19)
		End if 
		
		If (([Bridge MHD NBIS:1]Item92CB:168=0) & ([Bridge MHD NBIS:1]Item93C:171=!00-00-00!))
			OBJECT SET VISIBLE:C603(*; "NBIItem93C@"; False:C215)
		End if 
		
	: ($FormEvent_L=On Validate:K2:3)
		
		If (Modified record:C314([Bridge MHD NBIS:1]))
			[Bridge MHD NBIS:1]Modified By:191:=<>CurrentUser_Name
			[Bridge MHD NBIS:1]DateModified:194:=Current date:C33(*)
			[Bridge MHD NBIS:1]TimeModified:195:=Current time:C178(*)
			PushChange(1; ->[Bridge MHD NBIS:1]Modified By:191)
			PushChange(1; ->[Bridge MHD NBIS:1]DateModified:194)
			PushChange(1; ->[Bridge MHD NBIS:1]TimeModified:195)
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
			SAVE RECORD:C53([Bridge MHD NBIS:1])
		End if 
		
		If (Is new record:C668([TunnelInfo:151]))
			LogNewRecord(->[TunnelInfo:151]BIN:1; ->[TunnelInfo:151]BIN:1; ->[TunnelInfo:151]BIN:1; 0; "")
		End if 
		
		If (Modified record:C314([TunnelInfo:151]))
			[TunnelInfo:151]ModifiedBy_s:20:=<>CurrentUser_Name
			[TunnelInfo:151]ModifiedTimeStamp_s:21:=FN_Date2DateTime(Current date:C33(*); Current time:C178(*))
			PushChange(2; ->[TunnelInfo:151]ModifiedBy_s:20)
			PushChange(2; ->[TunnelInfo:151]ModifiedTimeStamp_s:21)
			FlushGrpChgs(2; ->[TunnelInfo:151]BIN:1; ->[TunnelInfo:151]BIN:1; ->[TunnelInfo:151]BIN:1; 0)
			SAVE RECORD:C53([TunnelInfo:151])
		End if 
		ACCEPT:C269
		
	: ($FormEvent_L=On Unload:K2:2)
		
End case 