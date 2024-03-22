//[Inspections];"Inspection Form"
//CBClrPost

If (CBCldPost=1)
	[Inspections:27]ClosedSigns:118:=False:C215
	[Inspections:27]BrCldSignsNE:119:="N"
	[Inspections:27]BrCldSignsSW:120:="N"
	[Inspections:27]AdCldSignsNE:121:="N"
	[Inspections:27]AdCldSignsSW:122:="N"
	[Inspections:27]BrCldSignNELeg:123:=0
	[Inspections:27]BrCldSignNEVis:124:=0
	[Inspections:27]BrCldSignSWLeg:125:=0
	[Inspections:27]BrCldSignSWVis:126:=0
	[Inspections:27]AdCldSignNELeg:127:=0
	[Inspections:27]AdCldSignNEVis:128:=0
	[Inspections:27]AdCldSignSWLeg:129:=0
	[Inspections:27]AdCldSignSWVis:130:=0
	PushChange(1; ->[Inspections:27]ClosedSigns:118)
	PushChange(1; ->[Inspections:27]BrCldSignsNE:119)
	PushChange(1; ->[Inspections:27]BrCldSignsSW:120)
	PushChange(1; ->[Inspections:27]AdCldSignsNE:121)
	PushChange(1; ->[Inspections:27]AdCldSignsSW:122)
	PushChange(1; ->[Inspections:27]BrCldSignNELeg:123)
	PushChange(1; ->[Inspections:27]BrCldSignNEVis:124)
	PushChange(1; ->[Inspections:27]BrCldSignSWLeg:125)
	PushChange(1; ->[Inspections:27]BrCldSignSWVis:126)
	PushChange(1; ->[Inspections:27]AdCldSignNELeg:127)
	PushChange(1; ->[Inspections:27]AdCldSignNEVis:128)
	PushChange(1; ->[Inspections:27]AdCldSignSWLeg:129)
	PushChange(1; ->[Inspections:27]AdCldSignSWVis:130)
	//lock fields
	OBJECT SET ENTERABLE:C238(*; "DE Sgn@"; False:C215)
	OBJECT SET RGB COLORS:C628(*; "DE Sgn@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Sgn@"; <>Color_Not_Editable)
Else 
	[Inspections:27]ClosedSigns:118:=True:C214
	PushChange(1; ->[Inspections:27]ClosedSigns:118)
	//unlock fields
	OBJECT SET ENTERABLE:C238(*; "DE Sgn@"; True:C214)
	OBJECT SET RGB COLORS:C628(*; "DE Sgn@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Sgn@"; <>Color_Editable)
End if 