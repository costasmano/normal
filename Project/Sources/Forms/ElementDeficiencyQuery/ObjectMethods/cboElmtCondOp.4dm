If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/11/05, 06:14:05
	// ----------------------------------------------------
	// Method: Object Method: cboElmtCondOp
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/20/11, 10:43:25      ` Type all local variables for v11
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($ConfirmMessage_txt)
		If (Self:C308->=2)
			$ConfirmMessage_txt:=""
		Else 
			Case of 
				: (cboElmtCond{cboElmtCond}="H@")
					$ConfirmMessage_txt:="You can only Choose = when selecting "+cboElmtCond{cboElmtCond}
				: (cboElmtCond{cboElmtCond}="R@")
					$ConfirmMessage_txt:="You can only Choose = when selecting "+cboElmtCond{cboElmtCond}
					
				: (cboElmtCond{cboElmtCond}="X@")
					$ConfirmMessage_txt:="You can only Choose = when selecting "+cboElmtCond{cboElmtCond}
					
				Else 
					$ConfirmMessage_txt:=""
			End case 
		End if 
		If ($ConfirmMessage_txt#"")
			CONFIRM:C162($ConfirmMessage_txt; "Change to ="; "Reset Condition")
			If (OK=1)
				Self:C308->:=2
			Else 
				cboElmtCond:=0
			End if 
		End if 
		
		C_TEXT:C284($Selected_txt)
		$Selected_txt:=Substring:C12(cboElmtCond{cboElmtCond}; 1; 1)
		Case of 
			: (Self:C308->=1)
				vElmtCondOp:=""
			: (Self:C308->=2)
				vElmtCondOp:="="
			: (Self:C308->=3)
				vElmtCondOp:="#"
			: (Self:C308->=4)
				vElmtCondOp:="<"
				If ($Selected_txt="4")
					vElmtCondOp:="<="
					cboElmtCondOp:=5
					REDRAW:C174(vElmtCondOp)
				End if 
			: (Self:C308->=5)
				vElmtCondOp:="<="
			: (Self:C308->=6)
				vElmtCondOp:=">"
				If ($Selected_txt="1")
					vElmtCondOp:=">="
					cboElmtCondOp:=7
					REDRAW:C174(vElmtCondOp)
				End if 
			: (Self:C308->=7)
				vElmtCondOp:=">="
		End case 
End case 

If (vElmtCondOp="=")
	If (Size of array:C274(cboElmtCond)=8)
	Else 
		APPEND TO ARRAY:C911(cboElmtCond; "H Hidden/inaccessible")
		APPEND TO ARRAY:C911(cboElmtCond; "R Removed")
		APPEND TO ARRAY:C911(cboElmtCond; "X Unknown")
		
	End if 
Else 
	If (Size of array:C274(cboElmtCond)=8)
		DELETE FROM ARRAY:C228(cboElmtCond; 6; 3)
	End if 
	
End if 


OBJECT SET ENABLED:C1123(*; "FindButton"; LSS_EditCheckDefQRY)

