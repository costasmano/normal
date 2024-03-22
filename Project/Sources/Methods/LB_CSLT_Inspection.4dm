//%attributes = {"invisible":true}
//Method: LB_CSLT_Inspection
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 06/09/20, 16:09:53
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	//Modified by: CJ (6/18/20 14:07:25)
	//Move code from single user to this to upgrade to use list boxes
	Mods_2020_10  //Fix sort direction issue where pointer was not set correctly
	//Modified by: CJ (10/6/20 13:35:45)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-04T00:00:00 17:49:28)
	Mods_2021_10
	//  `cleaned up sorting code - unload record after sorting
End if 
//
C_LONGINT:C283($0)
$0:=0
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET TITLE:C194(*; "Contract_Ass"; "Contract/"+Char:C90(Carriage return:K15:38)+"Assign No.")
		OBJECT SET TITLE:C194(*; "District_Number"; "Dist"+Char:C90(Carriage return:K15:38)+"No.")
		OBJECT SET TITLE:C194(*; "City_Town"; Char:C90(Carriage return:K15:38)+"City/Town")
		OBJECT SET TITLE:C194(*; "Item_8"; Char:C90(Carriage return:K15:38)+"Item 8")
		OBJECT SET TITLE:C194(*; "Inspection_Type"; Char:C90(Carriage return:K15:38)+"Inspection Type")
		OBJECT SET TITLE:C194(*; "Inspection_Month"; "Insp"+Char:C90(Carriage return:K15:38)+"Month")
		OBJECT SET TITLE:C194(*; "NTP_Date"; "NTP"+Char:C90(Carriage return:K15:38)+"Date")
		OBJECT SET TITLE:C194(*; "Inspection_Received"; "Insp"+Char:C90(Carriage return:K15:38)+"Received")
		OBJECT SET TITLE:C194(*; "Assign_Status"; Char:C90(Carriage return:K15:38)+"Assign Status")
		OBJECT SET TITLE:C194(*; "Electronic_Submittal"; "Electronic"+Char:C90(Carriage return:K15:38)+"Submittal")
		OBJECT SET TITLE:C194(*; "Consultant"; Char:C90(Carriage return:K15:38)+"Consultant")
		
	: (Form event code:C388=On Open Detail:K2:23)
		ut_SetWindowSize("create"; Current method name:C684)
	: (Form event code:C388=On Close Detail:K2:24)
		ut_SetWindowSize("Reset"; Current method name:C684)
	: (Form event code:C388=On Header Click:K2:40)
		
		C_TEXT:C284($NameofObj_txt; $SortVariableName_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		C_POINTER:C301($SortVariable_ptr)
		
		RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)
		//$SortVariableName_txt:=Replace string($NameofObj_txt;"Header";"SortDirection")
		$SortVariable_ptr:=Get pointer:C304($NameofObj_txt)
		
		
		Case of 
			: ($NameofObj_txt="LB_Header1_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]ConContractNo:7; >; [Cons Inspection:64]AssignConNumber:6; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]ConContractNo:7; <; [Cons Inspection:64]AssignConNumber:6; >)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				//: ($NameofObj_txt="LB_Header2_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Cons Inspection];[Bridge MHD NBIS]Item2;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Cons Inspection];[Bridge MHD NBIS]Item2;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
				//: ($NameofObj_txt="LB_Header3_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Cons Inspection];[Bridge MHD NBIS]Town Name;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Cons Inspection];[Bridge MHD NBIS]Town Name;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
				//: ($NameofObj_txt="LB_Header4_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Cons Inspection];[Bridge MHD NBIS]Item8;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Cons Inspection];[Bridge MHD NBIS]Item8;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
			: ($NameofObj_txt="LB_Header5_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]InspType:33; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]InspType:33; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header6_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]InspMonth:34; >; [Bridge MHD NBIS:1]BDEPT:1; >; [Cons Inspection:64]BIN:1; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]InspMonth:34; <; [Bridge MHD NBIS:1]BDEPT:1; <; [Cons Inspection:64]BIN:1; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				//: ($NameofObj_txt="LB_Header7_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Cons Inspection];[Cons Inspection]ProceedConDate;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Cons Inspection];[Cons Inspection]ProceedConDate;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
				//: ($NameofObj_txt="LB_Header8_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Cons Inspection];[Cons Inspection]InspectionRecvd;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Cons Inspection];[Cons Inspection]InspectionRecvd;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
			: ($NameofObj_txt="LB_Header9_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]AssignStatus:24; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]AssignStatus:24; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header10_l")
				CONFIRM:C162("Sorting by this column is very slow! Do you want to proceed?"; "Proceed"; "Cancel")
				If (OK=1)
					If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
						ORDER BY FORMULA:C300([Cons Inspection:64]; QR_ConsInspElecSubm("Sort"); >)
						$SortVariable_ptr->:=1
					Else 
						ORDER BY FORMULA:C300([Cons Inspection:64]; QR_ConsInspElecSubm("Sort"); <)
						$SortVariable_ptr->:=2
					End if 
				End if 
				//ALERT("This column cannot be sorted!")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Conslt Rating];[Conslt Rating]MostRecentSub;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Conslt Rating];[Conslt Rating]MostRecentSub;<)
				//$SortVariable_ptr->:=2
				//End if 
				$0:=-1
				//: ($NameofObj_txt="LB_Header11_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Cons Inspection];[Cons Inspection]AssignConName;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Cons Inspection];[Cons Inspection]AssignConName;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
		End case 
		Self:C308->:=$SortVariable_ptr->
		UNLOAD RECORD:C212(Current form table:C627->)
		
	: (Form event code:C388=On After Sort:K2:28)
		UNLOAD RECORD:C212(Current form table:C627->)
		
End case 

//End LB_CSLT_Inspection