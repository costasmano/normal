If (False:C215)
	//form method [Bridge MHD NBIS];"Rating Evalu 10y"
	// Modified by: Costas Manousakis-(Designer)-(11/28/17 13:34:18)
	Mods_2017_11_bug
	//  `adjusted form objects to fit better on a windows print
	//  `use fields from bridge table for SIA data
	//  `include the code for i43 and i22 in the description
	//  `deleted 2nd page
	
End if 

//Load variables
C_TEXT:C284(vItem26)  // Command Replaced was o_C_STRING length was 23

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET VISIBLE:C603(*; "NoRatingText"; False:C215)
		OBJECT SET VISIBLE:C603(*; "RatingText"; False:C215)
		
		If (BLOB size:C605(report_blb)=0)
			v_65_020_txt:=""
			
			OBJECT SET ENABLED:C1123(*; "RatedPriority_@"; False:C215)
			
			C_REAL:C285($Inches_R)
			Case of 
				: ([Inspections:27]CurbRevealNE:10=-1)  //-1 = Hidden : H
					OBJECT SET TITLE:C194(*; "CurbRevealNO"; "H")
				: ([Inspections:27]CurbRevealNE:10=-2)  //-2 = Not applicable : N
					OBJECT SET TITLE:C194(*; "CurbRevealNO"; "N")
					
				Else 
					$Inches_R:=Round:C94(([Inspections:27]CurbRevealNE:10/25.4); 2)
					OBJECT SET TITLE:C194(*; "CurbRevealNO"; String:C10($Inches_R; "####.00"))
					
			End case 
			If ([Inspections:27]OrientationNS:133)
				OBJECT SET TITLE:C194(*; "NELabel"; "N")
				OBJECT SET TITLE:C194(*; "SWLabel"; "S")
			Else 
				OBJECT SET TITLE:C194(*; "NELabel"; "E")
				OBJECT SET TITLE:C194(*; "SWLabel"; "W")
				
			End if 
			Case of 
				: ([Inspections:27]CurbRevealSW:11=-1)  //-1 = Hidden : H
					OBJECT SET TITLE:C194(*; "CurbRevealSO"; "H")
				: ([Inspections:27]CurbRevealSW:11=-2)  //-2 = Not applicable : N
					OBJECT SET TITLE:C194(*; "CurbRevealSO"; "N")
					
				Else 
					
					$Inches_R:=Round:C94(([Inspections:27]CurbRevealSW:11/25.4); 2)
					OBJECT SET TITLE:C194(*; "CurbRevealSO"; String:C10($Inches_R; "####.00"))
					
			End case 
			
			//INSP_Item22Desc 
			C_TEXT:C284(vItem22)  // Command Replaced was o_C_STRING length was 27
			vItem22:=[Bridge MHD NBIS:1]Item22:128+" : "+sFriendlyName(Get_Description(-><>aMaintOwner; -><>aMaintCod; ->[Bridge MHD NBIS:1]Item22:128))
			
			C_TEXT:C284($item43a)
			C_TEXT:C284($Item43aDesc)
			$item43a:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 1; 1)
			$Item43aDesc:=Get_Description(-><>aMaterial; -><>aMatCode; ->$item43a)
			
			C_TEXT:C284($item43b)
			C_TEXT:C284($Item43bDesc)
			$item43b:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)
			$Item43bDesc:=Get_Description(-><>aDesign; -><>aDesignCod; ->$item43b)
			
			If ($Item43aDesc="")
				vItem43:=$Item43bDesc
			Else 
				vItem43:=$Item43aDesc+" "+$Item43bDesc
			End if 
			vItem43:=[Bridge MHD NBIS:1]Item43:75+" : "+vItem43
			
			//Added variables for Item 58,59,60,60uw ratings
			vItem58:=G_ElmtRatingTxt([Inspections:27]Item 58:79)
			vItem59:=G_ElmtRatingTxt([Inspections:27]Item 59:80)
			vItem60:=G_ElmtRatingTxt([Inspections:27]Item 60:81)
			vItem60UW:=G_ElmtRatingTxt([Inspections:27]Item 60 UW:66)
			vItem60Cur:=G_ElmtRatingTxt([Inspections:27]Item 60 Cur:155)
			
			//Flags    
			vFC:=f_Boolean2String([Inspections:27]FractureCrit:16; "YN")
			
			ut_FitPrintFormObject(->[Bridge MHD NBIS:1]Bridge Name:29; 11; 8)
			C_LONGINT:C283($Pos_L)
			
			C_TEXT:C284($district)
			OBJECT SET TITLE:C194(*; "EvalDate"; "This Evaluation Date: "+String:C10(Current date:C33; 7))
			
			v_1_128_txt:=Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)
			
			GetDBIEinfo(v_1_128_txt)
			OBJECT SET TITLE:C194(*; "DBIE"; "DBIE: "+vDBIEname+vDBIEsuffix)
			
		End if 
	: (Form event code:C388=On Printing Detail:K2:18)
		C_LONGINT:C283($Offset_L)
		$Offset_L:=0
		C_TEXT:C284($TextTitle_txt; $TextValue_txt; $district)
		$TextTitle_txt:=BLOB to text:C555(report_blb; UTF8 text without length:K22:17; $Offset_L)
		ARRAY TEXT:C222($ReportData_atxt; 0)
		ARRAY TEXT:C222($ReportData1_atxt; 0)
		ut_NewTextToArray($TextTitle_txt; ->$ReportData_atxt; Char:C90(Carriage return:K15:38))
		For ($Offset_L; 1; Size of array:C274($ReportData_atxt))
			ARRAY TEXT:C222($ReportData1_atxt; 0)
			
			ut_NewTextToArray($ReportData_atxt{$Offset_L}; ->$ReportData1_atxt; Char:C90(Tab:K15:37))
			If (Size of array:C274($ReportData1_atxt)=1)
				APPEND TO ARRAY:C911($ReportData1_atxt; "")
			End if 
			If ($ReportData1_atxt{1}="RatedValue")
				
				If ($ReportData1_atxt{2}="X")
					OBJECT SET VISIBLE:C603(*; "RatingText"; True:C214)
					OBJECT SET VISIBLE:C603(*; "NoRatingText"; False:C215)
				Else 
					OBJECT SET VISIBLE:C603(*; "RatingText"; False:C215)
				End if 
			End if 
			If ($ReportData1_atxt{1}="NoRatingNeeded")
				If ($ReportData1_atxt{2}="X")
					OBJECT SET VISIBLE:C603(*; "RatingText"; False:C215)
					OBJECT SET VISIBLE:C603(*; "NoRatingText"; True:C214)
					
				Else 
					OBJECT SET VISIBLE:C603(*; "NoRatingText"; False:C215)
				End if 
			End if 
			OBJECT SET TITLE:C194(*; $ReportData1_atxt{1}; $ReportData1_atxt{2})  //RatingText
		End for 
		
		
End case 