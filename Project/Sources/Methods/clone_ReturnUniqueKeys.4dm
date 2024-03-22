//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/08/14, 16:36:57
//----------------------------------------------------
//Method: clone_ReturnUniqueKeys
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_LONGINT:C283($1; $TableNumber_l; $Loop_l; $Length_l; $Type_l)
C_BOOLEAN:C305($0; $HasPicture_b)
$TableNumber_l:=$1
C_TEXT:C284($VariableExtension_txt)
C_POINTER:C301($2; $3)
$2->:=0
$3->:=""
C_BOOLEAN:C305($Reindex_b; $GetKey_b)
$Reindex_b:=False:C215
If (Count parameters:C259=4)
	C_BOOLEAN:C305($4)
	$Reindex_b:=$4
End if 
$HasPicture_b:=False:C215
$GetKey_b:=True:C214

C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b)

If (Not:C34($GetKey_b))
	GET FIELD PROPERTIES:C258($TableNumber_l; $Loop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
	$2->:=$Loop_l
	Case of 
		: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
			$VariableExtension_txt:="_atxt"
		: ($Type_l=Is real:K8:4)
			$VariableExtension_txt:="_ar"
		: ($Type_l=Is integer:K8:5) | ($Type_l=Is longint:K8:6)
			$VariableExtension_txt:="_al"
		: ($Type_l=Is date:K8:7)
			$VariableExtension_txt:="_ad"
		: ($Type_l=Is time:K8:8)
			$VariableExtension_txt:="_atm"
		: ($Type_l=Is boolean:K8:9)
			$VariableExtension_txt:="_ab"
		: ($Type_l=Is picture:K8:10)
			//$HasPicture_b:=True
			$VariableExtension_txt:="_ap"
		: ($Type_l=Is BLOB:K8:12)
			$HasPicture_b:=True:C214
			//$VariableExtension_txt:="_blb"
		Else 
			$VariableExtension_txt:=""
	End case 
	
	If ($Type_l#7)  // type 7 is subtable we are not using any data from them
		$3->:="v_"+String:C10($TableNumber_l)+"_"+String:C10($Loop_l; "000")+$VariableExtension_txt
	End if 
Else 
	C_BOOLEAN:C305($FoundKey_B; $IsUUID_B; $SetReturns_B)
	$FoundKey_B:=False:C215
	
	For ($Loop_l; 1; Get last field number:C255($TableNumber_l))
		$SetReturns_B:=False:C215
		
		If (Is field number valid:C1000($TableNumber_l; $Loop_l))
			GET FIELD PROPERTIES:C258($TableNumber_l; $Loop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
			Case of 
				: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
					$VariableExtension_txt:="_atxt"
				: ($Type_l=Is real:K8:4)
					$VariableExtension_txt:="_ar"
				: ($Type_l=Is integer:K8:5)
					$VariableExtension_txt:="_ai"
				: ($Type_l=Is longint:K8:6)
					$VariableExtension_txt:="_aL"
				: ($Type_l=Is date:K8:7)
					$VariableExtension_txt:="_ad"
				: ($Type_l=Is time:K8:8)
					$VariableExtension_txt:="_atm"
				: ($Type_l=Is boolean:K8:9)
					$VariableExtension_txt:="_ab"
				: ($Type_l=Is picture:K8:10)
					//$HasPicture_b:=True
					$VariableExtension_txt:="_ap"
				: ($Type_l=Is BLOB:K8:12)
					$HasPicture_b:=True:C214
					$VariableExtension_txt:="_ablb"
				Else 
					$VariableExtension_txt:=""
			End case 
			If ($Type_l#7)  //type 7 is subtable we are not using any data from them
				If ($Unique_b)
					If (Not:C34(clone_IncludeUUIDS_B))
						If ($Type_l=Is alpha field:K8:1) & ($Length_l=0)
						Else 
							$FoundKey_B:=True:C214
							$2->:=$Loop_l
							$3->:="v_"+String:C10($TableNumber_l)+"_"+String:C10($Loop_l; "000")+$VariableExtension_txt
						End if 
					Else 
						If (Not:C34($FoundKey_B))
							$FoundKey_B:=True:C214
							$2->:=$Loop_l
							$3->:="v_"+String:C10($TableNumber_l)+"_"+String:C10($Loop_l; "000")+$VariableExtension_txt
						End if 
						
					End if 
				End if 
				//$Loop_l:=Get last field number($TableNumber_l)+1
				
			End if 
		End if 
	End for 
End if 
$0:=$HasPicture_b
//End clone_ReturnUniqueKeys

