//%attributes = {"invisible":true}
//G_CBWeightPosting
//method for Weight posting Check Box in Inspection forms.
//Also used in Checkdependency method.
// $1 : $notPosted_b 
If (False:C215)
	//Sep-2003  v3.3f3
	Mods_2018_10  //Add code and fields to allow for entry and reporting of single posting
	//Modified by: Chuck Miller (10/18/18 14:59:31)
End if 

C_BOOLEAN:C305($1; $vbNotPosted)
$vbNotPosted:=$1
If ($vbNotPosted)
	
	[Inspections:27]WeightPosting:30:=False:C215
	PushChange(1; ->[Inspections:27]WeightPosting:30)
	If ([Inspections:27]ActualPostH:26#0)
		[Inspections:27]ActualPostH:26:=0
		PushChange(1; ->[Inspections:27]ActualPostH:26)
	End if 
	If ([Inspections:27]ActualPost3:27#0)
		[Inspections:27]ActualPost3:27:=0
		PushChange(1; ->[Inspections:27]ActualPost3:27)
	End if 
	If ([Inspections:27]ActualPost3S2:28#0)
		[Inspections:27]ActualPost3S2:28:=0
		PushChange(1; ->[Inspections:27]ActualPost3S2:28)
	End if 
	If ([Inspections:27]ActualPostSgl:29#0)
		[Inspections:27]ActualPostSgl:29:=0
		PushChange(1; ->[Inspections:27]ActualPostSgl:29)
	End if 
	If ([Inspections:27]BrPostSignsNE:37#"N")
		[Inspections:27]BrPostSignsNE:37:="N"
		PushChange(1; ->[Inspections:27]BrPostSignsNE:37)
	End if 
	If ([Inspections:27]BrPostSignsSW:38#"N")
		[Inspections:27]BrPostSignsSW:38:="N"
		PushChange(1; ->[Inspections:27]BrPostSignsSW:38)
	End if 
	If ([Inspections:27]AdPostSignNE:39#"N")
		[Inspections:27]AdPostSignNE:39:="N"
		PushChange(1; ->[Inspections:27]AdPostSignNE:39)
	End if 
	If ([Inspections:27]AdPostSignSW:40#"N")
		[Inspections:27]AdPostSignSW:40:="N"
		PushChange(1; ->[Inspections:27]AdPostSignSW:40)
	End if 
	If ([Inspections:27]BrPostNELeg:41#0)
		[Inspections:27]BrPostNELeg:41:=0
		PushChange(1; ->[Inspections:27]BrPostNELeg:41)
	End if 
	If ([Inspections:27]BrPostNEVis:42#0)
		[Inspections:27]BrPostNEVis:42:=0
		PushChange(1; ->[Inspections:27]BrPostNEVis:42)
	End if 
	If ([Inspections:27]BrPostSWLeg:43#0)
		[Inspections:27]BrPostSWLeg:43:=0
		PushChange(1; ->[Inspections:27]BrPostSWLeg:43)
	End if 
	If ([Inspections:27]BrPostSWVis:44#0)
		[Inspections:27]BrPostSWVis:44:=0
		PushChange(1; ->[Inspections:27]BrPostSWVis:44)
	End if 
	If ([Inspections:27]AdPostNELeg:45#0)
		[Inspections:27]AdPostNELeg:45:=0
		PushChange(1; ->[Inspections:27]AdPostNELeg:45)
	End if 
	If ([Inspections:27]AdPostNEVis:46#0)
		[Inspections:27]AdPostNEVis:46:=0
		PushChange(1; ->[Inspections:27]AdPostNEVis:46)
	End if 
	If ([Inspections:27]AdPostSWLeg:47#0)
		[Inspections:27]AdPostSWLeg:47:=0
		PushChange(1; ->[Inspections:27]AdPostSWLeg:47)
	End if 
	If ([Inspections:27]AdPostSWVis:48#0)
		[Inspections:27]AdPostSWVis:48:=0
		PushChange(1; ->[Inspections:27]AdPostSWVis:48)
	End if 
	If ([Inspections:27]RecomPostingSgl:34#0)
		[Inspections:27]RecomPostingSgl:34:=0
		PushChange(1; ->[Inspections:27]RecomPostingSgl:34)
	End if 
	
	//lock elements
	OBJECT SET ENTERABLE:C238(*; "DE Wt@"; False:C215)
	OBJECT SET RGB COLORS:C628(*; "DE Wt@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Wt@"; <>Color_Not_Editable)
Else 
	[Inspections:27]WeightPosting:30:=True:C214
	PushChange(1; ->[Inspections:27]WeightPosting:30)
	[Inspections:27]ActualPostH:26:=[Bridge MHD NBIS:1]Posting2Axle:9
	PushChange(1; ->[Inspections:27]ActualPostH:26)
	[Inspections:27]ActualPost3:27:=[Bridge MHD NBIS:1]Posting3Axle:10
	PushChange(1; ->[Inspections:27]ActualPost3:27)
	[Inspections:27]ActualPost3S2:28:=[Bridge MHD NBIS:1]Posting5Axle:11
	PushChange(1; ->[Inspections:27]ActualPost3S2:28)
	
	If ([Bridge MHD NBIS:1]PostingSingle:231>0)
		[Inspections:27]ActualPostSgl:29:=[Bridge MHD NBIS:1]PostingSingle:231
	Else 
		If (([Bridge MHD NBIS:1]Posting2Axle:9=[Bridge MHD NBIS:1]Posting3Axle:10) & ([Bridge MHD NBIS:1]Posting2Axle:9=[Bridge MHD NBIS:1]Posting5Axle:11))
			[Inspections:27]ActualPostSgl:29:=[Bridge MHD NBIS:1]Posting2Axle:9
		Else 
			[Inspections:27]ActualPostSgl:29:=0
		End if 
	End if 
	PushChange(1; ->[Inspections:27]ActualPostSgl:29)
	//unlock fields
	OBJECT SET ENTERABLE:C238(*; "DE Wt@"; True:C214)
	OBJECT SET RGB COLORS:C628(*; "DE Wt@"; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(*; "DE Wt@"; <>Color_Editable)
End if 