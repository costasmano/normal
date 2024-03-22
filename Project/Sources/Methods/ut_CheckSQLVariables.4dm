//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/28/11, 14:14:50
//----------------------------------------------------
//Method: ut_CheckSQLVariables
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Ugrade to v11
	//Modified by: Charles Miller (1/28/11 14:14:51)
End if 
If (Application type:C494#4D Server:K5:6)
	If (Not:C34(Is compiled mode:C492))
		If (User in group:C338(Current user:C182; "Design Access Group"))
			C_LONGINT:C283($TableLoop_l; $Length_l; $FieldLoop_l; $Type_l)
			C_TEXT:C284($VariablePrefix_txt; $VariableName_txt; $Fieldname_txt; $TableName_txt)
			C_POINTER:C301($Variable_ptr)
			C_BOOLEAN:C305($AllOK_b; $Indexed_b; $Unique_b; $Invisible_b)
			$AllOK_b:=True:C214
			Compiler_FieldVariables
			For ($TableLoop_l; 1; Get last table number:C254)
				If (Is table number valid:C999($TableLoop_l))
					$VariablePrefix_txt:="v_"+String:C10($TableLoop_l)+"_"
					For ($FieldLoop_l; 1; Get last field number:C255($TableLoop_l))
						If (Is field number valid:C1000($TableLoop_l; $FieldLoop_l))
							
							$VariableName_txt:=$VariablePrefix_txt+String:C10($FieldLoop_l; "000")
							$Fieldname_txt:=Field name:C257($TableLoop_l; $FieldLoop_l)
							$TableName_txt:=Table name:C256($TableLoop_l)
							GET FIELD PROPERTIES:C258($TableLoop_l; $FieldLoop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
							Case of 
								: ($Type_l=7)
									
								: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
									$VariableName_txt:=$VariableName_txt+"_txt"
									
								: ($Type_l=Is real:K8:4)
									$VariableName_txt:=$VariableName_txt+"_r"
									
									
								: ($Type_l=Is integer:K8:5) | ($Type_l=Is longint:K8:6)
									$VariableName_txt:=$VariableName_txt+"_l"
									
								: ($Type_l=Is date:K8:7)
									$VariableName_txt:=$VariableName_txt+"_d"
									
								: ($Type_l=Is time:K8:8)
									$VariableName_txt:=$VariableName_txt+"_tm"
									
								: ($Type_l=Is boolean:K8:9)
									$VariableName_txt:=$VariableName_txt+"_b"
									
								: ($Type_l=Is picture:K8:10)
									$VariableName_txt:=$VariableName_txt+"_p"
									
								: ($Type_l=Is BLOB:K8:12)
									$VariableName_txt:=$VariableName_txt+"_blb"
									
								Else 
									
							End case 
							
							$Variable_ptr:=Get pointer:C304($VariableName_txt)
							C_LONGINT:C283($VariableType_L)
							$VariableType_L:=Type:C295($Variable_ptr->)
							Case of 
								: ($VariableType_L=Is undefined:K8:13) & ($Type_l#7)  //changed as undefined should nto be used. This does the same thing
									$AllOK_b:=False:C215
									$FieldLoop_l:=Get last field number:C255($TableLoop_l)+10
									$TableLoop_l:=Get last table number:C254+10
								Else 
									
									Case of 
										: ($Type_l=7)
											
										: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
											If (Type:C295($Variable_ptr->)=Is text:K8:3) | (Type:C295($Variable_ptr->)=Is string var:K8:2)
												
											Else 
												$AllOK_b:=False:C215
												$FieldLoop_l:=Get last field number:C255($TableLoop_l)+10
												$TableLoop_l:=Get last table number:C254+10
											End if 
											
										: ($Type_l=Is real:K8:4)
											If (Type:C295($Variable_ptr->)=Is real:K8:4)
												
											Else 
												$AllOK_b:=False:C215
												$FieldLoop_l:=Get last field number:C255($TableLoop_l)+10
												$TableLoop_l:=Get last table number:C254+10
											End if 
											
										: ($Type_l=Is integer:K8:5) | ($Type_l=Is longint:K8:6)
											If (Type:C295($Variable_ptr->)=Is integer:K8:5) | (Type:C295($Variable_ptr->)=Is longint:K8:6)
												
											Else 
												$AllOK_b:=False:C215
												$FieldLoop_l:=Get last field number:C255($TableLoop_l)+10
												$TableLoop_l:=Get last table number:C254+10
											End if 
										: ($Type_l=Is date:K8:7)
											If (Type:C295($Variable_ptr->)=Is date:K8:7)
												
											Else 
												$AllOK_b:=False:C215
												$FieldLoop_l:=Get last field number:C255($TableLoop_l)+10
												$TableLoop_l:=Get last table number:C254+10
											End if 
										: ($Type_l=Is time:K8:8)
											If (Type:C295($Variable_ptr->)=Is time:K8:8)
												
											Else 
												$AllOK_b:=False:C215
												$FieldLoop_l:=Get last field number:C255($TableLoop_l)+10
												$TableLoop_l:=Get last table number:C254+10
											End if 
										: ($Type_l=Is boolean:K8:9)
											If (Type:C295($Variable_ptr->)=Is boolean:K8:9)
												
											Else 
												$AllOK_b:=False:C215
												$FieldLoop_l:=Get last field number:C255($TableLoop_l)+10
												$TableLoop_l:=Get last table number:C254+10
											End if 
										: ($Type_l=Is picture:K8:10)
											If (Type:C295($Variable_ptr->)=Is picture:K8:10)
												
											Else 
												$AllOK_b:=False:C215
												$FieldLoop_l:=Get last field number:C255($TableLoop_l)+10
												$TableLoop_l:=Get last table number:C254+10
											End if 
										: ($Type_l=Is BLOB:K8:12)
											If (Type:C295($Variable_ptr->)=Is BLOB:K8:12)
												
											Else 
												$AllOK_b:=False:C215
												$FieldLoop_l:=Get last field number:C255($TableLoop_l)+10
												$TableLoop_l:=Get last table number:C254+10
											End if 
										Else 
											
									End case 
									
							End case 
							
						End if 
					End for 
					
				End if 
			End for 
			If (Not:C34($AllOK_b))
				C_TEXT:C284($Message_txt)
				$Message_txt:="There are some ill defined variables for SQL calls."+Char:C90(Carriage return:K15:38)
				$Message_txt:=$Message_txt+"The problem is in table named "+$TableName_txt+" field named "+$Fieldname_txt+Char:C90(Carriage return:K15:38)
				$Message_txt:=$Message_txt+"Variable named "+$VariableName_txt+Char:C90(Carriage return:K15:38)
				$Message_txt:=$Message_txt+"Do you want to create new documents now?"
				
				CONFIRM:C162($Message_txt; "Yes"; "No")
				If (OK=1)
					clone_NewCreateSQLVariable
					clone_NewSQLUpdateLocalTable
				End if 
				
				
			End if 
		End if 
	End if 
End if 
//End ut_CheckSQLVariables

