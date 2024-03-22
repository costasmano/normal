//%attributes = {"invisible":true}
If (False:C215)
	//G_CBClrPosting
	//method for Clearance posting Check Box in Inspection forms.
	//Oct-2003  v4.0
End if 

C_BOOLEAN:C305($1; $vbNotPosted)
$vbNotPosted:=$1
If ($vbNotPosted)
	[Inspections:27]ClrPosting:49:=False:C215
	PushChange(1; ->[Inspections:27]ClrPosting:49)
	If ([Inspections:27]NEClrPostedFT:52#0)
		[Inspections:27]NEClrPostedFT:52:=0
		PushChange(1; ->[Inspections:27]NEClrPostedFT:52)
	End if 
	If ([Inspections:27]NEClrPostedIN:53#0)
		[Inspections:27]NEClrPostedIN:53:=0
		PushChange(1; ->[Inspections:27]NEClrPostedIN:53)
	End if 
	If ([Inspections:27]SWClrPostedFT:162#0)
		[Inspections:27]SWClrPostedFT:162:=0
		PushChange(1; ->[Inspections:27]SWClrPostedFT:162)
	End if 
	If ([Inspections:27]SWClrPostedIN:163#0)
		[Inspections:27]SWClrPostedIN:163:=0
		PushChange(1; ->[Inspections:27]SWClrPostedIN:163)
	End if 
	If ([Inspections:27]BrClrSignsNE:54#"N")
		[Inspections:27]BrClrSignsNE:54:="N"
		PushChange(1; ->[Inspections:27]BrClrSignsNE:54)
	End if 
	If ([Inspections:27]BrClrSignsSW:55#"N")
		[Inspections:27]BrClrSignsSW:55:="N"
		PushChange(1; ->[Inspections:27]BrClrSignsSW:55)
	End if 
	If ([Inspections:27]AdClrSignNE:56#"N")
		[Inspections:27]AdClrSignNE:56:="N"
		PushChange(1; ->[Inspections:27]AdClrSignNE:56)
	End if 
	If ([Inspections:27]AdClrSignSW:57#"N")
		[Inspections:27]AdClrSignSW:57:="N"
		PushChange(1; ->[Inspections:27]AdClrSignSW:57)
	End if 
	If ([Inspections:27]BrClrSignNELeg:58#0)
		[Inspections:27]BrClrSignNELeg:58:=0
		PushChange(1; ->[Inspections:27]BrClrSignNELeg:58)
	End if 
	If ([Inspections:27]BrClrSignNEVis:59#0)
		[Inspections:27]BrClrSignNEVis:59:=0
		PushChange(1; ->[Inspections:27]BrClrSignNEVis:59)
	End if 
	If ([Inspections:27]BrClrSignSWLeg:60#0)
		[Inspections:27]BrClrSignSWLeg:60:=0
		PushChange(1; ->[Inspections:27]BrClrSignSWLeg:60)
	End if 
	If ([Inspections:27]BrClrSignSWVis:61#0)
		[Inspections:27]BrClrSignSWVis:61:=0
		PushChange(1; ->[Inspections:27]BrClrSignSWVis:61)
	End if 
	If ([Inspections:27]AdClrSignNELeg:62#0)
		[Inspections:27]AdClrSignNELeg:62:=0
		PushChange(1; ->[Inspections:27]AdClrSignNELeg:62)
	End if 
	If ([Inspections:27]AdClrSignNEVis:63#0)
		[Inspections:27]AdClrSignNEVis:63:=0
		PushChange(1; ->[Inspections:27]AdClrSignNEVis:63)
	End if 
	If ([Inspections:27]AdClrSignSWLeg:64#0)
		[Inspections:27]AdClrSignSWLeg:64:=0
		PushChange(1; ->[Inspections:27]AdClrSignSWLeg:64)
	End if 
	If ([Inspections:27]AdClrSignSWVis:65#0)
		[Inspections:27]AdClrSignSWVis:65:=0
		PushChange(1; ->[Inspections:27]AdClrSignSWVis:65)
	End if 
	//lock fields
	OBJECT SET ENTERABLE:C238(*; "DE Clr@"; False:C215)
	OBJECT SET RGB COLORS:C628(*; "DE Clr@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Clr@"; <>Color_Not_Editable)
	
Else 
	[Inspections:27]ClrPosting:49:=True:C214
	PushChange(1; ->[Inspections:27]ClrPosting:49)
	//lock fields
	OBJECT SET ENTERABLE:C238(*; "DE Clr@"; True:C214)
	OBJECT SET RGB COLORS:C628(*; "DE Clr@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Clr@"; <>Color_Editable)
End if 