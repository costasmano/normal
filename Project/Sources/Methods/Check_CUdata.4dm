//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/11/05, 16:06:08
	// ----------------------------------------------------
	// Method: Check_CUdata
	// Description
	// Runs data checks on current [Cond Units] record
	//
	// Parameters
	// ----------------------------------------------------
	
	Mods_2005_CM17
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

C_TEXT:C284($0; $Error_txt)
ARRAY TEXT:C222($ErrorCause_atxt; 0)
C_LONGINT:C283(ElementNo_L; $Total_l; $CompareTotal_l)
C_REAL:C285($Total_r)
C_BOOLEAN:C305($Error_b)
$Error_b:=False:C215
$Error_txt:=""
If ([Cond Units:45]Total Quantity:5<=0)
	INSERT IN ARRAY:C227($ErrorCause_atxt; 1; 1)
	$ErrorCause_atxt{1}:=" [Cond Units]Total Quantity<=0"
	$Error_b:=True:C214
End if 

Case of 
	: ([Cond Units:45]CondState1:10>0)
	: ([Cond Units:45]CondState2:11>0)
	: ([Cond Units:45]CondState3:12>0)
	: ([Cond Units:45]CondState4:13>0)
	: ([Cond Units:45]CondState5:14>0)
	Else 
		INSERT IN ARRAY:C227($ErrorCause_atxt; 1; 1)
		$ErrorCause_atxt{1}:=" [Cond Units]CondState1-5 all=0"
		$Error_b:=True:C214
End case 
If ([Cond Units:45]Element ID:3=0)
	INSERT IN ARRAY:C227($ErrorCause_atxt; 1; 1)
	$ErrorCause_atxt{1}:=" [Cond Units]Element ID = 0"
	$Error_b:=True:C214
	ElementNo_L:=0
Else 
	QUERY:C277([BMS Elements:47]; [BMS Elements:47]Element ID:1=[Cond Units:45]Element ID:3)
	ElementNo_L:=[BMS Elements:47]Element No:2
	If ([BMS Elements:47]Units:6="EA")
		$Total_l:=0
		If ([Cond Units:45]CondState1:10<0)
		Else 
			$Total_l:=Round:C94([Cond Units:45]CondState1:10; 0)
		End if 
		If ([Cond Units:45]CondState2:11<0)
		Else 
			$Total_l:=$Total_l+Round:C94([Cond Units:45]CondState2:11; 0)
		End if 
		If ([Cond Units:45]CondState3:12<0)
		Else 
			$Total_l:=$Total_l+Round:C94([Cond Units:45]CondState3:12; 0)
		End if 
		If ([Cond Units:45]CondState4:13<0)
		Else 
			$Total_l:=$Total_l+Round:C94([Cond Units:45]CondState4:13; 0)
		End if 
		If ([Cond Units:45]CondState5:14<0)
		Else 
			$Total_l:=$Total_l+Round:C94([Cond Units:45]CondState5:14; 0)
		End if 
		
		If ($Total_l#(Round:C94([Cond Units:45]Total Quantity:5; 0)))
			INSERT IN ARRAY:C227($ErrorCause_atxt; 1; 1)
			$ErrorCause_atxt{1}:=" EA [Cond Cond Units]CondState1 - 5 not equal [Cond Units]Total Quantity ("+String:C10($Total_l)+"#"+String:C10(Round:C94([Cond Units:45]Total Quantity:5; 0))+")"
			$Error_b:=True:C214
		End if 
		
	Else 
		
		$Total_r:=0
		If ([Cond Units:45]CondState1:10<0)
		Else 
			$Total_r:=Round:C94([Cond Units:45]CondState1:10; 6)
		End if 
		If ([Cond Units:45]CondState2:11<0)
		Else 
			$Total_r:=$Total_r+Round:C94([Cond Units:45]CondState2:11; 6)
		End if 
		If ([Cond Units:45]CondState3:12<0)
		Else 
			$Total_r:=$Total_r+Round:C94([Cond Units:45]CondState3:12; 6)
		End if 
		If ([Cond Units:45]CondState4:13<0)
		Else 
			$Total_r:=$Total_r+Round:C94([Cond Units:45]CondState4:13; 6)
		End if 
		If ([Cond Units:45]CondState5:14<0)
		Else 
			$Total_r:=$Total_r+Round:C94([Cond Units:45]CondState5:14; 6)
		End if 
		$Total_l:=Round:C94($Total_r; 0)
		$CompareTotal_l:=Round:C94([Cond Units:45]Total Quantity:5; 0)
		Case of 
			: (Abs:C99($CompareTotal_l-$Total_l)<=1)
			: ($Total_l=$CompareTotal_l)
			: ($Total_l+1=$CompareTotal_l)
			: ($Total_l-1=$CompareTotal_l)
			Else 
				INSERT IN ARRAY:C227($ErrorCause_atxt; 1; 1)
				$ErrorCause_atxt{1}:=" [Cond Cond Units]CondState1 - 5 not equal [Cond Units]Total Quantity ("+String:C10($Total_l)+"#"+String:C10($CompareTotal_l)+")"
				$Error_b:=True:C214
		End case 
		
	End if 
	
End if 
If ([Cond Units:45]Environment:4<=0) | ([Cond Units:45]Environment:4>4)
	INSERT IN ARRAY:C227($ErrorCause_atxt; 1; 1)
	$ErrorCause_atxt{1}:=" [Cond Units]Environment<=0) | ([Cond Units]Environment>4"
	$Error_b:=True:C214
End if 
If (Check_DupCU)
	INSERT IN ARRAY:C227($ErrorCause_atxt; 1; 1)
	$ErrorCause_atxt{1}:=" Duplicate CU found"
	$Error_b:=True:C214
End if 
C_LONGINT:C283($InnerLoop_l)
If ($Error_b)
	For ($InnerLoop_l; 1; Size of array:C274($ErrorCause_atxt))
		$Error_txt:=$Error_txt+$ErrorCause_atxt{$InnerLoop_l}+Char:C90(9)
	End for 
End if 
$0:=$Error_txt
$Error_txt:=""