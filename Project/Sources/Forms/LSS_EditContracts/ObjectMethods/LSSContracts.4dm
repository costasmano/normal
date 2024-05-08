  //Method: LSS_EditContracts.LSSContracts
  //Description
  //
  // Parameters
  // ----------------------------------------------------
If (False:C215)
	  // ----------------------------------------------------
	  //User name (OS): Costas Manousakis
	  //User (4D) : Designer
	  //Created : 
	  //Date and time: Feb 8, 2024, 12:51:55
	
	  // ----------------------------------------------------
	
End if 
  //

C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388
Case of 
	: ($FormEvent_L=On Load:K2:1)
		
	: ($FormEvent_L=On Selection Change:K2:29)
		If (Form:C1466.CurrContract#Null:C1517)
			  //change the pulldown for subs to add 
			ARRAY TEXT:C222($Employers_atxt;0)
			COLLECTION TO ARRAY:C1562(Form:C1466.ConsultantList;$Employers_atxt)
			C_LONGINT:C283($pos_L)
			$pos_L:=Find in array:C230($Employers_atxt;Form:C1466.CurrContract.ConsultantName)
			If ($pos_L>0)
				DELETE FROM ARRAY:C228($Employers_atxt;$pos_L;1)
			End if 
			
			If (Form:C1466.CurrContract.Subs#Null:C1517)
				C_OBJECT:C1216($sub_o)
				For each ($sub_o;Form:C1466.CurrContract.Subs)
					$pos_L:=Find in array:C230($Employers_atxt;$sub_o.name)
					If ($pos_L>0)
						DELETE FROM ARRAY:C228($Employers_atxt;$pos_L;1)
					End if 
				End for each 
				
			End if 
			
			C_COLLECTION:C1488($subNames_c)
			$subNames_c:=New collection:C1472
			ARRAY TO COLLECTION:C1563($subNames_c;$Employers_atxt)
			Form:C1466.availablesubs:=$subNames_c
		End if 
		
	: ($FormEvent_L=On Clicked:K2:4)
		If (Contextual click:C713)
			  //which column
			C_LONGINT:C283($col;$row)
			LISTBOX GET CELL POSITION:C971(*;"LSSContracts";$col;$row)
			If ($row>0)
				  //click on a contract
				
				Case of 
					: ($col=1)
						  //contract num
						  //can we make the cell enterable?
						  //ask for new contract number
						C_LONGINT:C283($newNum_L)
						$newNum_L:=Num:C11(Request:C163("Enter new contract number";String:C10(Form:C1466.CurrContract.ContractNo)))
						If ($newNum_L>0)
							Form:C1466.CurrContract.ContractNo:=$newNum_L
						End if 
						
					: ($col=2)
						  //consultant name
						ARRAY TEXT:C222($Employers_atxt;0)
						COLLECTION TO ARRAY:C1562(Form:C1466.ConsultantList;$Employers_atxt)
						C_TEXT:C284($menuref_txt;$newCons_txt)
						$menuref_txt:=MENU_BuildMenuFromArrays (->$Employers_atxt;->$Employers_atxt;";;;;")
						$newCons_txt:=Dynamic pop up menu:C1006($menuref_txt)
						If ($newCons_txt#"") & ($newCons_txt#Form:C1466.CurrContract.ConsultantName)
							Form:C1466.CurrContract.ConsultantName:=$newCons_txt
							  //remove it from the subs if it is in there.
							
							If (Form:C1466.CurrContract.Subs#Null:C1517)
								
								If (Form:C1466.CurrContract.Subs.length>0)
									C_COLLECTION:C1488($found_o)
									$found_o:=Form:C1466.CurrContract.Subs.indices("name = :1";$newCons_txt)
									If ($found_o.length>0)
										Form:C1466.CurrContract.Subs.remove($found_o[0];1)
									End if 
									
								End if 
								
							End if 
							
						End if 
				End case 
				
			End if 
		End if 
End case 

  //End LSS_EditContracts.LSSContracts   