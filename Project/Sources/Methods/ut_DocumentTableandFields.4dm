//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 11/08/12, 13:11:40
//----------------------------------------------------
//Method: ut_DocumentTableandFields
//Description
//  `Utility
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_11  //r002 ` 
	//Modified by: Charles Miller (11/8/12 13:12:48)
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 10:53:30)
	Mods_2013_09
	//  `export all Field information for comparison purposes
End if 

C_LONGINT:C283($TableLoop_l; $FieldLoop_l; $Type_l; $Length_l; $Loop_l)
C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b; $mandatory_b; $enterable_b; $nonModif_b)
ARRAY TEXT:C222($Output_atxt; 1)
C_TEXT:C284($FieldName_txt; $FieldType_txt; $OutPut_txt; $IsIndexed_txt; $SetIndex_txt; $invis_txt; $listname_txt; $mandatory_txt; $enterable_txt; $nonModif_txt)
C_TIME:C306($Doc_tm)
$OutPut_txt:="`Method ut_setIndexes "+Char:C90(Carriage return:K15:38)+"`"+Char:C90(Carriage return:K15:38)
For ($TableLoop_l; 1; Get last table number:C254)
	
	If (Is table number valid:C999($TableLoop_l))
		
		If ($TableLoop_l>1)
			$OutPut_txt:=$OutPut_txt+Char:C90(Carriage return:K15:38)+"` "+String:C10($TableLoop_l)+Char:C90(Tab:K15:37)+Table name:C256($TableLoop_l)+Char:C90(Carriage return:K15:38)
		Else 
			$OutPut_txt:=$OutPut_txt+"` "+String:C10($TableLoop_l)+Char:C90(Tab:K15:37)+Table name:C256($TableLoop_l)+Char:C90(Carriage return:K15:38)
		End if 
		
		For ($FieldLoop_l; 1; Get last field number:C255($TableLoop_l))
			If (Is field number valid:C1000($TableLoop_l; $FieldLoop_l))
				GET FIELD ENTRY PROPERTIES:C685($TableLoop_l; $FieldLoop_l; $listname_txt; $mandatory_b; $enterable_b; $nonModif_b)
				GET FIELD PROPERTIES:C258($TableLoop_l; $FieldLoop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
				Case of 
					: ($Type_l=0)
						$FieldType_txt:="Alpha"
					: ($Type_l=2)
						$FieldType_txt:="Text"
					: ($Type_l=1)
						$FieldType_txt:="Real"
					: ($Type_l=8)
						$FieldType_txt:="Integer"
					: ($Type_l=9)
						$FieldType_txt:="Long Integer"
					: ($Type_l=4)
						$FieldType_txt:="Date"
					: ($Type_l=11)
						$FieldType_txt:="Time"
					: ($Type_l=6)
						$FieldType_txt:="Boolean"
					Else 
						$FieldType_txt:="Other"
				End case 
				$FieldName_txt:=Field name:C257($TableLoop_l; $FieldLoop_l)
				$IsIndexed_txt:=" Not Indexed"
				If ($Indexed_b)
					$IsIndexed_txt:=" Indexed"
					If ($Unique_b)
						$IsIndexed_txt:=" Unique Indexed"
					End if 
				End if 
				If ($mandatory_b)
					$mandatory_txt:="mandatory"
				Else 
					$mandatory_txt:=""
				End if 
				If ($enterable_b)
					$enterable_txt:="enterable"
				Else 
					$enterable_txt:=""
				End if 
				If ($nonModif_b)
					$nonModif_txt:="nonmodifiable"
				Else 
					$nonModif_txt:=""
				End if 
				
				$invis_txt:=""
				If ($Invisible_b)
					$invis_txt:="Invisible"
				End if 
				$OutPut_txt:=$OutPut_txt+"` "+String:C10($FieldLoop_l)+Char:C90(Tab:K15:37)+$FieldName_txt+Char:C90(Tab:K15:37)+$IsIndexed_txt+Char:C90(Tab:K15:37)+$FieldType_txt+Char:C90(Tab:K15:37)+String:C10($Length_l)+Char:C90(Tab:K15:37)+$invis_txt+Char:C90(Tab:K15:37)+$mandatory_txt+Char:C90(Tab:K15:37)+$enterable_txt+Char:C90(Tab:K15:37)+$nonModif_txt+Char:C90(Carriage return:K15:38)
				
				If ($Indexed_b)
					$OutPut_txt:=$OutPut_txt+"Set index (["+Table name:C256($TableLoop_l)+"]"+$FieldName_txt+";true)"+Char:C90(Carriage return:K15:38)
				End if 
				
				If (Length:C16($OutPut_txt)>30000)
					APPEND TO ARRAY:C911($Output_atxt; $OutPut_txt)
					$OutPut_txt:=""
				End if 
				
			End if 
		End for 
	End if 
End for 


APPEND TO ARRAY:C911($Output_atxt; $OutPut_txt)
SET TEXT TO PASTEBOARD:C523(ut_ReturnStructureName)
$Doc_tm:=Create document:C266("")
If (OK=1)
	For ($Loop_l; 1; Size of array:C274($Output_atxt))
		SEND PACKET:C103($Doc_tm; $Output_atxt{$Loop_l})
	End for 
	CLOSE DOCUMENT:C267($Doc_tm)
	
End if 
ARRAY TEXT:C222($Output_atxt; 0)

//End ut_DocumentTableandField