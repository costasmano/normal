//%attributes = {"invisible":true}
//Method: Bridge_NBISSearchPicker_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 02/27/20, 15:06:53
	// ----------------------------------------------------
	//Created : 
	Mods_2020_02
	// Modified by: Costas Manousakis-(Designer)-(3/30/20 13:19:51)
	Mods_2020_03
	//  `font size cannot be changed
	//  `declare interproc variable only if not defined, 
	//  `reload the local $BridgeSearchArray_atxt after calls to Bridge_FileBridgeSearchArray
	
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
		
		SearchPicker SET HELP TEXT($ObjectName; "BDEPT|BIN|ITEM 7/6A")
		
	: (Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Losing Focus:K2:8)
		
		C_TEXT:C284($text_txt)
		$text_txt:=vSearch
		If ($text_txt#"") & (Length:C16($text_txt)>2)
			
			ARRAY TEXT:C222($BridgeSearchArray_atxt; 0)
			ARRAY TEXT:C222($LocalBinsList_atxt; 0)
			C_LONGINT:C283($Size_L)
			If (Type:C295(<>BridgeSearchArray_atxt)=Is undefined:K8:13)
				ARRAY TEXT:C222(<>BridgeSearchArray_atxt; 0)
			End if 
			GET PROCESS VARIABLE:C371(-1; <>BridgeSearchArray_atxt; $BridgeSearchArray_atxt)
			If (Type:C295($BridgeSearchArray_atxt)=Is undefined:K8:13)
				ARRAY TEXT:C222($BridgeSearchArray_atxt; 0)
				Bridge_FileBridgeSearchArray
				GET PROCESS VARIABLE:C371(-1; <>BridgeSearchArray_atxt; $BridgeSearchArray_atxt)
			Else 
				$Size_L:=Size of array:C274($BridgeSearchArray_atxt)
				If (($Size_L=0) | ($Size_L#Records in table:C83([Bridge MHD NBIS:1])))
					Bridge_FileBridgeSearchArray
					GET PROCESS VARIABLE:C371(-1; <>BridgeSearchArray_atxt; $BridgeSearchArray_atxt)
				End if 
			End if 
			
			ARRAY TEXT:C222($LocalBinsList_atxt; 0)
			SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $LocalBinsList_atxt)
			LISTBOX SELECT ROW:C912(*; "NBISStack_LB"; 0; lk remove from selection:K53:3)  //clear the selected rows
			
			C_BOOLEAN:C305($COMPLETE_B)
			$COMPLETE_B:=False:C215
			C_LONGINT:C283($START_L; $LOC_L; $local_L; $Last_L)
			$Last_L:=0
			$START_L:=0
			Repeat 
				$Loc_L:=Find in array:C230($BridgeSearchArray_atxt; "@"+"~!~"+$text_txt+"@"; $START_L)
				
				If ($Loc_L>0)
					$START_L:=$Loc_L+1
					$local_L:=Find in array:C230($LocalBinsList_atxt; Substring:C12($BridgeSearchArray_atxt{$Loc_L}; 13; 3))
					
					If ($local_L>0)
						LISTBOX SELECT ROW:C912(*; "NBISStack_LB"; $local_L; lk add to selection:K53:2)
						If ($local_L<$Last_L) | ($Last_L=0)
							$Last_L:=$local_L
						End if 
					Else 
						
					End if 
				End if 
				
			Until ($Loc_L<0)
			If ($Loc_L<0) & ($Last_L>0)
				OBJECT SET SCROLL POSITION:C906(*; "NBISStack_LB"; $Last_L)
			Else 
				
			End if 
			
		End if 
End case 

//End Bridge_NBISSearchPicker_OM