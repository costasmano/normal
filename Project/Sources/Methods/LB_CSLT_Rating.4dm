//%attributes = {"invisible":true}
//Method: LB_CSLT_Rating
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 06/18/20, 13:37:53
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06  //Modified by: CJ (6/18/20 14:07:25)
	//Move code from single user to this to upgrade to use list boxes
	Mods_2020_10  //Fix sort direction issue where pointer was not set correctly
	//Modified by: CJ (10/6/20 13:35:45)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-05T00:00:00 09:25:26)
	Mods_2021_10
	//  `enable on after sort on LB ; clean up sort code ; unload record at end of sorting
End if 
//
C_LONGINT:C283($0)
$0:=0
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET TITLE:C194(*; "Contract_Ass"; "Contract/"+Char:C90(Carriage return:K15:38)+"Assign No.")
		OBJECT SET TITLE:C194(*; "Contract_Type"; "Contract"+Char:C90(Carriage return:K15:38)+"Type")
		OBJECT SET TITLE:C194(*; "City_Town"; Char:C90(Carriage return:K15:38)+"City/Town")
		OBJECT SET TITLE:C194(*; "Item_8"; Char:C90(Carriage return:K15:38)+"Item 8")
		OBJECT SET TITLE:C194(*; "Item_7"; Char:C90(Carriage return:K15:38)+"Item 7")
		OBJECT SET TITLE:C194(*; "Item_6"; Char:C90(Carriage return:K15:38)+"Item 6")
		OBJECT SET TITLE:C194(*; "Source"; Char:C90(Carriage return:K15:38)+"Source")
		OBJECT SET TITLE:C194(*; "NTP_Date"; "NTP"+Char:C90(Carriage return:K15:38)+"Date")
		OBJECT SET TITLE:C194(*; "1st_Exp"; "1st Expct"+Char:C90(Carriage return:K15:38)+"Sub")
		OBJECT SET TITLE:C194(*; "Recent_Sub"; "Recent"+Char:C90(Carriage return:K15:38)+"Sub")
		OBJECT SET TITLE:C194(*; "NBIS_Letter"; "NBIS"+Char:C90(Carriage return:K15:38)+"Letter")
		OBJECT SET TITLE:C194(*; "Assign_Status"; "Assign"+Char:C90(Carriage return:K15:38)+"Status")
		OBJECT SET TITLE:C194(*; "Rating_Status"; "Rating"+Char:C90(Carriage return:K15:38)+"Status")
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
					ORDER BY:C49([Conslt Rating:63]; [Conslt Rating:63]ContractNoRat:14; >; [Conslt Rating:63]AssignNoRat:12; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Conslt Rating:63]; [Conslt Rating:63]ContractNoRat:14; <; [Conslt Rating:63]AssignNoRat:12; >)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				//: ($NameofObj_txt="LB_Header2_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Conslt Rating];[Conslt Rating]ContractType;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Conslt Rating];[Conslt Rating]ContractType;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
				//: ($NameofObj_txt="LB_Header3_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Conslt Rating];[Bridge MHD NBIS]Town Name;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Conslt Rating];[Bridge MHD NBIS]Town Name;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
				//: ($NameofObj_txt="LB_Header4_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Conslt Rating];[Bridge MHD NBIS]Item8;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Conslt Rating];[Bridge MHD NBIS]Item8;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
				//: ($NameofObj_txt="LB_Header5_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Conslt Rating];[Bridge MHD NBIS]Item7;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Conslt Rating];[Bridge MHD NBIS]Item7;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
				//: ($NameofObj_txt="LB_Header6_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Conslt Rating];[Bridge MHD NBIS]Item6A;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Conslt Rating];[Bridge MHD NBIS]Item6A;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
			: ($NameofObj_txt="LB_Header7_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Conslt Rating:63]; [Conslt Rating:63]CRtgSource:47; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Conslt Rating:63]; [Conslt Rating:63]CRtgSource:47; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				//: ($NameofObj_txt="LB_Header7_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Conslt Rating];[Conslt Rating]ProceedRat;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Conslt Rating];[Conslt Rating]ProceedRat;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
				//: ($NameofObj_txt="LB_Header8_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Conslt Rating];[Conslt Rating]ProceedRat;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Conslt Rating];[Conslt Rating]ProceedRat;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
				//: ($NameofObj_txt="LB_Header9_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Conslt Rating];[Conslt Rating]FirstExpctSubmDate;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Conslt Rating];[Conslt Rating]FirstExpctSubmDate;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
				//: ($NameofObj_txt="LB_Header10_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Conslt Rating];[Conslt Rating]MostRecentSub;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Conslt Rating];[Conslt Rating]MostRecentSub;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
				//: ($NameofObj_txt="LB_Header11_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Conslt Rating];[Conslt Rating]NBISLetter;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Conslt Rating];[Conslt Rating]NBISLetter;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
				//: ($NameofObj_txt="LB_Header12_l")
				//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
				//ORDER BY([Conslt Rating];[Conslt Rating]AssignStatus;>)
				//$SortVariable_ptr->:=1
				//Else 
				//ORDER BY([Conslt Rating];[Conslt Rating]AssignStatus;<)
				//$SortVariable_ptr->:=2
				//End if 
				//$0:=-1
			: ($NameofObj_txt="LB_Header13_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY FORMULA:C300([Conslt Rating:63]; CRTG_RatingStatus; >)
					$SortVariable_ptr->:=1
					
				Else 
					ORDER BY FORMULA:C300([Conslt Rating:63]; CRTG_RatingStatus; <)
					$SortVariable_ptr->:=2
					
				End if 
				$0:=-1
				
		End case 
		UNLOAD RECORD:C212(Current form table:C627->)
		Self:C308->:=$SortVariable_ptr->
		
	: (Form event code:C388=On After Sort:K2:28)
		UNLOAD RECORD:C212(Current form table:C627->)
End case 
//End LB_CSLT_Rating