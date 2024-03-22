//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): root
	// User name (4D): Designer
	// Date and time: 04/29/05, 16:17:08
	// ----------------------------------------------------
	// Method: Temp_checkCondUQ
	// Description
	//runs on current selection of cond units 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
If (Current user:C182#"Designer")
	ABORT:C156
End if 
C_LONGINT:C283($i)
SET CURSOR:C469(4)
READ ONLY:C145(*)
C_TEXT:C284($msg)
ut_StartMessage(3; "CondUnitQCheck")
CREATE SET:C116([Cond Units:45]; "STARTCONDUNITSSET")
QUERY SELECTION:C341([Cond Units:45]; [Cond Units:45]Total Quantity:5<=0)
For ($i; 1; Records in selection:C76([Cond Units:45]))
	GOTO SELECTED RECORD:C245([Cond Units:45]; $i)
	LOAD RECORD:C52([Cond Units:45])
	RELATE ONE:C42([Cond Units:45]Inspection ID:2)
	$msg:="Q :"+String:C10([Cond Units:45]Total Quantity:5)+" - Elmt : "+String:C10([Cond Units:45]Element ID:3)+" Env :"+String:C10([Cond Units:45]Environment:4)
	$msg:=$msg+" -Date:"+String:C10([BMS Inspections:44]Insp Date:4)+"- BIN:"+[BMS Inspections:44]BIN:2+Char:C90(13)
	UNLOAD RECORD:C212([Cond Units:45])
	ut_Message($msg)
End for 
USE SET:C118("STARTCONDUNITSSET")

USE SET:C118("STARTCONDUNITSSET")
CLEAR SET:C117("STARTCONDUNITSSET")
ut_CloseMessage
SET CURSOR:C469(0)
READ WRITE:C146(*)