If (False:C215)
	//Form Method: [Bridge Design]Bridge Design In 
	
	//declare drop down arrays for compiling
	ARRAY TEXT:C222(cboProjectType; 0)
	ARRAY TEXT:C222(cboAbutment; 0)
	ARRAY TEXT:C222(cboPier; 0)
	ARRAY TEXT:C222(cboBearing; 0)
	ARRAY TEXT:C222(cboBarrier; 0)
	ARRAY TEXT:C222(cboScreenType; 0)
	ARRAY TEXT:C222(cboJoint; 0)
	ARRAY TEXT:C222(cboStageConstruct; 0)
	ARRAY TEXT:C222(cboPreEngr; 0)
	ARRAY TEXT:C222(cboSeismic; 0)
	
	Mods_2004_CM12
	
	Mods_2007_CM08
	// Modified by: costasmanousakis-(Designer)-(5/1/2007 08:30:53)
	Mods_2007_CM09
	// Modified by: costasmanousakis-(Designer)-(10/7/08 11:53:08)
	Mods_2008_CM_5404  // ("ACCESS")
	// Modified by: costasmanousakis-(Designer)-(9/13/10 13:35:36)
	Mods_2010_09
	//  `Added ProjectInfo Buttons
	// Modified by: Costas Manousakis-(Designer)-(5/2/12 16:15:27)
	Mods_2012_05
	//  `Fixed logic in the on load event when new record: added assigning the BIN (not automatic anymore)
	//  `Removed code using the vbNewRec variable.
	//  `Removed code from the bCancel button
	// Modified by: Costas Manousakis-(Designer)-(8/22/13 13:19:52)
	Mods_2013_08
	//  `Load pulldowns from table of lists
	//  `For ProjectInfo button use the projbtn.png in Resources
	// Modified by: Costas Manousakis-(Designer)-(3/30/15 17:06:05)
	Mods_2015_03_bug
	//  `Avoid logging changes for the [Bridge Mhd NBIS] record if the record is locked. 
End if 

