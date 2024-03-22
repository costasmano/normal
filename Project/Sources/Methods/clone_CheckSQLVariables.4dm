//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/08/14, 10:48:06
//----------------------------------------------------
//Method: clone_CheckSQLVariables
//Description
//
// Parameters
// ----------------------------------------------------
If (Application type:C494#4D Server:K5:6)
	If (Not:C34(Is compiled mode:C492))
		If (User in group:C338(Current user:C182; "Design Access Group"))
			C_LONGINT:C283($TableLoop_l; $Length_l; $FieldLoop_l; $Type_l)
			C_TEXT:C284($VariablePrefix_txt; $VariableName_txt)
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
							
							GET FIELD PROPERTIES:C258($TableLoop_l; $FieldLoop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
							Case of 
								: ($Type_l=7)
									
								: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
									$VariableName_txt:=$VariableName_txt+"_txt"
									
								: ($Type_l=Is real:K8:4)
									$VariableName_txt:=$VariableName_txt+"_r"
									
								: ($Type_l=Is integer:K8:5)
									$VariableName_txt:=$VariableName_txt+"_L"
									
								: ($Type_l=Is longint:K8:6)
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
									ALERT:C41("Missing variable for Table name is "+Table name:C256($TableLoop_l)+" field name is "+Field name:C257($TableLoop_l; $FieldLoop_l))
									
									$FieldLoop_l:=Get last field number:C255($TableLoop_l)+10
									$TableLoop_l:=Get last table number:C254+10
								Else 
									
									Case of 
										: ($Type_l=7)
											
										: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
											If (Type:C295($Variable_ptr->)=Is text:K8:3) | (Type:C295($Variable_ptr->)=Is string var:K8:2)
												
											Else 
												$AllOK_b:=False:C215
												//$FieldLoop_l:=Get last field number($TableLoop_l)+10
												//$TableLoop_l:=Get last table number+10
											End if 
											
										: ($Type_l=Is real:K8:4)
											If (Type:C295($Variable_ptr->)=Is real:K8:4)
												
											Else 
												$AllOK_b:=False:C215
												//$FieldLoop_l:=Get last field number($TableLoop_l)+10
												//$TableLoop_l:=Get last table number+10
											End if 
											
										: ($Type_l=Is integer:K8:5) | ($Type_l=Is longint:K8:6)
											If (Type:C295($Variable_ptr->)=Is integer:K8:5) | (Type:C295($Variable_ptr->)=Is longint:K8:6)
												
											Else 
												$AllOK_b:=False:C215
												//$FieldLoop_l:=Get last field number($TableLoop_l)+10
												//$TableLoop_l:=Get last table number+10
											End if 
										: ($Type_l=Is date:K8:7)
											If (Type:C295($Variable_ptr->)=Is date:K8:7)
												
											Else 
												$AllOK_b:=False:C215
												//$FieldLoop_l:=Get last field number($TableLoop_l)+10
												//$TableLoop_l:=Get last table number+10
											End if 
										: ($Type_l=Is time:K8:8)
											If (Type:C295($Variable_ptr->)=Is time:K8:8)
												
											Else 
												$AllOK_b:=False:C215
												//$FieldLoop_l:=Get last field number($TableLoop_l)+10
												//$TableLoop_l:=Get last table number+10
											End if 
										: ($Type_l=Is boolean:K8:9)
											If (Type:C295($Variable_ptr->)=Is boolean:K8:9)
												
											Else 
												$AllOK_b:=False:C215
												//$FieldLoop_l:=Get last field number($TableLoop_l)+10
												//$TableLoop_l:=Get last table number+10
											End if 
										: ($Type_l=Is picture:K8:10)
											If (Type:C295($Variable_ptr->)=Is picture:K8:10)
												
											Else 
												$AllOK_b:=False:C215
												//$FieldLoop_l:=Get last field number($TableLoop_l)+10
												//$TableLoop_l:=Get last table number+10
											End if 
										: ($Type_l=Is BLOB:K8:12)
											If (Type:C295($Variable_ptr->)=Is BLOB:K8:12)
												
											Else 
												$AllOK_b:=False:C215
												
											End if 
										Else 
											
									End case 
									If (Not:C34($AllOK_b))
										ALERT:C41("Mismatched variable for Table name is "+Table name:C256($TableLoop_l)+" field name is "+Field name:C257($TableLoop_l; $FieldLoop_l))
										
										$FieldLoop_l:=Get last field number:C255($TableLoop_l)+10
										$TableLoop_l:=Get last table number:C254+10
									End if 
							End case 
							
						End if 
					End for 
					
				End if 
			End for 
			If (Not:C34($AllOK_b))
				
				CONFIRM:C162("There are some ill defined variables for SQL calls."+Char:C90(Carriage return:K15:38)+"Do you want to create new documents now?"; "Yes"; "No")
				If (OK=1)
					clone_NewCreateSQLVariable
				End if 
				
				
			End if 
		End if 
	End if 
End if 

//End clone_CheckSQLVariables

