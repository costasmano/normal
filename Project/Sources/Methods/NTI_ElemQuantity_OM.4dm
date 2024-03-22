//%attributes = {"invisible":true}
//Method: NTI_ElemQuantity_OM
//Description
// object method for the elem quantity field in [NTI_ELEM_TIN_INSP] input form
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/30/18, 15:46:44
	// ----------------------------------------------------
	//Created : 
	Mods_2018_01
	
	C_LONGINT:C283(NTI_ElemQuantity_OM; $1)
	
End if 
//
C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		
	: ($FormEvent_L=On Data Change:K2:15)
		//round total q to PON_RoundQ_L dec
		[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundQ_L)
		// when changing total q-subtract from it quantities for st2-3-4  and put rest in st 1 or 2
		Case of 
			: ([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21<=0)
				ALERT:C41("Cannot change to Zero Quantity!")
				[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21:=Old:C35([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)
			: ((PON_ELEMUNIT_txt="percent") & ([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21>100))
				ALERT:C41("Current Units are Percent! Cannot have Total Quantity greater than 100!")
				[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21:=Old:C35([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)
				
			Else 
				//make sure state fields are enterable
				OBJECT SET ENTERABLE:C238(*; "DE ELEM_QTYSTATE@"; True:C214)
				OBJECT SET ENTERABLE:C238(*; "DE ELEM_PCTSTATE@"; True:C214)
				OBJECT SET RGB COLORS:C628(*; "DE ELEM_QTYSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_QTYSTATE@"; PON_Color_Editable_L)
				OBJECT SET RGB COLORS:C628(*; "DE ELEM_PCTSTATE@"; Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_PCTSTATE@"; PON_Color_Editable_L)
				//also now enable quant and percent radio buttons - unles units are percent
				
				If (Not:C34(PON_ELEMUNIT_txt="percent"))
					OBJECT SET ENABLED:C1123(*; "DE bQuantity"; True:C214)
					OBJECT SET ENABLED:C1123(*; "DE bPercent"; True:C214)
					
				End if 
				
				If ([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7=0) | ([NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21="Y")  //primary or prot.syst. element - Q1 state is not enterable
					
					OBJECT SET ENTERABLE:C238(*; "DE ELEM_QTYSTATE1"; False:C215)
					OBJECT SET ENTERABLE:C238(*; "DE ELEM_PCTSTATE1"; False:C215)
					OBJECT SET RGB COLORS:C628(*; "DE ELEM_QTYSTATE1"; Col_paletteToRGB(Abs:C99(PON_Color_NOTEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NOTEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_QTYSTATE1"; PON_Color_NOTEditable_L)
					OBJECT SET RGB COLORS:C628(*; "DE ELEM_PCTSTATE1"; Col_paletteToRGB(Abs:C99(PON_Color_NOTEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NOTEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_PCTSTATE1"; PON_Color_NOTEditable_L)
					
					If ([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)
						
						[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17:=[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20
						If ([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17<0)
							// Warn that there is an error!
							ALERT:C41("Quantities in States do not add up correctly with Total Quantity!!! Please Adjust!")
							[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17:=0
						End if 
						[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
						[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
						[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
						[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12:=100-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15
						
					Else 
						//if we are showing Percentages - recalc quantities based on percentages leave percentages as is
						[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19:=Round:C94((([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14*[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)/100); PON_RoundQ_L)
						[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20:=Round:C94((([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15*[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)/100); PON_RoundQ_L)
						[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18:=Round:C94((([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13*[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)/100); PON_RoundQ_L)
						[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17:=[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20
						If ([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12=0)
							[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
						Else 
							ALERT:C41("Quantities in States 1,2,3,4 adjusted according to current Percentages!")
						End if 
						
					End if 
					[NTI_ELEM_TIN_INSP:185]ELEM_RATING:24:=NTI_CalculateRating([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19; [NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20)
					
					If (FORM Get current page:C276=2)
						//NEEDSWORKHERE:=True
						//have to add stuff to the add Element button 
						FORM GOTO PAGE:C247(1)
						If ([NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21="Y")
							//hide the prot syst stuff
							OBJECT SET VISIBLE:C603(*; "@PON_NBE_Prot_@"; False:C215)
						End if 
					End if 
					
				Else   //defect
					
					ARRAY POINTER:C280($CSQ_aptr; 4)
					$CSQ_aptr{1}:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17
					$CSQ_aptr{2}:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18
					$CSQ_aptr{3}:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19
					$CSQ_aptr{4}:=->[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20
					ARRAY POINTER:C280($CSPCT_aptr; 4)
					$CSPCT_aptr{1}:=->[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12
					$CSPCT_aptr{2}:=->[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13
					$CSPCT_aptr{3}:=->[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14
					$CSPCT_aptr{4}:=->[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15
					C_LONGINT:C283($CS_L; $FirstCSQ_L)
					$FirstCSQ_L:=0
					For ($CS_L; 1; 4)
						If (PON_ElemNoQuantityFlag_L ?? $CS_L)
							//zero q in this state
							$CSQ_aptr{$CS_L}->:=0
							$CSPCT_aptr{$CS_L}->:=0
							OBJECT SET ENTERABLE:C238(*; "DE ELEM_QTYSTATE"+String:C10($CS_L); False:C215)
							OBJECT SET ENTERABLE:C238(*; "DE ELEM_PCTSTATE"+String:C10($CS_L); False:C215)
							OBJECT SET RGB COLORS:C628(*; "DE ELEM_QTYSTATE"+String:C10($CS_L); Col_paletteToRGB(Abs:C99(PON_Color_NOTEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NOTEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_QTYSTATE"+String($CS_L); PON_Color_NOTEditable_L)
							OBJECT SET RGB COLORS:C628(*; "DE ELEM_PCTSTATE"+String:C10($CS_L); Col_paletteToRGB(Abs:C99(PON_Color_NOTEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NOTEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_PCTSTATE"+String($CS_L); PON_Color_NOTEditable_L)
							
						Else 
							OBJECT SET ENTERABLE:C238(*; "DE ELEM_QTYSTATE"+String:C10($CS_L); True:C214)
							OBJECT SET RGB COLORS:C628(*; "DE ELEM_QTYSTATE"+String:C10($CS_L); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_QTYSTATE"+String($CS_L); PON_Color_Editable_L)
							
							If ($FirstCSQ_L=0)  //first cond state w Q
								//disable percent only
								$FirstCSQ_L:=$CS_L
								OBJECT SET ENTERABLE:C238(*; "DE ELEM_PCTSTATE"+String:C10($CS_L); False:C215)
								OBJECT SET RGB COLORS:C628(*; "DE ELEM_PCTSTATE"+String:C10($CS_L); Col_paletteToRGB(Abs:C99(PON_Color_NOTEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NOTEditable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_PCTSTATE"+String($CS_L); PON_Color_NOTEditable_L)
								
							Else 
								OBJECT SET ENTERABLE:C238(*; "DE ELEM_PCTSTATE"+String:C10($CS_L); True:C214)
								OBJECT SET RGB COLORS:C628(*; "DE ELEM_PCTSTATE"+String:C10($CS_L); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_Editable_L)\256))  // **Replaced o OBJECT SET COLOR(*; "DE ELEM_PCTSTATE"+String($CS_L); PON_Color_Editable_L)
								
							End if 
							
						End if 
					End for 
					
					//no reason to set enterable and change colors - that's done when defect is selected
					
					//update condition state data
					If ([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)  //showing quantities
						//adjust Qs by removing from total Q high level states
						$CSQ_aptr{$FirstCSQ_L}->:=[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21
						$CSPCT_aptr{$FirstCSQ_L}->:=100
						
						For ($CS_L; $FirstCSQ_L+1; 4)
							If (PON_ElemNoQuantityFlag_L ?? $CS_L)
							Else 
								$CSQ_aptr{$FirstCSQ_L}->:=Round:C94((($CSQ_aptr{$FirstCSQ_L}->)-($CSQ_aptr{$CS_L}->)); PON_RoundQ_L)
								$CSPCT_aptr{$CS_L}->:=Round:C94((100*($CSQ_aptr{$CS_L}->))/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
								$CSPCT_aptr{$FirstCSQ_L}->:=($CSPCT_aptr{$FirstCSQ_L}->)-($CSPCT_aptr{$CS_L}->)
							End if 
						End for 
						//check for error - low state Q < 0
						If (($CSQ_aptr{$FirstCSQ_L}->)<0)  //error - set Q to 0
							
							ALERT:C41("Quantities in States do not add up correctly with Total Quantity!!! Please adjust before saving element!!")
							$CSQ_aptr{$FirstCSQ_L}->:=0
							$CSPCT_aptr{$FirstCSQ_L}->:=0
						End if 
						
					Else   //showing percent
						//recalc quantities based on current percentages - double check percentages
						$CSQ_aptr{$FirstCSQ_L}->:=[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21
						$CSPCT_aptr{$FirstCSQ_L}->:=100
						
						For ($CS_L; $FirstCSQ_L+1; 4)
							
							If (PON_ElemNoQuantityFlag_L ?? $CS_L)
							Else 
								$CSPCT_aptr{$FirstCSQ_L}->:=Round:C94(($CSPCT_aptr{$FirstCSQ_L}->)-($CSPCT_aptr{$CS_L}->); PON_RoundP_L)
								$CSQ_aptr{$CS_L}->:=Round:C94((($CSPCT_aptr{$CS_L}->)*[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)/100; PON_RoundQ_L)
								$CSQ_aptr{$FirstCSQ_L}->:=($CSQ_aptr{$FirstCSQ_L}->)-($CSQ_aptr{$CS_L}->)
							End if 
						End for 
						//check for any error QT of lowest state < 0
						If (($CSQ_aptr{$FirstCSQ_L}->)<0)
							ALERT:C41("Error in percentage calculations! Please adjust before saving element!")
							$CSQ_aptr{$FirstCSQ_L}->:=0
							$CSPCT_aptr{$FirstCSQ_L}->:=0
						Else 
							ALERT:C41("Quantities in Condition States adjusted according to current Percentages!")
						End if 
						
					End if 
					
					If (False:C215)  //old way with PON_ElemNoQuantState1_b
						If (PON_ElemNoQuantState1_b)
							//lock pct fields for state 2 ; and qty for st 1 qty is enabled
							OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; False:C215)
							OBJECT SET ENTERABLE:C238([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; False:C215)
							OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_QTYSTATE1; PON_Color_NotEditable_L)
							OBJECT SET RGB COLORS:C628([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13; Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)%256); Col_paletteToRGB(Abs:C99(PON_Color_NotEditable_L)\256))  // **Replaced o OBJECT SET COLOR([NTI_ELEM_TIN_INSP]ELEM_PCTSTATE2; PON_Color_NotEditable_L)
							
							If ([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)
								//showing quantites
								[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18:=Round:C94([NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20; PON_RoundQ_L)
								If ([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18<0)
									// Warn that there is an error!
									ALERT:C41("Quantities in States do not add up correctly with Total Quantity!!! Please Adjust!")
								End if 
								[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
								[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
								[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13:=100-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15
							Else 
								//if we are showing Percentages - recalc quantities based on percentages leave percentages as is
								[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19:=Round:C94((([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14*[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)/100); PON_RoundQ_L)
								[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20:=Round:C94((([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15*[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)/100); PON_RoundQ_L)
								[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18:=[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20
								If ([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13=0)
									[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
								Else 
									ALERT:C41("Quantities in States 2,3,4 adjusted according to current Percentages!")
								End if 
							End if 
							
						Else 
							
							If ([NTI_ELEM_TIN_INSP:185]ELEM_QorP:16)
								
								[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17:=[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20
								If ([NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17<0)
									// Warn that there is an error!
									ALERT:C41("Quantities in States do not add up correctly with Total Quantity!!! Please Adjust!")
								End if 
								[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
								[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
								[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
								[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12:=100-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15
								
							Else 
								//if we are showing Percentages - recalc quantities based on percentages leave percentages as is
								[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19:=Round:C94((([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14*[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)/100); PON_RoundQ_L)
								[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20:=Round:C94((([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15*[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)/100); PON_RoundQ_L)
								[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18:=Round:C94((([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13*[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21)/100); PON_RoundQ_L)
								[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17:=[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19-[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20
								If ([NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12=0)
									[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
								Else 
									ALERT:C41("Quantities in States 1,2,3,4 adjusted according to current Percentages!")
								End if 
								
							End if 
							
						End if 
						
					End if 
					
				End if 
				
		End case 
		
End case 
//End NTI_ElemQuantity_OM