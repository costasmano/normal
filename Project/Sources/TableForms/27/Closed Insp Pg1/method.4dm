If (False:C215)
	//LO: [Inspections];"Closed Insp Pg1"
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	Mods_2005_CM01
	Mods_2005_CM05  //twice 
	// Modified by: ManousakisC (4/24/2006)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 15:36:32)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(3/28/08 15:02:59)
	Mods_2008_CM_5403  //Adjust Kilo/Mile display
	// Modified by: Costas Manousakis-(Designer)-(7/29/13 11:33:18)
	Mods_2013_07
	//  `Modified print forms for MBTA to display the title MBTA Area engineer only.
	// Modified by: Costas Manousakis-(Designer)-(6/1/15 10:48:55)
	Mods_2015_06_bug
	//  `Replaced old code  with new call to  INSP_FillElementInfo and  using the setup  as in other forms.
	//  `Fixed Label ht at SIGNS section; alignment of X check marks for "Scheduled for..." section
	// Modified by: Costas Manousakis-(Designer)-(1/16/18 14:01:16)
	Mods_2018_01
	//  `increased allowed entry in Total Hrs
	// Modified by: Costas Manousakis-(Designer)-(2021-10-25T00:00:00 17:17:24)
	Mods_2021_10
	//  `added text objects TLEsignature and DBIEESignature - call INSP_QCFillESignatures
End if 

//Form variables

C_TEXT:C284(vItem26)  // Command Replaced was o_C_STRING length was 23
C_TEXT:C284(vItem21; vItem22)  // Command Replaced was o_C_STRING length was 27

