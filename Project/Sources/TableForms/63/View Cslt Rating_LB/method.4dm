
If (False:C215)
	//Form Method: [Conslt Rating];"View Cslt Rating_LB"
	
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
	Mods_2020_06
	//Modified by: CJ (6/18/20 14:07:25)
	//Move code from single user to this to upgrade to use list boxes
	// Modified by: Costas Manousakis-(Designer)-(2021-10-04T00:00:00 16:43:38)
	Mods_2021_10
	//  `made LB focusable / hide focus rect - enable on resize event on form -on resize redraw the LB 
	// Modified by: Costas Manousakis-(Designer)-(2021-10-14T00:00:00 10:58:04)
	Mods_2021_10
	//  `removed setting of color on the background rect from form method; made form Hor marg 19
End if 

C_LONGINT:C283($formEvent_L)
$formEvent_L:=Form event code:C388

Case of 
	: ($formEvent_L=On Display Detail:K2:22)
		C_TEXT:C284(vCRtgSource; vFullAssignNo; vCRtgSubmStat)  // Command Replaced was o _ C_STRING length was 15
		
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
		LB_Detail1_txt:=[Conslt Rating:63]ContractNoRat:14+" "+vFullAssignNo
		vCRtgSubmStat:=Substring:C12(CRTG_RatingStatus; 1; 15)
		
	: ($formEvent_L=On Open Detail:K2:23)
		READ ONLY:C145([Bridge MHD NBIS:1])
	: ($formEvent_L=On Close Detail:K2:24)
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
		
	: ($formEvent_L=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
		
	: ($formEvent_L=On Resize:K2:27)
		C_POINTER:C301($Lb_ptr)
		$Lb_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "List box")
		REDRAW:C174($Lb_ptr->)
		
	: ($formEvent_L=On Activate:K2:9)
		UpdatFilesPalet
	: ($formEvent_L=On Deactivate:K2:10)
		UpdatFilesPalet
		//REDRAW(◊asWindows)
End case 
//End [Conslt Rating].View Cslt Rating_LB