//%attributes = {"invisible":true}
//Method: LSS_MemberofContract
//Description
// Check if a user is member of one of the companies associated with a contract
// Parameters
// $0 : $Member_b
// $1 : $ContractNum_L
// $2 : $PersonID_L (optional - default to current user PID
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 6, 2024, 18:24:11
	Mods_2024_LSS_1
	// ----------------------------------------------------
	
	C_BOOLEAN:C305(LSS_MemberofContract; $0)
	C_LONGINT:C283(LSS_MemberofContract; $1)
	C_LONGINT:C283(LSS_MemberofContract; $2)
	
End if 
//
C_BOOLEAN:C305($0; $Member_b)
C_LONGINT:C283($1; $contract_L)
$contract_L:=$1
$Member_b:=False:C215
C_TEXT:C284($mycomp_txt)
$mycomp_txt:=""
If (Count parameters:C259>1)
	C_LONGINT:C283($2; $pid_L)
	$pid_L:=$2
	C_OBJECT:C1216($pers_o)
	$pers_o:=ds:C1482.Personnel.query("\"Person ID\" = :1"; $pid_L).first()
	If ($pers_o.Employer#Null:C1517)
		$mycomp_txt:=$pers_o.Employer
	End if 
	
Else 
	$mycomp_txt:=<>PERS_MyCompany_txt
	
End if 

If ($mycomp_txt#"")
	C_COLLECTION:C1488($contracts_c)
	C_TEXT:C284($contracts_txt)
	$contracts_txt:=ut_GetSysParameter("LSS_Contracts")
	If ($contracts_txt#"")
		C_TEXT:C284($errmethod)
		$errmethod:=Method called on error:C704
		ON ERR CALL:C155("4D_Errors")
		C_BOOLEAN:C305(4DError_b)
		4DError_b:=False:C215
		$contracts_c:=JSON Parse:C1218($contracts_txt; Is collection:K8:32)
		ON ERR CALL:C155($errmethod)
		
		If (Not:C34(4DError_b))
			C_COLLECTION:C1488($contract_c)
			$contract_c:=$contracts_c.query("ContractNo = :1"; $contract_L)
			
			If ($contract_c.length=1)
				$Member_b:=$contract_c[0].ConsultantName=$mycomp_txt
				
				If ($contract_c[0].Subs#Null:C1517)
					C_OBJECT:C1216($sub_)
					For each ($sub_; $contract_c[0].Subs)
						$Member_b:=$Member_b | ($sub_.name=$mycomp_txt)
					End for each 
				End if 
				
			End if 
			
		End if 
		4DError_b:=False:C215
		
	End if 
	
End if 

$0:=$Member_b
//End LSS_MemberofContract   