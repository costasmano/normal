//%attributes = {"invisible":true}
//Method: NTI_GetInspResp
//Description
// Get the inspection responsibility based on Item 1
// Parameters
// $0 : $InspResp_txt
// $1 :$NTI_i1_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/31/17, 14:57:55
	// ----------------------------------------------------
	//Created : 
	Mods_2017_01
	
	// Modified by: Costas Manousakis-(Designer)-(10/13/17 16:04:38)
	Mods_2017_10
	//  `if field [NTI_InspResp] is blank, then do the rest
	
	C_TEXT:C284(NTI_GetInspResp; $0)
	C_TEXT:C284(NTI_GetInspResp; $1)
End if 
//

C_TEXT:C284($0; $InspResp_txt)
C_TEXT:C284($1; $NTI_i1_txt)

$NTI_i1_txt:=$1
Begin SQL
	select [NTI_TunnelInfo].[NTI_InspResp]
	from [NTI_TunnelInfo]
	where [NTI_TunnelInfo].[NTI_i1_s] = :$NTI_i1_txt
	into :$InspResp_txt
End SQL

If ($InspResp_txt="")
	
	C_BLOB:C604($RO_State_x)
	
	$RO_State_x:=ut_db_SaveROState
	READ ONLY:C145([Bridge MHD NBIS:1])
	READ ONLY:C145([TunnelInfo:151])
	
	QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]NTI_i1_s:33=$NTI_i1_txt)
	C_TEXT:C284($owner_txt)
	$owner_txt:=Substring:C12($NTI_i1_txt; 10; 3)
	
	If (Records in selection:C76([TunnelInfo:151])>0)
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[TunnelInfo:151]BIN:1)
		$InspResp_txt:=[Bridge MHD NBIS:1]InspResp:173
	End if 
	If ($InspResp_txt="")
		
		If ($owner_txt="DOT")
			C_TEXT:C284($Dist_txt)
			$Dist_txt:=""
			If ([NTI_TunnelInfo:181]NTI_i1_s:6=$NTI_i1_txt)  //if the current record is loaded
				$Dist_txt:=[NTI_TunnelInfo:181]NTI_i6_s:11
			Else 
				//get the dis
				Begin SQL
					select [NTI_TunnelInfo].[NTI_i6_s] from [NTI_TunnelInfo]
					where [NTI_TunnelInfo].[NTI_i1_s] = :$NTI_i1_txt
					into :$Dist_txt
				End SQL
			End if 
			
			$InspResp_txt:="DIST"+String:C10(Num:C11($Dist_txt))
		Else 
			$InspResp_txt:=$owner_txt
		End if 
		
	End if 
	
	ut_db_RestoreROState($RO_State_x)
	
End if 

$0:=$InspResp_txt
//End NTI_GetInspResp