C_LONGINT:C283(rdoEnglish)  //Command Replaced was o_C_INTEGER

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		C_BOOLEAN:C305(<>LogBridgeDesign_b)
		<>LogBridgeDesign_b:=True:C214
		InitChangeStack(1)  //Bridge Design changes
		InitChangeStack(2)  //[bridge  mhd nbis]changes
		
		TOL_ListToArray("BRDES_Abutment"; ->cboAbutment)
		TOL_ListToArray("BRDES_Pier"; ->cboPier)
		TOL_ListToArray("BRDES_ProjTypes"; ->cboProjectType)
		TOL_ListToArray("BRDES_Bearing"; ->cboBearing)
		TOL_ListToArray("BRDES_Barrier"; ->cboBarrier)
		TOL_ListToArray("BRDES_ScreenType"; ->cboScreenType)
		TOL_ListToArray("BRDES_Joint"; ->cboJoint)
		POPUPMENUC(->cboAbutment; ->cboAbutment; ->[Bridge Design:75]Abutment:8)
		POPUPMENUC(->cboPier; ->cboPier; ->[Bridge Design:75]Pier:15)
		POPUPMENUC(->cboProjectType; ->cboProjectType; ->[Bridge Design:75]ProjectType:7)
		POPUPMENUC(->cboBearing; ->cboBearing; ->[Bridge Design:75]Bearing:19)
		POPUPMENUC(->cboBarrier; ->cboBarrier; ->[Bridge Design:75]Barrier:18)
		POPUPMENUC(->cboScreenType; ->cboScreenType; ->[Bridge Design:75]ScreenType:21)
		POPUPMENUC(->cboJoint; ->cboJoint; ->[Bridge Design:75]Joint:20)
		
		C_TEXT:C284($CurrentUser_txt)
		$CurrentUser_txt:=Current user:C182
		Case of 
			: ((User in group:C338($CurrentUser_txt; "BridgeDataSheet")) & (Not:C34(User in group:C338($CurrentUser_txt; "ReadOnly"))))
				
				InitChangeStack(1)
				InitChangeStack(2)
				If (Is new record:C668([Bridge Design:75]))
					[Bridge Design:75]BIN:1:=[Bridge MHD NBIS:1]BIN:3
					Inc_Sequence("BrDesign"; ->[Bridge Design:75]BridgeDesignID:35)
					CONFIRM:C162("Select English or Metric Unit"; "English"; "Metric")
					If (Ok=1)
						[Bridge Design:75]MetricUnit:38:=False:C215
						PushChange(1; ->[Bridge Design:75]MetricUnit:38)
						rdoEnglish:=1
					Else 
						[Bridge Design:75]MetricUnit:38:=True:C214
						PushChange(1; ->[Bridge Design:75]MetricUnit:38)
						rdoEnglish:=0
					End if 
					
				End if 
			Else 
				If (Is new record:C668([Bridge Design:75]))
					CANCEL:C270
				End if 
				//Lock Others
				ut_SetEnterable("DE@"; False:C215)
				OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
				OBJECT SET VISIBLE:C603(vbDelete_BrgDes; False:C215)
				
		End case 
		
		RELATE MANY:C262([Bridge Design:75])
		
		sItem54h:=0
		sItem54r:=0
		sItem54n:=0
		CBItem54:=0
		
		tItem55h:=0
		tItem55r:=0
		tItem55n:=0
		CBItem55:=0
		
		uItem56a:=0
		uItem56b:=0
		uItem56c:=0
		uItem56d:=0
		
		If ([Bridge Design:75]MetricUnit:38)
			metric_vLeft:=0
			metric_vRight:=0
			metric_vSpanLength:=0
			metric_vWidth:=0
			metric_vRadius:=0
			metric_vApproach:=0
			metric_vStructLength:=0
			metric_vWidthCurb:=0
			metric_vVertUnderclear:=0
			metric_vLatUnderclearRT:=0
			metric_vLatUnderclearLT:=0
			OBJECT SET VISIBLE:C603(*; "@eng_@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "@metric_@"; True:C214)
			vCostPerArea:="Est. Cost per SQ Meter"
			vSWLeftLabel:="(50) Sidewalk Left"
			vSWRightLabel:="(50) Sidewalk Right "
			vTotalSpanLabel:="(48) Length of Max Span"
			vWidthLabel:="(52) Deck Width Out to Out "
			vRadiusLabel:="Radius/Curved Girder "
			vApproachLabel:="Approach Slab Volume"
			vWidthCurbLabel:="(51) Width Curb to Curb"
			//Data are stored as decimal feet - convert to metric          
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
			
			
			//Unrestricted check box for Item 54
			If ([Bridge Design:75]MinVertUnderclear:45=99.9)
				CBItem54:=1
			End if 
			
			//Check box for Item 55
			If ([Bridge Design:75]MinLatUnderclearRT:46>30)
				CBItem55:=1
			End if 
			
			//radio buttons for Item 56
			Case of 
				: ([Bridge Design:75]MinLatUnderclearLT:47=99.9)
					uItem56a:=1
				: ([Bridge Design:75]MinLatUnderclearLT:47=99.8)
					uItem56b:=1
				: ([Bridge Design:75]MinLatUnderclearLT:47=0)
					uItem56c:=1
				: (([Bridge Design:75]MinLatUnderclearLT:47<99.8) & ([Bridge Design:75]MinLatUnderclearLT:47>0))
					uItem56d:=1
			End case 
			//`````````````````       
		Else 
			//`````````````````                 
			eng_vLeft_ft:=0
			eng_vLeft_in:=0
			eng_vRight_ft:=0
			eng_vRight_in:=0
			eng_vSpan_ft:=0
			eng_vSpan_in:=0
			eng_vWidth_ft:=0
			eng_vWidth_in:=0
			eng_vRadius_ft:=0
			eng_vRadius_in:=0
			eng_vApproach:=0
			eng_vStructLength_ft:=0
			eng_vStructLength_in:=0
			eng_vWidthCurb_ft:=0
			eng_vWidthCurb_in:=0
			eng_vVertUnderclear_ft:=0
			eng_vVertUnderclear_in:=0
			eng_vLatUnderclearRT_ft:=0
			eng_vLatUnderclearRT_in:=0
			eng_vLatUnderclearLT_ft:=0
			eng_vLatUnderclearLT_in:=0
			
			//Unrestricted check box for Item 54
			If ([Bridge Design:75]MinVertUnderclear:45=99.9)
				CBItem54:=1
			End if 
			
			//Check box for Item 55
			//30 meters = 1180.8 inches
			If ([Bridge Design:75]MinLatUnderclearRT:46>1180.8)
				CBItem55:=1
			End if 
			
			//radio buttons for Item 56
			Case of 
				: ([Bridge Design:75]MinLatUnderclearLT:47=99.9)
					uItem56a:=1
				: ([Bridge Design:75]MinLatUnderclearLT:47=99.8)
					uItem56b:=1
				: ([Bridge Design:75]MinLatUnderclearLT:47=0)
					uItem56c:=1
				: (([Bridge Design:75]MinLatUnderclearLT:47<99.8) & ([Bridge Design:75]MinLatUnderclearLT:47>0))
					uItem56d:=1
			End case 
			
			OBJECT SET VISIBLE:C603(*; "@eng_@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "@metric_@"; False:C215)
			vCostPerArea:="Est. Cost per SQ Feet"
			vSWLeftLabel:="(50) Sidewalk Left"
			vSWRightLabel:="(50) Sidewalk Right"
			vTotalSpanLabel:="(48) Length of Max Span"
			vWidthLabel:="(52) Deck Width Out to Out "
			vRadiusLabel:="Radius/Curved Girder"
			vApproachLabel:="Approach Slab Volume"
			vWidthCurbLabel:="(51) Width Curb to Curb"
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
			//`````````````````              
		End if 
		//`````````````````             
		Case of 
			: ([Bridge Design:75]MinVertUcCode:48="H")
				sItem54h:=1
			: ([Bridge Design:75]MinVertUcCode:48="R")
				sItem54r:=1
			: ([Bridge Design:75]MinVertUcCode:48="N")
				sItem54n:=1
		End case 
		
		If ([Bridge Design:75]MinVertUnderclear:45=99.99)
			CBItem54:=1
		End if 
		
		Case of 
			: ([Bridge Design:75]MinLatUcCode:49="H")
				tItem55h:=1
			: ([Bridge Design:75]MinLatUcCode:49="R")
				tItem55r:=1
			: ([Bridge Design:75]MinLatUcCode:49="N")
				tItem55n:=1
		End case 
		
		If ([Bridge Design:75]MinLatUnderclearRT:46=99.99)
			CBItem55:=1
		End if 
		
		Case of 
			: ([Bridge Design:75]MinLatUnderclearLT:47=99.9)
				uItem56a:=1
			: ([Bridge Design:75]MinLatUnderclearLT:47=99.8)
				uItem56b:=1
			: ([Bridge Design:75]MinLatUnderclearLT:47=0)
				uItem56c:=1
			Else 
				uItem56d:=1
		End case 
		
	: (Form event code:C388=On Validate:K2:3)
		
		If ([Bridge MHD NBIS:1]Item8 BridgeCat:207="DES")
			If (Not:C34(Locked:C147([Bridge MHD NBIS:1])))
				SAVE RECORD:C53([Bridge MHD NBIS:1])
				FlushGrpChgs(2; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
			End if 
			
		End if 
		
		If (<>LogBridgeDesign_b)
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge Design:75]BIN:1; ->[Bridge Design:75]BridgeDesignID:35; 1)
		End if 
		
End case 