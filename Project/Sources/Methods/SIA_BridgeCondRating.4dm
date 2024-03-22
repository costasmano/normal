//%attributes = {"invisible":true}
//Method: SIA_BridgeCondRating
//Description
// Calculate condition rating using FHWA directive which considers only 58,59,60,62 and 
// condition as Poor, Fair, Good. attaches also the 'critical element(s)'
// Parameters
// $0 : $Rating + Critical item(s)
// $1 : $Item58 (optional - assume current [Bridge MHD NBIS] record)
// $2 : $Item59 (optional - assume current [Bridge MHD NBIS] record)
// $3 : $Item60 (optional - assume current [Bridge MHD NBIS] record)
// $4 : $Item62 (optional - assume current [Bridge MHD NBIS] record)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/30/18, 17:16:58
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04
	
	C_TEXT:C284(SIA_BridgeCondRating; $0)
	C_TEXT:C284(SIA_BridgeCondRating; $1)
	C_TEXT:C284(SIA_BridgeCondRating; $2)
	C_TEXT:C284(SIA_BridgeCondRating; $3)
	C_TEXT:C284(SIA_BridgeCondRating; $4)
	
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_TEXT:C284($Item58; $item59; $item60; $Item62)
$Item58:=[Bridge MHD NBIS:1]Item58:130
$item59:=[Bridge MHD NBIS:1]Item59:131
$item60:=[Bridge MHD NBIS:1]Item60:132
$Item62:=[Bridge MHD NBIS:1]Item62:134
If (Count parameters:C259>0)
	$Item58:=$1
End if 
If (Count parameters:C259>1)
	$Item59:=$2
End if 
If (Count parameters:C259>2)
	$Item60:=$3
End if 
If (Count parameters:C259>3)
	$Item62:=$4
End if 

C_TEXT:C284($Critical_Item_txt)
$Critical_Item_txt:=""
C_LONGINT:C283($MinCond_L)
If ((($item58>="0") & ($Item58<="9")) | (($item59>="0") & ($Item59<="9")) | \
(($item60>="0") & ($Item60<="9")) | (($item62>="0") & ($Item62<="9")))
	$MinCond_L:=3  //start with Good if all items have a valid rating
Else 
	$MinCond_L:=0
End if 

//Item 58
Case of 
	: (($item58>="0") & ($Item58<="4"))
		$MinCond_L:=1
		$Critical_Item_txt:="58"
	: (($item58>="5") & ($Item58<="6"))
		$MinCond_L:=2
		$Critical_Item_txt:="58"
End case 

//Item 59
Case of 
	: (($item59>="0") & ($Item59<="4"))
		If ($MinCond_L>1)
			$MinCond_L:=1
			$Critical_Item_txt:=""
		End if 
		If ($Critical_Item_txt="")
			$Critical_Item_txt:="59"
		Else 
			$Critical_Item_txt:=$Critical_Item_txt+","+"59"
		End if 
		
	: (($item59>="5") & ($Item59<="6"))
		If ($MinCond_L>2)
			$MinCond_L:=2
			$Critical_Item_txt:=""
		End if 
		
		Case of 
			: ($MinCond_L=1)
			: ($MinCond_L=2)
				If ($Critical_Item_txt="")
					$Critical_Item_txt:="59"
				Else 
					$Critical_Item_txt:=$Critical_Item_txt+","+"59"
				End if 
				
		End case 
		
End case 

//Item 60
Case of 
	: (($item60>="0") & ($item60<="4"))
		If ($MinCond_L>1)
			$MinCond_L:=1
			$Critical_Item_txt:=""
		End if 
		If ($Critical_Item_txt="")
			$Critical_Item_txt:="60"
		Else 
			$Critical_Item_txt:=$Critical_Item_txt+","+"60"
		End if 
		
	: (($item60>="5") & ($item60<="6"))
		If ($MinCond_L>2)
			$MinCond_L:=2
			$Critical_Item_txt:=""
		End if 
		
		Case of 
			: ($MinCond_L=1)
			: ($MinCond_L=2)
				If ($Critical_Item_txt="")
					$Critical_Item_txt:="60"
				Else 
					$Critical_Item_txt:=$Critical_Item_txt+","+"60"
				End if 
				
		End case 
		
End case 

//Item 62
Case of 
	: (($item62>="0") & ($item62<="4"))
		If ($MinCond_L>1)
			$MinCond_L:=1
			$Critical_Item_txt:=""
		End if 
		If ($Critical_Item_txt="")
			$Critical_Item_txt:="62"
		Else 
			$Critical_Item_txt:=$Critical_Item_txt+","+"62"
		End if 
		
	: (($item62>="5") & ($item62<="6"))
		If ($MinCond_L>2)
			$MinCond_L:=2
			$Critical_Item_txt:=""
		End if 
		
		Case of 
			: ($MinCond_L=1)
			: ($MinCond_L=2)
				If ($Critical_Item_txt="")
					$Critical_Item_txt:="62"
				Else 
					$Critical_Item_txt:=$Critical_Item_txt+","+"62"
				End if 
				
		End case 
		
End case 


Case of 
	: ($MinCond_L=1)
		$0:="POOR"+" - "+$Critical_Item_txt
	: ($MinCond_L=2)
		$0:="FAIR"+" - "+$Critical_Item_txt
	: ($MinCond_L=3)
		$0:="GOOD"
End case 


//End SIA_BridgeCondRating