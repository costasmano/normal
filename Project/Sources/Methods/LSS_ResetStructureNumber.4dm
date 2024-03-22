//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 08/13/15, 12:16:34
//----------------------------------------------------
//Method: LSS_ResetStructureNumber
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_08_bug  // Added code to allow change to mile marker/ kilo point on 
	//Modified by: administrator (8/13/15 12:16:35)
End if 
C_TEXT:C284($0)
ARRAY TEXT:C222($StructureParts_atxt; 0)
C_TEXT:C284($OurStructure_txt)
$OurStructure_txt:=[LSS_Inventory:165]LSS_StructureNumber_s:6
ut_NewTextToArray($OurStructure_txt; ->$StructureParts_atxt; "-")
C_LONGINT:C283($MilePost_L)
$MilePost_L:=Trunc:C95([LSS_Inventory:165]LSS_MilePoint_r:8; 0)

$StructureParts_atxt{4}:=String:C10($MilePost_L; "000")
C_LONGINT:C283($Loop_L)
$0:=""
For ($Loop_L; 1; Size of array:C274($StructureParts_atxt))
	
	If ($Loop_L<Size of array:C274($StructureParts_atxt))
		$0:=$0+$StructureParts_atxt{$Loop_L}+"-"
	Else 
		$0:=$0+$StructureParts_atxt{$Loop_L}
	End if 
End for 
If ($OurStructure_txt#$0)
	CONFIRM:C162("Are you sure you wish to change structure number from "+$OurStructure_txt+" to "+$0; "Change"; "Do Not Change")
	If (OK=1)
		C_LONGINT:C283($CompleteCount_L; $ApprovedCount_Ll; $ReviewedCount_L)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $CompleteCount_L)
		QUERY SELECTION:C341([LSS_Inspection:164]; [LSS_Inspection:164]LSS_Complete_b:39=True:C214)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $ApprovedCount_Ll)
		QUERY SELECTION:C341([LSS_Inspection:164]; [LSS_Inspection:164]LSS_ApprovedDate_d:44#!00-00-00!)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $ReviewedCount_L)
		QUERY SELECTION:C341([LSS_Inspection:164]; [LSS_Inspection:164]LSS_ReviewDate_d:42#!00-00-00!)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		If ($CompleteCount_L=0) & ($ApprovedCount_Ll=0) & ($ReviewedCount_L=0)
		Else 
			C_TEXT:C284($Msg_txt)
			$Msg_txt:="There are "
			If ($CompleteCount_L>0)
				$Msg_txt:=$Msg_txt+String:C10($CompleteCount_L)+" Completed inspections "+Char:C90(Carriage return:K15:38)
			End if 
			If ($ApprovedCount_Ll>0)
				$Msg_txt:=$Msg_txt+String:C10($ApprovedCount_Ll)+" Approved inspections "+Char:C90(Carriage return:K15:38)
			End if 
			If ($ReviewedCount_L>0)
				$Msg_txt:=$Msg_txt+String:C10($ReviewedCount_L)+" Reviewed inspections "+Char:C90(Carriage return:K15:38)
			End if 
			$Msg_txt:=$Msg_txt+" that may have to be reprinted!"
			ALERT:C41($Msg_txt)
			
		End if 
		
	Else 
		[LSS_Inventory:165]LSS_KiloPoint_r:7:=Old:C35([LSS_Inventory:165]LSS_KiloPoint_r:7)
		[LSS_Inventory:165]LSS_MilePoint_r:8:=Old:C35([LSS_Inventory:165]LSS_MilePoint_r:8)
		$0:=[LSS_Inventory:165]LSS_StructureNumber_s:6
	End if 
Else 
	$0:=[LSS_Inventory:165]LSS_StructureNumber_s:6
End if 
//End LSS_ResetStructureNumber

