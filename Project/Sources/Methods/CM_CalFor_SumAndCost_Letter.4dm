//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): designer
	// Date and time: 03/21/05, 15:00:00
	// ----------------------------------------------------
	// Method: CM_CalFor_SumAndCost_Letter
	// Description:
	//  Calculation support WRT_ContrMnt_LumpSum 
	//  and   WRT_ContrMnt_CostPlus letters
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(2/16/2006 16:31:50)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(1/5/2007 10:34:17)
	Mods_2007_CM01
	// Modified by: costasmanousakis-(Designer)-(6/27/07 16:57:27)
	Mods_2007_CM12_5301
	Mods_2011_06  // CJ Miller`06/14/11, 11:27:51      ` Type all local variables for v11
End if 

ARRAY LONGINT:C221($CM_FundTransfer_TOFID_aL; 0)
ARRAY REAL:C219($CM_FundTransfer_Amount_aR; 0)
ARRAY TEXT:C222($CM_FundTransfer_Direction_aT; 0)

C_REAL:C285(vFundTransfer_StartingTLF; vFundTransfer_StartingDE; vFundTransfer_Sum)
vFundTransfer_StartingTLF:=0
vFundTransfer_StartingDE:=0
vFundTransfer_Sum:=0

//push the current FundTransfer record to the stack
PUSH RECORD:C176([FundTransfer_Maintenance:96])
COPY NAMED SELECTION:C331([FundTransfer_Maintenance:96]; "CMFUNDTRANSFSEL")
//get all FundTransfer for this contract
QUERY:C277([FundTransfer_Maintenance:96]; [FundTransfer_Maintenance:96]ContractNo:1=[Contract_Maintenance:97]ContractNo:1)
QUERY SELECTION:C341([FundTransfer_Maintenance:96]; [FundTransfer_Maintenance:96]DateApproval:5#!00-00-00!)
ORDER BY:C49([FundTransfer_Maintenance:96]; [FundTransfer_Maintenance:96]TOF_ID:2; >)

SELECTION TO ARRAY:C260([FundTransfer_Maintenance:96]TOF_ID:2; $CM_FundTransfer_TOFID_aL)
SELECTION TO ARRAY:C260([FundTransfer_Maintenance:96]TransferAmount:7; $CM_FundTransfer_Amount_aR)
SELECTION TO ARRAY:C260([FundTransfer_Maintenance:96]TransferDirection:6; $CM_FundTransfer_Direction_aT)
USE NAMED SELECTION:C332("CMFUNDTRANSFSEL")
CLEAR NAMED SELECTION:C333("CMFUNDTRANSFSEL")
//pop the current FundTransfer record from the stack
POP RECORD:C177([FundTransfer_Maintenance:96])
C_LONGINT:C283($i; $j; $k)
//set signs of all items in CM_FundTransfer_Amount_aR depending on transfer direction
//such as TLF->DE (-) and DE->TLF(+)
For ($i; 1; Size of array:C274($CM_FundTransfer_TOFID_aL))
	If ($CM_FundTransfer_Direction_aT{$i}="From Limiting Fee to Direct Expense")
		$CM_FundTransfer_Amount_aR{$i}:=-$CM_FundTransfer_Amount_aR{$i}
	End if 
End for 

C_REAL:C285($vRTemp)
$vRTemp:=0
//Sum up the entire CM_FundTransfer_Amount_aR array
For ($i; 1; Size of array:C274($CM_FundTransfer_Amount_aR))
	$vRTemp:=$vRTemp+$CM_FundTransfer_Amount_aR{$i}
End for 

//calculating the starting TLD and DE

vFundTransfer_StartingTLF:=vTLFupdated-$vRTemp
vFundTransfer_StartingDE:=vDEupdated+$vRTemp

//finding the location of current FundTransfer record in the CM_FundTransfer_TOFID_aL array
C_LONGINT:C283($vICounter)  //Command Replaced was o_C_INTEGER
$vICounter:=0
For ($j; 1; Size of array:C274($CM_FundTransfer_TOFID_aL))
	If ([FundTransfer_Maintenance:96]TOF_ID:2=$CM_FundTransfer_TOFID_aL{$j})
		$j:=Size of array:C274($CM_FundTransfer_TOFID_aL)+1  //the value is found and get out of the loop
	Else 
		$vICounter:=$vICounter+1
	End if 
End for 

//Sum up the CM_FundTransfer_Amount_aR array up to Counter
For ($k; 1; $vICounter)
	vFundTransfer_Sum:=vFundTransfer_Sum+$CM_FundTransfer_Amount_aR{$k}
End for 
