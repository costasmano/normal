//[Inspections];"Inspection Form"
//CBCldUnderConstruction

If (CBCldUnderConstruction=1)
	[Inspections:27]Cld_UnderConstruction:195:=True:C214
	PushChange(1; ->[Inspections:27]Cld_UnderConstruction:195)
	//unlock fields
	If (blnDBIE=True:C214)
		OBJECT SET ENTERABLE:C238(*; "DBIE Cld @"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "DBIE Cld @"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DBIE Cld @"; <>Color_Editable)
	End if 
Else 
	[Inspections:27]Cld_UnderConstruction:195:=False:C215
	[Inspections:27]Cld_Contract_Number:190:=""
	[Inspections:27]Cld_Amount:187:=0
	[Inspections:27]Cld_Completion_Date:188:=!00-00-00!
	[Inspections:27]Cld_Contractor:189:=""
	[Inspections:27]Cld_Resident_Engineer:192:=""
	[Inspections:27]Cld_Scope_of_Work:193:=""
	[Inspections:27]Cld_Remarks:191:=""
	PushChange(1; ->[Inspections:27]Cld_UnderConstruction:195)
	PushChange(1; ->[Inspections:27]Cld_Contract_Number:190)
	PushChange(1; ->[Inspections:27]Cld_Amount:187)
	PushChange(1; ->[Inspections:27]Cld_Completion_Date:188)
	PushChange(1; ->[Inspections:27]Cld_Contractor:189)
	PushChange(1; ->[Inspections:27]Cld_Resident_Engineer:192)
	PushChange(1; ->[Inspections:27]Cld_Scope_of_Work:193)
	PushChange(1; ->[Inspections:27]Cld_Remarks:191)
	//lock fields
	OBJECT SET ENTERABLE:C238(*; "DBIE Cld @"; False:C215)
	OBJECT SET RGB COLORS:C628(*; "DBIE Cld @"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DBIE Cld @"; <>Color_Not_Editable)
End if 