C_TEXT:C284(vLiftBucket; vLadder; vBoat; vWader; vInspect50; vRigging; vStaging; vTraffic; vFlagman; vPolice; vAccOther)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vNeedLiftBucket; vNeedLadder; vNeedBoat; vNeedWader; vNeedInspect50; vNeedRigging; vNeedStaging; vNeedTraffic; vNeedFlagman; vNeedPolice; vNeedAccOther)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(xS1; xS2; xS3; xS4; xS5)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vCld_Completion_Date)  // Command Replaced was o_C_STRING length was 255

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		FORM_FixHairLine
		INSP_QCFillESignatures
		G_Insp_SetDirLbl([Inspections:27]OrientationNS:133)
		INSP_KiloPtValues
		INSP_Item21Desc
		INSP_Item22Desc
		
		vItem26:=Get_Description(-><>aFC; -><>aFC_Cod; ->[Inspections:27]Item26:200)
		INSP_Item41Desc
		INSP_Item43Desc
		INSP_Item107Desc
		
		//Added variables for Item 58,59,60,60uw, 61, 61uw ratings
		vItem58:=G_ElmtRatingTxt([Inspections:27]Item 58:79)
		vItem59:=G_ElmtRatingTxt([Inspections:27]Item 59:80)
		vItem60:=G_ElmtRatingTxt([Inspections:27]Item 60:81)
		vItem60UW:=G_ElmtRatingTxt([Inspections:27]Item 60 UW:66)
		vItem61:=G_ElmtRatingTxt([Inspections:27]Item 61:82)
		vItem61UW:=G_ElmtRatingTxt([Inspections:27]Item 61 UW:72)
		vItem62:=G_ElmtRatingTxt([Inspections:27]Item 62:113)
		vItem62UW:=G_ElmtRatingTxt([Inspections:27]Item 62 UW:165)
		
		//Adjust Fonts and fields.
		If (Length:C16(vItem26)>14)
			OBJECT SET FONT SIZE:C165(vItem26; 9)
		End if 
		INSP_Item43Desc("Resize")
		Case of 
			: (Length:C16([Inspections:27]Barrier Type:117)>15)
				OBJECT SET FONT SIZE:C165(*; "BarrierTypeDesc"; 9)
				OBJECT MOVE:C664(*; "BarrierTypeDesc"; 0; -4; 0; 20)
		End case 
		
		G_Insp_FmtSTOWN
		
		//Dates
		vItem90:=Uppercase:C13(String:C10([Inspections:27]Item 90:142; Internal date abbreviated:K1:6))
		If ([Inspections:27]Item 90:142=!00-00-00!)
			vItem90:="--------"
		End if 
		
		vPosting_Date:=Uppercase:C13(String:C10([Inspections:27]PostingDate:114; Internal date short:K1:7))
		If ([Inspections:27]PostingDate:114=!00-00-00!)
			vPosting_Date:=""
		End if 
		
		C_LONGINT:C283(INSP_NumItems_L)  //Command Replaced was o_C_INTEGER//number of items on this form
		INSP_NumItems_L:=1  // TRAffic
		ARRAY INTEGER:C220(INSP_Start_ai; INSP_NumItems_L)  //start of item counter
		ARRAY INTEGER:C220(INSP_Fin_ai; INSP_NumItems_L)  //end of item counter
		//load values in the arrays
		INSP_Start_ai{1}:=<>kTRAs_
		INSP_Fin_ai{1}:=<>kTRAf_
		
		INSP_FillElementInfo
		
		//Check boxes
		If ([Inspections:27]ClsdRoutine:145=True:C214)
			vClsdR:="X"
			vClsdS:=""
		Else 
			vClsdR:=""
			vClsdS:="X"
		End if 
		
		//Flags    
		If (([Inspections:27]PedBarricadesNE:83="A") | ([Inspections:27]PedBarricadesNE:83="B"))
			vPedAccess:="Y"
		Else 
			vPedAccess:="N"
		End if 
		If ([Inspections:27]RoadWayAbandon:116=True:C214)
			vRoadAbd:="Y"
		Else 
			vRoadAbd:="N"
		End if 
		If ([Inspections:27]BarriersIP:115=True:C214)
			vBarricades:="Y"
		Else 
			vBarricades:="N"
		End if 
		vLiftBucket:=Substring:C12([Inspections:27]LiftBucket:86; 2; 1)
		vLadder:=Substring:C12([Inspections:27]Ladder:87; 2; 1)
		vBoat:=Substring:C12([Inspections:27]Boat:88; 2; 1)
		vWader:=Substring:C12([Inspections:27]Wader:89; 2; 1)
		vInspect50:=Substring:C12([Inspections:27]Inspector50:90; 2; 1)
		vRigging:=Substring:C12([Inspections:27]Rigging:91; 2; 1)
		vStaging:=Substring:C12([Inspections:27]Staging:92; 2; 1)
		vTraffic:=Substring:C12([Inspections:27]Traffic Control:93; 2; 1)
		vFlagman:=Substring:C12([Inspections:27]RR Flagman:94; 2; 1)
		vPolice:=Substring:C12([Inspections:27]Police:95; 2; 1)
		vAccOther:=Substring:C12([Inspections:27]OtherAccBool:97; 2; 1)
		vNeedLiftBucket:=Substring:C12([Inspections:27]LiftBucket:86; 1; 1)
		vNeedLadder:=Substring:C12([Inspections:27]Ladder:87; 1; 1)
		vNeedBoat:=Substring:C12([Inspections:27]Boat:88; 1; 1)
		vNeedWader:=Substring:C12([Inspections:27]Wader:89; 1; 1)
		vNeedInspect50:=Substring:C12([Inspections:27]Inspector50:90; 1; 1)
		vNeedRigging:=Substring:C12([Inspections:27]Rigging:91; 1; 1)
		vNeedStaging:=Substring:C12([Inspections:27]Staging:92; 1; 1)
		vNeedTraffic:=Substring:C12([Inspections:27]Traffic Control:93; 1; 1)
		vNeedFlagman:=Substring:C12([Inspections:27]RR Flagman:94; 1; 1)
		vNeedPolice:=Substring:C12([Inspections:27]Police:95; 1; 1)
		vNeedAccOther:=Substring:C12([Inspections:27]OtherAccBool:97; 1; 1)
		If ([Inspections:27]Plans:69=True:C214)
			vPlans:="Y"
		Else 
			vPlans:="N"
		End if 
		If ([Inspections:27]VCR:70=True:C214)
			vVCR:="Y"
		Else 
			vVCR:="N"
		End if 
		If ([Inspections:27]ClosedSigns:118=True:C214)
			vCldPost:=""
			vBrCldSgnNE:=[Inspections:27]BrCldSignsNE:119
			vBrCldSgnSW:=[Inspections:27]BrCldSignsSW:120
			vAdCldSgnNE:=[Inspections:27]AdCldSignsNE:121
			vAdCldSgnSW:=[Inspections:27]AdCldSignsSW:122
		Else 
			vCldPost:="X"
			vBrCldSgnNE:=""
			vBrCldSgnSW:=""
			vAdCldSgnNE:=""
			vAdCldSgnSW:=""
		End if 
		//Get the year rehab'd
		vYrRehab:=[Inspections:27]YrRehab:158
		f_Var_to_Series([Inspections:27]Cld_Schedule:194; "xS"; "12345")
		vCld_Completion_Date:=Uppercase:C13(String:C10([Inspections:27]Cld_Completion_Date:188; Internal date short:K1:7))
		If ([Inspections:27]Cld_Completion_Date:188=!00-00-00!)
			vCld_Completion_Date:=""
		End if 
		If ([Inspections:27]Cld_UnderConstruction:195=False:C215)
			OBJECT SET VISIBLE:C603([Inspections:27]Cld_Contract_Number:190; False:C215)
			OBJECT SET VISIBLE:C603([Inspections:27]Cld_Amount:187; False:C215)
			OBJECT SET VISIBLE:C603(*; vCld_Completion_Date; False:C215)
			OBJECT SET VISIBLE:C603([Inspections:27]Cld_Contractor:189; False:C215)
			OBJECT SET VISIBLE:C603([Inspections:27]Cld_Resident_Engineer:192; False:C215)
			OBJECT SET VISIBLE:C603([Inspections:27]Cld_Scope_of_Work:193; False:C215)
			OBJECT SET VISIBLE:C603([Inspections:27]Cld_Remarks:191; False:C215)
		End if 
		
		G_Insp_SetDeptFont
		G_Insp_ApplyRev2_PR
		
End case 