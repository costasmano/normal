//%attributes = {"invisible":true}
//Method: SIA_PrintSecondary
//Description
// print all secondary records listed. used in the Bridge Input form - secondary records page
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/27/14, 16:27:55
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//

If (Records in selection:C76([NBIS Secondary:3])>0)
	C_BOOLEAN:C305($ROStatus_b)
	$ROStatus_b:=Read only state:C362([NBIS Secondary:3])
	
	If (Not:C34($ROStatus_b))
		READ ONLY:C145([NBIS Secondary:3])
	End if 
	PRINT SETTINGS:C106
	
	FIRST RECORD:C50([NBIS Secondary:3])
	While (Not:C34(End selection:C36([NBIS Secondary:3])))
		C_LONGINT:C283($points_L)
		$points_L:=Print form:C5([NBIS Secondary:3]; "print")
		If (Selected record number:C246([NBIS Secondary:3])=Records in selection:C76([NBIS Secondary:3]))
			PAGE BREAK:C6
		Else 
			
			PAGE BREAK:C6(>)
		End if 
		NEXT RECORD:C51([NBIS Secondary:3])
	End while 
	
	If (Not:C34($ROStatus_b))
		READ WRITE:C146([NBIS Secondary:3])
	End if 
	
End if 

//End SIA_PrintSecondary