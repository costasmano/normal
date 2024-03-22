//%attributes = {"invisible":true}
If (False:C215)
	//P_ListContracts
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(10/31/06 16:11:46)
	Mods_2006_CM07
	Mods_2020_07  //continue replace of old output forms with list boxes
	//Modified by: CJ (7/6/20 15:20:34)
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
End if 

C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255
Compiler_LB
InitProcessVar
pFile:=->[Contracts:79]
SHORT_MESSAGE("Retrieving data. Please wait…")
READ ONLY:C145(*)
READ WRITE:C146([Contracts:79])
READ WRITE:C146([Contract AddFund:82])
READ WRITE:C146([Contract Assignments:83])
READ WRITE:C146([Contract ExtendTime:81])
READ WRITE:C146([Contract FundTransfer:80])
READ WRITE:C146([Contract Invoice AssignNo:85])
READ WRITE:C146([Contract Invoice:84])
READ WRITE:C146([Activity Log:59])
READ WRITE:C146([Sequences:28])
READ WRITE:C146([Owners of Data:62])

MainTitle:="Consultant Contracts"
ALL RECORDS:C47([Contracts:79])
ORDER BY:C49([Contracts:79]; [Contracts:79]ContractNo:1; >)

CLOSE WINDOW:C154  //close message window
C_TEXT:C284($Form_txt)
C_BOOLEAN:C305($useLB_B)
$useLB_B:=ut_UseListBox(Current method name:C684)

If ($useLB_B)
	$Form_txt:="Contracts_LB"
Else 
	$Form_txt:="Contracts Out"
End if 

FORM SET INPUT:C55([Contracts:79]; "Contracts In")
FORM SET OUTPUT:C54([Contracts:79]; $Form_txt)
C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
$RecSel:=String:C10(Records in selection:C76([Contracts:79]))
COPY NAMED SELECTION:C331([Contracts:79]; "UserRegionA")  //save the selection
SET MENU BAR:C67(6)
C_LONGINT:C283($FormW; $FormH1; $FormW1; $FormH; $Win_L)
FORM GET PROPERTIES:C674([Contracts:79]; $Form_txt; $FormW; $FormH1)
FORM GET PROPERTIES:C674([Contracts:79]; "Contracts In"; $FormW1; $FormH)
$Win_L:=ut_OpenNewWindow($FormW; 600; 1; Plain form window:K39:10; MainTitle+" ["+$RecSel+"]"; "ut_CloseCancel")
//NewWindow ($FormW;$FormH;1;Plain window)
//SET WINDOW RECT(16;44;16+$FormW;44+$FormH)

UpdatWindArray(""; Current process:C322)
SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")
If ($useLB_B)
	DIALOG:C40([Contracts:79]; $Form_txt)
Else 
	MODIFY SELECTION:C204([Contracts:79]; *)  //Display output form even for one record
End if 
CLEAR NAMED SELECTION:C333("UserRegionA")
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154