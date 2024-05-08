  //Method: LSS_EditContracts.Button
  //Description
  //

  //
ARRAY TEXT:C222($Employers_atxt;0)
COLLECTION TO ARRAY:C1562(Form:C1466.ConsultantList;$Employers_atxt)
C_TEXT:C284($menu_txt;$name_txt)
$menu_txt:=MENU_BuildMenuFromArrays (->$Employers_atxt;->$Employers_atxt;";;;;")
$name_txt:=Dynamic pop up menu:C1006($menu_txt)
If ($name_txt#"")
	C_LONGINT:C283($ContractNum_L)
	$ContractNum_L:=Num:C11(Request:C163("Enter Contract number"))
	
	If ($ContractNum_L>0)
		
		If (Form:C1466.LssContracts.query("ContractNo = :1";$ContractNum_L).length>0)
			ALERT:C41("Contract number "+String:C10($ContractNum_L)+" is already listed with Consultant "+\
				Form:C1466.LssContracts.query("ContractNo = :1";$ContractNum_L)[0].ConsultantName)
		Else 
			Form:C1466.LssContracts.push(New object:C1471("ContractNo";$ContractNum_L;"ConsultantName";$name_txt;"Subs";New collection:C1472))
			Form:C1466.LssContracts:=Form:C1466.LssContracts.orderBy("ContractNo asc")
			If (False:C215)
				  //set / update the available subs
				  //ARRAY TEXT($Employers_atxt;0)
				  //COLLECTION TO ARRAY(Form.ConsultantList;$Employers_atxt)
				  //C_LONGINT($pos_L)
				  //$pos_L:=Find in array($Employers_atxt;Form.CurrContract.ConsultantName)
				  //If ($pos_L>0)
				  //DELETE FROM ARRAY($Employers_atxt;$pos_L;1)
				  //End if 
				  //C_COLLECTION($subNames_c)
				  //$subNames_c:=New collection
				  //ARRAY TO COLLECTION($subNames_c;$Employers_atxt)
				  //Form.availablesubs:=$subNames_c
				
			End if 
			
		End if 
		
	End if 
	
End if 
  //End LSS_EditContracts.Button   