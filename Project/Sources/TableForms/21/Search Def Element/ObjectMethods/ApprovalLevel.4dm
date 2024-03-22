If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23 18:47:13)
	Mods_2021_12_bug
	//  `mark that the elements need to be filtered only if there is a change in the selector
End if 
C_BOOLEAN:C305($compl; $DbieAppr; $FinalAppr; $change; vbAnyCompleted; vbAnyApprvDBIE; vInspApproved)
C_OBJECT:C1216(SRC_BridgeElemParams_o)

Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=2
		Self:C308->{0}:=Self:C308->{2}
		OB SET:C1220(SRC_BridgeElemParams_o; "ElementsFiltered"; False:C215)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($pos)
		$pos:=Self:C308->
		If (Self:C308->{0}#Self:C308->{$pos})
			//changed the selector
			Self:C308->{0}:=Self:C308->{$pos}
			vbAnyCompleted:=(Self:C308->=1)
			vbAnyApprvDBIE:=(Self:C308->=2)
			vInspApproved:=(Self:C308->=3)
			OB SET:C1220(SRC_BridgeElemParams_o; "ElementsFiltered"; False:C215)
		End if 
		
End case 