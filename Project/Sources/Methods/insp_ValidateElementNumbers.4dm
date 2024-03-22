//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/20/12, 11:13:58
//----------------------------------------------------
//Method: insp_ValidateElementNumbers
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_12  //r001 ` 
	//Modified by: Charles Miller (12/20/12 11:13:59)
	// Modified by: Costas Manousakis-(Designer)-(12/27/12 14:30:05)
	Mods_2012_12
	//Allow extra line for the element labels
End if 
C_BOOLEAN:C305($0; $AllOK_b)


$0:=False:C215
$AllOK_b:=True:C214
C_LONGINT:C283($Count_l; $MaxOffset_L; $Offset_L; $Position_L; $InnerLoop_l)
$MaxOffset_L:=Length:C16([Inspection Type:31]ElementNumbers_txt:4)
If ($MaxOffset_L>0)
	ARRAY TEXT:C222($CategoryErrors_atxt; 0)
	ARRAY TEXT:C222($ElementNumberErrors_atxt; 0)
	C_TEXT:C284($ErrorMessage_txt; $ElementType_txt; $ElementType_txt; $ElementLbls_txt; $ElementNumbers_txt)
	$ErrorMessage_txt:=""
	
	$Offset_L:=1
	Repeat 
		$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)
		If ($Position_L>0)
			$ElementType_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L; $Position_L-$Offset_L)  //N58, n60 etc
			$Offset_L:=$Position_L+1
			SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
			QUERY:C277([Element Cat:32]; [Element Cat:32]Code:1=$ElementType_txt)
			Case of 
				: ($Count_l=0)
					APPEND TO ARRAY:C911($CategoryErrors_atxt; $ElementType_txt)
				: ($Count_l>1)
					APPEND TO ARRAY:C911($CategoryErrors_atxt; $ElementType_txt+" * ")
				Else 
			End case 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)  //element numbers 100, 101, etc
			If ($Position_L>0)
				
				$ElementNumbers_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L; $Position_L-$Offset_L)  //element numbers 100, 101, etc 
				$Offset_L:=$Position_L+1
				$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)  //element labels 1.,2.,a. etc
				
				If ($Position_L>0)
					$ElementLbls_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L; $Position_L-$Offset_L)  // `element labels 1.,2.,a. etc
					$Offset_L:=$Position_L+1
				Else 
					$ElementLbls_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L)
					$Offset_L:=$MaxOffset_L
				End if 
				ARRAY TEXT:C222($ElementNumbers_atxt; 0)
				ut_NewTextToArray($ElementNumbers_txt; ->$ElementNumbers_atxt; ",")
				ARRAY TEXT:C222($ElementLbls_atxt; 0)
				ut_NewTextToArray($ElementLbls_txt; ->$ElementLbls_atxt; ",")
			Else 
				$Offset_L:=$MaxOffset_L
			End if 
			
		Else 
			$Offset_L:=$MaxOffset_L
		End if 
		
		If (Size of array:C274($ElementNumbers_atxt)#Size of array:C274($ElementLbls_atxt))
			APPEND TO ARRAY:C911($CategoryErrors_atxt; $ElementType_txt)
			APPEND TO ARRAY:C911($CategoryErrors_atxt; "Numbers "+String:C10(Size of array:C274($ElementNumbers_atxt))+" # Labels "+String:C10(Size of array:C274($ElementLbls_atxt)))
		End if 
		
		SET QUERY DESTINATION:C396(Into set:K19:2; "$ElementDictSet")
		QUERY:C277([ElementDict:30]; [ElementDict:30]Category:3=$ElementType_txt)
		For ($InnerLoop_l; 1; Size of array:C274($ElementNumbers_atxt))
			SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
			USE SET:C118("$ElementDictSet")
			QUERY SELECTION:C341([ElementDict:30]; [ElementDict:30]ElementNo:1=$ElementNumbers_atxt{$InnerLoop_l})
			Case of 
				: ($Count_l=0)
					APPEND TO ARRAY:C911($ElementNumberErrors_atxt; $ElementType_txt+" - "+$ElementNumbers_atxt{$InnerLoop_l})
				: ($Count_l>1)
					APPEND TO ARRAY:C911($ElementNumberErrors_atxt; $ElementType_txt+" - "+$ElementNumbers_atxt{$InnerLoop_l}+" * ")
				Else 
			End case 
			
		End for 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
	Until ($Offset_L>=$MaxOffset_L)
	
	If (Size of array:C274($CategoryErrors_atxt)>0)
		$AllOK_b:=False:C215
		$ErrorMessage_txt:="Following are the category errors: "+Char:C90(Carriage return:K15:38)
		
		For ($InnerLoop_l; 1; Size of array:C274($CategoryErrors_atxt))
			If ($InnerLoop_l>1)
				$ErrorMessage_txt:=$ErrorMessage_txt+", "+$CategoryErrors_atxt{$InnerLoop_l}
			Else 
				$ErrorMessage_txt:=$ErrorMessage_txt+$CategoryErrors_atxt{$InnerLoop_l}
			End if 
		End for 
		ALERT:C41($ErrorMessage_txt)
		
	End if 
	
	If (Size of array:C274($ElementNumberErrors_atxt)>0)
		$AllOK_b:=False:C215
		
		$ErrorMessage_txt:="Following are the Element errors: "+Char:C90(Carriage return:K15:38)
		
		For ($InnerLoop_l; 1; Size of array:C274($ElementNumberErrors_atxt))
			If ($InnerLoop_l>1)
				$ErrorMessage_txt:=$ErrorMessage_txt+", "+$ElementNumberErrors_atxt{$InnerLoop_l}
			Else 
				$ErrorMessage_txt:=$ErrorMessage_txt+$ElementNumberErrors_atxt{$InnerLoop_l}
			End if 
		End for 
		ALERT:C41($ErrorMessage_txt)
	End if 
End if 
$0:=$AllOK_b
//End insp_ValidateElementNumbers

