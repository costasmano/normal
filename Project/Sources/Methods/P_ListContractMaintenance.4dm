//%attributes = {"invisible":true}
If (False:C215)
	//P_ListContractMaintenance
	// Modified by: costasmanousakis-(Designer)-(1/7/08 11:59:07)
	Mods_2007_CM_5401
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
	Mods_2020_06
	//Modified by: CJ (6/18/20 14:07:25)
	//Move code from single user to this to upgrade to use list boxes
	Mods_2020_06  //Added new list box output form. Only for designer now
	//Modified by: Chuck (6/25/20 16:03:37)
	Mods_2020_07  //Continue to replace current user = Designer to select Listbox or not
	//Modified by: CJ (7/2/20 13:55:42)
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
	
End if 

C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255
Compiler_LB
InitProcessVar
pFile:=->[Contract_Maintenance:97]
SHORT_MESSAGE("Retrieving data. Please wait…")

MainTitle:="Preservation/Betterment Contracts"
ALL RECORDS:C47([Contract_Maintenance:97])
ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ContractNo:1; >)
C_TEXT:C284($Form_txt)

CLOSE WINDOW:C154  //close message window
C_BOOLEAN:C305($useLB_B)
$useLB_B:=ut_UseListBox(Current method name:C684)
If ($useLB_B)
	$Form_txt:="Contract Maintenance_LB"
Else 
	$Form_txt:="Contract Maintenance Out"
End if 
FORM SET INPUT:C55([Contract_Maintenance:97]; "Contract Maintenance In")
FORM SET OUTPUT:C54([Contract_Maintenance:97]; $Form_txt)
C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
$RecSel:=String:C10(Records in selection:C76([Contract_Maintenance:97]))
COPY NAMED SELECTION:C331([Contract_Maintenance:97]; "UserRegionA")  //save the selection
SET MENU BAR:C67(7)
C_LONGINT:C283($Width_i_l; $Height_i_l; $Width_l; $Height_l)
FORM GET PROPERTIES:C674([Contract_Maintenance:97]; "Contract Maintenance In"; $Width_i_l; $Height_i_l)
FORM GET PROPERTIES:C674([Contract_Maintenance:97]; $Form_txt; $Width_l; $Height_l)
If ($Width_i_l>$Width_l)
	$Width_l:=$Width_i_l
Else 
	$Width_l:=$Width_l+20
End if 
If ($Height_i_l>$Height_i_l)
	$Height_l:=$Height_i_l
End if 
If ($Height_l<550)
	$Height_l:=550
End if 
C_LONGINT:C283($Win_L)
$Win_L:=ut_OpenNewWindow($Width_l; $Height_l; 1; Plain form window:K39:10; MainTitle+" ["+$RecSel+"]"; "ut_CloseCancel")

//NewWindow ($Width_l;$Height_l;1;Plain window)
//SET WINDOW RECT(16;44;16+$Width_l;44+$Height_l)

UpdatWindArray(""; Current process:C322)
//SET WINDOW TITLE(MainTitle+" ["+$RecSel+"]")
If ($useLB_B)
	DIALOG:C40([Contract_Maintenance:97]; $Form_txt)
Else 
	MODIFY SELECTION:C204([Contract_Maintenance:97]; *)  //Display output form even for one record
End if 
CLEAR NAMED SELECTION:C333("UserRegionA")
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154