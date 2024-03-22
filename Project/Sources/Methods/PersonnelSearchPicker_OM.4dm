//%attributes = {"invisible":true}
//Method: PersonnelSearchPicker_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 09/17/20, 12:24:35
	// ----------------------------------------------------
	//Created : 
	Mods_2020_09  //Add search picker to personnel output list box
	//Modified by: CJ (9/17/20 13:44:01)
	// Modified by: manousakisc (5/26/2022)
	Mods_2022_05
	// clean On Load code; change so that all found records are selected; and scroll to the first one
	
End if 
//
Case of 
		
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vSearch)
		
		// Init the var itself
		// this can be done anywhere else in your code
		// the let's customise the SearchPicker (if needed)
		
		C_TEXT:C284($ObjectName)
		$ObjectName:=OBJECT Get name:C1087(Object current:K67:2)
		
		SearchPicker SET HELP TEXT($ObjectName; "First Name|Last Name")
		
	: (Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Losing Focus:K2:8)
		
		C_TEXT:C284($text_txt)
		$text_txt:=vSearch
		If ($text_txt#"") & (Length:C16($text_txt)>2)
			
			ARRAY TEXT:C222($PersonnelSearchArray_atxt; 0)
			
			C_LONGINT:C283($Size_L)
			If (Type:C295(<>PersonnelSearchArray_atxt)=Is undefined:K8:13)
				ARRAY TEXT:C222(<>PersonnelSearchArray_atxt; 0)
			End if 
			GET PROCESS VARIABLE:C371(-1; <>PersonnelSearchArray_atxt; $PersonnelSearchArray_atxt)
			If (Type:C295($PersonnelSearchArray_atxt)=Is undefined:K8:13)
				ARRAY TEXT:C222($PersonnelSearchArray_atxt; 0)
				Personnel_FillSearchArrray
				GET PROCESS VARIABLE:C371(-1; <>PersonnelSearchArray_atxt; $PersonnelSearchArray_atxt)
			Else 
				$Size_L:=Size of array:C274($PersonnelSearchArray_atxt)
				If (($Size_L=0) | ($Size_L#Records in table:C83([Personnel:42])))
					Personnel_FillSearchArrray
					GET PROCESS VARIABLE:C371(-1; <>PersonnelSearchArray_atxt; $PersonnelSearchArray_atxt)
				End if 
			End if 
			
			ARRAY INTEGER:C220($LocalID_aI; 0)
			SELECTION TO ARRAY:C260([Personnel:42]Person ID:1; $LocalID_aI)
			LISTBOX SELECT ROW:C912(*; "InspectorsOut_LB"; 0; lk remove from selection:K53:3)
			
			C_BOOLEAN:C305($COMPLETE_B)
			$COMPLETE_B:=False:C215
			C_LONGINT:C283($START_L; $LOC_L; $local_L; $Last_L; $Num_L)
			$Last_L:=0
			$START_L:=0
			Repeat 
				$Loc_L:=Find in array:C230($PersonnelSearchArray_atxt; "@"+"~!~"+$text_txt+"@"; $START_L)
				
				If ($Loc_L>0)
					$START_L:=$Loc_L+1
					$Num_L:=Num:C11(Substring:C12($PersonnelSearchArray_atxt{$Loc_L}; 1; Position:C15("~!~"; $PersonnelSearchArray_atxt{$Loc_L})-1))
					$local_L:=Find in array:C230($LocalID_aI; $Num_L)
					
					If ($local_L>0)
						LISTBOX SELECT ROW:C912(*; "InspectorsOut_LB"; $local_L; lk add to selection:K53:2)
						
						If ($local_L<$Last_L) | ($Last_L=0)
							$Last_L:=$local_L
						End if 
					Else 
						
					End if 
				End if 
				
			Until ($Loc_L<0)
			If ($Loc_L<0) & ($Last_L>0)
				OBJECT SET SCROLL POSITION:C906(*; "InspectorsOut_LB"; $Last_L)
			Else 
				
			End if 
			
		End if 
End case 
//End PersonnelSearchPicker_OM