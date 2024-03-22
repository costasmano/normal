//Method: [Inspections];"QCQAPrint"
//Description
//form method for new form QCQAPRINT.
// to be printed as pdf when generating the pdf for the inspection after approvals
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/12/21, 16:18:11
	// ----------------------------------------------------
	//Created : 
	Mods_2021_04
	// Modified by: Costas Manousakis-(Designer)-(4/21/21 13:05:32)
	Mods_2021_04
	//  `force Json parse to return Is object
End if 
//
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		C_POINTER:C301($LB_ptr)
		$LB_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "Listbox")
		ARRAY POINTER:C280($colvars_aptr; 0)
		ARRAY POINTER:C280($headerVars_aptr; 0)
		ARRAY TEXT:C222($names_atxt; 0)
		ARRAY TEXT:C222($headers_atxt; 0)
		ARRAY BOOLEAN:C223($Visible_ab; 0)
		ARRAY POINTER:C280($styles_aptr; 0)
		LISTBOX GET ARRAYS:C832(*; "Listbox"; $names_atxt; $headers_atxt; $colvars_aptr; $headerVars_aptr; $Visible_ab; $styles_aptr)
		C_POINTER:C301($colarray_ptr)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($colvars_aptr))
			$colarray_ptr:=$colvars_aptr{$loop_L}
			ARRAY TEXT:C222($colarray_ptr->; 3)  //size arrays to 3
		End for 
		
		C_TEXT:C284($qc_txt; $cat_txt)
		C_OBJECT:C1216($qc_o; $Info)
		
		//clear all objects
		ARRAY TEXT:C222($all_txt; 3)
		$all_txt{1}:="TeamLeader"
		$all_txt{2}:="DBIE"
		$all_txt{3}:="AreaEngineer"
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($all_txt))
			OBJECT SET TITLE:C194(*; $all_txt{$loop_L}; "")
			OBJECT SET TITLE:C194(*; $all_txt{$loop_L}+"date"; "")
			OBJECT SET TITLE:C194(*; $all_txt{$loop_L}+"OSNAME"; "")
			OBJECT SET TITLE:C194(*; $all_txt{$loop_L}+"WKST"; "")
		End for 
		
		C_LONGINT:C283($loop_L; $row)
		For ($loop_L; 2; Size of array:C274($colvars_aptr))
			$colarray_ptr:=$colvars_aptr{$loop_L}
			For ($row; 1; 3)
				$colarray_ptr->{$row}:=""
			End for 
		End for 
		
		//get the text and parse into object
		$qc_txt:=EncryptDecryptString([Inspections:27]RatingFeedBack:203)
		$qc_o:=JSON Parse:C1218($qc_txt; Is object:K8:27)
		
		//scan the properties in the object
		ARRAY TEXT:C222($props_atxt; 0)
		OB GET PROPERTY NAMES:C1232($qc_o; $props_atxt)
		C_LONGINT:C283($Row)
		For ($loop_L; 1; Size of array:C274($props_atxt))
			$cat_txt:=""
			$Row:=0
			Case of 
				: ($props_atxt{$loop_L}="tl")
					$Info:=OB Get:C1224($qc_o; "tl"; Is object:K8:27)
					$cat_txt:="TeamLeader"
					$Row:=1
				: ($props_atxt{$loop_L}="dbie")
					$Info:=OB Get:C1224($qc_o; "dbie"; Is object:K8:27)
					$cat_txt:="DBIE"
					$Row:=2
				: ($props_atxt{$loop_L}="ae")
					$Info:=OB Get:C1224($qc_o; "ae"; Is object:K8:27)
					$cat_txt:="AreaEngineer"
					$Row:=3
			End case 
			If ($cat_txt#"")
				OBJECT SET TITLE:C194(*; $cat_txt; OB Get:C1224($Info; "name"; Is text:K8:3))
				
				OBJECT SET TITLE:C194(*; $cat_txt+"date"; OB Get:C1224($Info; "date"; Is text:K8:3))
				OBJECT SET TITLE:C194(*; $cat_txt+"OSNAME"; OB Get:C1224($Info; "osname"; Is text:K8:3))
				OBJECT SET TITLE:C194(*; $cat_txt+"WKST"; OB Get:C1224($Info; "wkst"; Is text:K8:3))
				C_LONGINT:C283($loop_L; $row)
				$colarray_ptr:=$colvars_aptr{2}
				$colarray_ptr->{$row}:=OB Get:C1224($Info; "name"; Is text:K8:3)
				$colarray_ptr:=$colvars_aptr{3}
				$colarray_ptr->{$row}:=Replace string:C233(OB Get:C1224($Info; "date"; Is text:K8:3); "T"; " ")
				$colarray_ptr:=$colvars_aptr{4}
				$colarray_ptr->{$row}:=OB Get:C1224($Info; "osname"; Is text:K8:3)
				$colarray_ptr:=$colvars_aptr{5}
				$colarray_ptr->{$row}:=OB Get:C1224($Info; "wkst"; Is text:K8:3)
				
			End if 
		End for 
		
		//do 1st column
		$colarray_ptr:=$colvars_aptr{1}
		$colarray_ptr->{1}:="COMPLETION"
		$colarray_ptr->{2}:="DBIE APPROVAL"
		$colarray_ptr->{3}:="AREA ENGINEER APPROVAL"
		
		
		Case of 
			: ([Inspections:27]Insp Type:6="DV@")
				//for dive inspections title is "UO Engineer approval"
				OBJECT SET TITLE:C194(*; "AREAENGINEERTITLE"; Uppercase:C13("UO Engineer approval"))
				OBJECT SET VISIBLE:C603(*; "DBIE@"; False:C215)
				$colarray_ptr:=$colvars_aptr{1}
				$colarray_ptr->{3}:=Uppercase:C13("UO Engineer approval")
				
				For ($loop_L; 1; Size of array:C274($colvars_aptr))
					$colarray_ptr:=$colvars_aptr{$loop_L}
					DELETE FROM ARRAY:C228($colarray_ptr->; 2; 1)  //delete second row from all arrays
				End for 
				
			: ([Inspections:27]Insp Type:6="FRZ")
				//area engineer not required
				OBJECT SET VISIBLE:C603(*; "AREAENG@"; False:C215)
				For ($loop_L; 1; Size of array:C274($colvars_aptr))
					$colarray_ptr:=$colvars_aptr{$loop_L}
					DELETE FROM ARRAY:C228($colarray_ptr->; 3; 1)  //delete the last row from all arrays
				End for 
				
		End case 
		
		C_TEXT:C284(vInspTitlePr; sInspDATE)
		vInspTitlePr:=Uppercase:C13(G_Insp_SetTitle)
		G_Insp_FormatTitle
		sInspDATE:=Uppercase:C13(String:C10([Inspections:27]Insp Date:78; Internal date abbreviated:K1:6))
		
End case 

//End [Inspections].QCQAPrint