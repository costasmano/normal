If (False:C215)
	Mods_2005_CM05
	// Modified by: Costas Manousakis-(Designer)-(8/21/12 09:37:52)
	Mods_2012_08
	//  `Reset the display formats for number of spans and skew angle.
	// Modified by: Costas Manousakis-(Designer)-(1/29/20 14:55:31)
	Mods_2020_01_bug
	//  `fixed width of label on district box
	// Modified by: Costas Manousakis-(Designer)-(2021-12-14T00:00:00 11:34:42)
	Mods_2021_12_bug
	//  `adjusted vert size of vars and labels to 11 from 9 for better fit of text
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	
	C_TEXT:C284(vPlansOnFile)
	vPlansOnFile:="NO"
	If ([Bridge Design:75]PlansOnFile:34)
		vPlansOnFile:="YES"
	End if 
	
	G_SIA_BuildTownLine
	
	C_DATE:C307(vDate)
	vDate:=Current date:C33(*)
	
	If ([Bridge Design:75]MetricUnit:38=True:C214)
		OBJECT SET VISIBLE:C603(*; "eng@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "metric@"; True:C214)
		vCostPerArea:="Est. Cost per SQ Meter"
		metric_vLeft:=Round:C94([Bridge Design:75]SidewalkLeft:23*0.3048; 3)
		metric_vRight:=Round:C94([Bridge Design:75]SidewalkRight:24*0.3048; 3)
		metric_vSpanLength:=Round:C94([Bridge Design:75]TotalSpanLength:25*0.3048; 3)
		metric_vWidth:=Round:C94([Bridge Design:75]WideOutToOut:26*0.3048; 3)
		metric_vRadius:=Round:C94([Bridge Design:75]RadiusCurvedGirder:29*0.3048; 3)
		metric_vApproach:=Round:C94([Bridge Design:75]ApproachSlabVolume:32*0.7645549; 3)
		metric_vStructLength:=Round:C94([Bridge Design:75]StructLength:43*0.3048; 3)
		metric_vWidthCurb:=Round:C94([Bridge Design:75]WidthCurbToCurb:44*0.3048; 3)
		metric_vVertUnderclear:=Round:C94([Bridge Design:75]MinVertUnderclear:45*0.3048; 3)
		metric_vLatUnderclearRT:=Round:C94([Bridge Design:75]MinLatUnderclearRT:46*0.3048; 3)
		metric_vLatUnderclearLT:=Round:C94([Bridge Design:75]MinLatUnderclearLT:47*0.3048; 3)
	Else 
		OBJECT SET VISIBLE:C603(*; "eng@"; True:C214)
		OBJECT SET VISIBLE:C603(*; "metric@"; False:C215)
		vCostPerArea:="Est. Cost per SQ Feet"
		eng_vLeft_ft:=Int:C8([Bridge Design:75]SidewalkLeft:23)
		eng_vLeft_in:=Round:C94(Dec:C9([Bridge Design:75]SidewalkLeft:23)*12; 3)
		eng_vRight_ft:=Int:C8([Bridge Design:75]SidewalkRight:24)
		eng_vRight_in:=Round:C94(Dec:C9([Bridge Design:75]SidewalkRight:24)*12; 3)
		eng_vSpan_ft:=Int:C8([Bridge Design:75]TotalSpanLength:25)
		eng_vSpan_in:=Round:C94(Dec:C9([Bridge Design:75]TotalSpanLength:25)*12; 3)
		eng_vWidth_ft:=Int:C8([Bridge Design:75]WideOutToOut:26)
		eng_vWidth_in:=Round:C94(Dec:C9([Bridge Design:75]WideOutToOut:26)*12; 3)
		eng_vRadius_ft:=Int:C8([Bridge Design:75]RadiusCurvedGirder:29)
		eng_vRadius_in:=Round:C94(Dec:C9([Bridge Design:75]RadiusCurvedGirder:29)*12; 3)
		eng_vApproach:=[Bridge Design:75]ApproachSlabVolume:32
		
		eng_vStructLength_ft:=Int:C8([Bridge Design:75]StructLength:43)
		eng_vStructLength_in:=Round:C94(Dec:C9([Bridge Design:75]StructLength:43)*12; 3)
		eng_vWidthCurb_ft:=Int:C8([Bridge Design:75]WidthCurbToCurb:44)
		eng_vWidthCurb_in:=Round:C94(Dec:C9([Bridge Design:75]WidthCurbToCurb:44)*12; 3)
		eng_vVertUnderclear_ft:=Int:C8([Bridge Design:75]MinVertUnderclear:45)
		eng_vVertUnderclear_in:=Round:C94(Dec:C9([Bridge Design:75]MinVertUnderclear:45)*12; 3)
		eng_vLatUnderclearRT_ft:=Int:C8([Bridge Design:75]MinLatUnderclearRT:46)
		eng_vLatUnderclearRT_in:=Round:C94(Dec:C9([Bridge Design:75]MinLatUnderclearRT:46)*12; 3)
		eng_vLatUnderclearLT_ft:=Int:C8([Bridge Design:75]MinLatUnderclearLT:47)
		eng_vLatUnderclearLT_in:=Round:C94(Dec:C9([Bridge Design:75]MinLatUnderclearLT:47)*12; 3)
	End if 
	
	//temporary solution - delete when the Joint size is increased from A(20) to A(40)
	If ([Bridge Design:75]Joint:20="Pavement Sawcut Join")
		vJoint:="Pavement Sawcut Joint"
	Else 
		vJoint:=[Bridge Design:75]Joint:20
	End if 
	
End if 