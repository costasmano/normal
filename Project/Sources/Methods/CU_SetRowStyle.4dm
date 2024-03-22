//%attributes = {"invisible":true}
//Method: CU_SetRowStyle
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/09/19, 12:12:57
	// ----------------------------------------------------
	//Created : 
	Mods_2019_05
End if 
//
C_LONGINT:C283($1)
C_LONGINT:C283($i; $NoCSs)

C_POINTER:C301($Var_ptr)
$NoCSs:=$1
C_TEXT:C284($Temp_txt)
For ($i; 1; 5)
	//Negative value is displayed as blank.  
	a_ptr_NewCS{$i}->:=-1  //Pointer to vNewCSi
	$Var_ptr:=Get pointer:C304("LB_Detail"+String:C10($i)+"_txt")
	
	If ($i<=$NoCSs)
		
		Case of 
			: (([Cond Units:45]Percent:6) & ([Cond Units:45]Total Quantity:5>0))
				//Convert to Percent of Total.
				a_ptr_CS{$i}->:=Round:C94(100*(a_ptr_CSfld{$i}->/[Cond Units:45]Total Quantity:5); 1)
				$Temp_txt:=String:C10(a_ptr_CS{$i}->; "##0.0 %")  //OBJECT SET FORMAT(a_ptr_CS{$i}->;"##0.0 %;")
			: ([BMS Inspections:44]Metric:14)
				//Display metric quantity.
				a_ptr_CS{$i}->:=Round:C94(a_ptr_CSfld{$i}->; 1)
				$Temp_txt:=String:C10(a_ptr_CS{$i}->; "#,###,##0.0")
				//OBJECT SET FORMAT(a_ptr_CS{$i}->;"#,###,##0.0;")
			Else 
				//Display English quantity.
				a_ptr_CS{$i}->:=Round:C94(AnglicizeQ(a_ptr_CSfld{$i}->; [BMS Elements:47]Units:6); 1)
				$Temp_txt:=String:C10(a_ptr_CS{$i}->; "#,###,##0.0")
				//OBJECT SET FORMAT(a_ptr_CS{$i}->;"#,###,##0.0;")
		End case 
		
	Else 
		//OBJECT SET FORMAT(a_ptr_CS{$i}->;"#,###,##0.0;")
		//A value of -1 indicates non-displayable.
		a_ptr_CS{$i}->:=-1
		//Gray out unused Condition States.
		//Black on Light Gray -(15+(256*12)).
		// SET COLOR(a_ptr_CS{$i}»;-(15+(256*12)))
		$Temp_txt:=""
	End if 
	
	$Var_ptr->:=$Temp_txt
End for 
//ALERT("Test1_txt is "+LB_Detail1_txt+Char(Carriage return)+"Test2_txt is "+LB_Detail2_txt+Char(Carriage return)+"Test3_txt is "+LB_Detail3_txt+Char(Carriage return)+"Test4_txt is "+LB_Detail4_txt+Char(Carriage return)+"Test5_txt is "+LB_Detail5_txt)\




//End CU_SetRowStyle