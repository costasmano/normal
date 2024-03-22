If (False:C215)
	Mods_2011_06  // CJ Miller`06/20/11, 10:46:47      ` Type all local variables for v11
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($vlElmtID; $vlCatID; $maxCs; $OldCs; $i)
		$vlElmtID:=cboPontisElemID{cboPontisElem}
		READ ONLY:C145([BMS Elements:47])
		READ ONLY:C145([BMS Categories:49])
		QUERY:C277([BMS Elements:47]; [BMS Elements:47]Element ID:1=$vlElmtID)
		$vlCatID:=[BMS Elements:47]Category ID:8
		QUERY:C277([BMS Categories:49]; [BMS Categories:49]Category ID:1=$vlCatID)
		$maxCs:=[BMS Categories:49]Num of CSs:7
		If ($maxCs#Size of array:C274(cboElmtState))
			$OldCS:=cboElmtState
			ARRAY TEXT:C222(cboElmtState; $maxCs)
			C_LONGINT:C283($i)
			For ($i; 1; $maxCs)
				cboElmtState{$i}:="State "+String:C10($i)
			End for 
			If ($OldCS>$maxCs)
				$OldCs:=0
			End if 
			cboElmtState:=$OldCs
		End if 
		If ([BMS Categories:49]Record as Each:6)
			cbElmtQty:=0
			cboElmtQtyOp:=0
			vrSearchElmtQty:=-1
			OBJECT SET ENABLED:C1123(cbElmtQty; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(cboElmtQtyOp; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENTERABLE:C238(vrSearchElmtQty; False:C215)
		Else 
			If (cbElmtQty=0)
				OBJECT SET ENABLED:C1123(cbElmtQty; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			End if 
			
		End if 
		
		READ WRITE:C146([BMS Elements:47])
		READ WRITE:C146([BMS Categories:49])
		
End case 