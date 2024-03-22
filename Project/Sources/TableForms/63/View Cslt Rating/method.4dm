If (False:C215)
	//Form method [Conslt Rating];"View Cslt Rating"
	
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 11:41:38)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(10/2/2006 14:18:35)
	Mods_2006_CM06
	// Modified by: costasmanousakis-(Designer)-(3/28/2007 12:53:30)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(5/17/2007 10:40:29)
	Mods_2007_CM10
	// Modified by: costasmanousakis-(Designer)-(6/19/2007 12:48:58)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(6/9/10 09:36:37)
	Mods_2010_06
	//  `added code to adjust window size when closing detail
	//  `Also added color bars at the header and footer
	// Modified by: costasmanousakis-(Designer)-(9/17/10 10:11:49)
	Mods_2010_09
	//  `Added column for Contract Type
End if 
C_TEXT:C284(BackGroundRect)
OBJECT SET RGB COLORS:C628(*; "@BackGroundRect@"; Col_paletteToRGB(Abs:C99(-(White:K11:1+(256*White:K11:1)))%256); Col_paletteToRGB(Abs:C99(-(White:K11:1+(256*White:K11:1)))\256))  // **Replaced o OBJECT SET COLOR(*; "@BackGroundRect@"; -(White+(256*White)))
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		C_TEXT:C284(vCRtgSource; vFullAssignNo; vCRtgSubmStat)  // Command Replaced was o_C_STRING length was 15
		
		Case of 
			: ([Conslt Rating:63]CRtgSource:47="In-House Design")
				vCRtgSource:="In-House"
			: ([Conslt Rating:63]CRtgSource:47="Design Consultant")
				vCRtgSource:="Design C."
			: ([Conslt Rating:63]CRtgSource:47="Rating Consultant")
				vCRtgSource:="Rating C."
			: ([Conslt Rating:63]CRtgSource:47="Inspection Consultant")
				vCRtgSource:="Insp C."
			: ([Conslt Rating:63]CRtgSource:47="Town/City/Owner")
				vCRtgSource:="Town/Owner"
			Else 
				vCRtgSource:=""
		End case 
		vFullAssignNo:=String:C10([Conslt Rating:63]AssignNoRat:12)
		If (Replace string:C233([Conslt Rating:63]AssignPhase:51; " "; "")#"")
			vFullAssignNo:=vFullAssignNo+"-"+[Conslt Rating:63]AssignPhase:51
		End if 
		vCRtgSubmStat:=Substring:C12(CRTG_RatingStatus; 1; 15)
		If ((User in group:C338(Current user:C182; "Bridge Insp Engineer")) | (Current user:C182="Designer"))
			BackGroundRect:=""
			Case of 
				: ([Conslt Rating:63]PriorityColorFlag:3="GREEN")
					OBJECT SET RGB COLORS:C628(*; "@BackGroundRect@"; Col_paletteToRGB(Abs:C99(-((11*16+3)+(256*(11*16+3))))%256); Col_paletteToRGB(Abs:C99(-((11*16+3)+(256*(11*16+3))))\256))  // **Replaced o OBJECT SET COLOR(*; "@BackGroundRect@"; -((11*16+3)+(256*(11*16+3))))
				: ([Conslt Rating:63]PriorityColorFlag:3="YELLOW")
					OBJECT SET RGB COLORS:C628(*; "@BackGroundRect@"; Col_paletteToRGB(Abs:C99(-(Yellow:K11:2+(256*Yellow:K11:2)))%256); Col_paletteToRGB(Abs:C99(-(Yellow:K11:2+(256*Yellow:K11:2)))\256))  // **Replaced o OBJECT SET COLOR(*; "@BackGroundRect@"; -(Yellow+(256*Yellow)))
				: ([Conslt Rating:63]PriorityColorFlag:3="RED")
					OBJECT SET RGB COLORS:C628(*; "@BackGroundRect@"; Col_paletteToRGB(Abs:C99(-((8*16+3)+(256*(8*16+3))))%256); Col_paletteToRGB(Abs:C99(-((8*16+3)+(256*(8*16+3))))\256))  // **Replaced o OBJECT SET COLOR(*; "@BackGroundRect@"; -((8*16+3)+(256*(8*16+3))))
				: ([Conslt Rating:63]PriorityColorFlag:3="ORANGE")
					OBJECT SET RGB COLORS:C628(*; "@BackGroundRect@"; Col_paletteToRGB(Abs:C99(-((2*16+9)+(256*(2*16+9))))%256); Col_paletteToRGB(Abs:C99(-((2*16+9)+(256*(2*16+9))))\256))  // **Replaced o OBJECT SET COLOR(*; "@BackGroundRect@"; -((2*16+9)+(256*(2*16+9))))
				Else 
					OBJECT SET RGB COLORS:C628(*; "@BackGroundRect@"; Col_paletteToRGB(Abs:C99(-(White:K11:1+(256*White:K11:1)))%256); Col_paletteToRGB(Abs:C99(-(White:K11:1+(256*White:K11:1)))\256))  // **Replaced o OBJECT SET COLOR(*; "@BackGroundRect@"; -(White+(256*White)))
			End case 
		Else 
		End if 
		
	: (Form event code:C388=On Open Detail:K2:23)
		READ ONLY:C145([Bridge MHD NBIS:1])
	: (Form event code:C388=On Close Detail:K2:24)
		C_LONGINT:C283($CurrL_L; $CurrT_L; $CurrR_L; $CurrB_L; $FormW_L; $FormH_L; $CurrW_L; $CurrH_L)
		GET WINDOW RECT:C443($CurrL_L; $CurrT_L; $CurrR_L; $CurrB_L)
		$CurrW_L:=$CurrR_L-$CurrL_L
		$CurrH_L:=$CurrB_L-$CurrT_L
		C_TEXT:C284($CurrForm_txt)
		$CurrForm_txt:=Current method name:C684
		$CurrForm_txt:=Replace string:C233($CurrForm_txt; Table name:C256(Current form table:C627); "")
		$CurrForm_txt:=Substring:C12($CurrForm_txt; 4)
		FORM GET PROPERTIES:C674(Current form table:C627->; $CurrForm_txt; $FormW_L; $FormH_L)
		C_BOOLEAN:C305($Resize_b)
		$Resize_b:=($CurrW_L<$FormW_L)
		If ($Resize_b)
			If ($CurrW_L<$FormW_L)
				$CurrR_L:=$FormW_L-$CurrW_L
			Else 
				$CurrR_L:=0
			End if 
			
			RESIZE FORM WINDOW:C890($CurrR_L; 0)
		End if 
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		//REDRAW(◊asWindows)
End case 