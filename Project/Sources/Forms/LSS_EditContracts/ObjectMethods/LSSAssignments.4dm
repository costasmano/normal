  //Method: "LSS_EditContracts".LSSAssignments
  //Description
  //
  // Parameters
  // ----------------------------------------------------
If (False:C215)
	  // ----------------------------------------------------
	  //User name (OS): Costas Manousakis
	  //User (4D) : Designer
	  //Created : 
	  //Date and time: Feb 29, 2024, 18:42:34
	Mods_2024_LSS_1 
	  // ----------------------------------------------------
	
End if 
  //
C_LONGINT:C283($col;$row)
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Contextual click:C713)
			  //ALERT("right click")
			  //which column
			LISTBOX GET CELL POSITION:C971(*;"LSSAssignments";$col;$row)
			
			If ($row>0)
				  //click on a assignment
				
				Case of 
					: ($col=1)
						  //ask for new contract number
						C_LONGINT:C283($newNum_L)
						$newNum_L:=Num:C11(Request:C163("Enter new assignment number";String:C10(Form:C1466.currassign.assignnum)))
						  //need to check if assignment number exists already
						If (OK=1)
							
							Case of 
								: ($newNum_L<=0)
									ALERT:C41("Cannot have assignment less than or equal to zero! ["+String:C10($newNum_L)+"]")
								: ($newNum_L=Form:C1466.currassign.assignnum)
									  //same number - no change
								Else 
									
									If (Form:C1466.CurrContract.Assignments.query("assignnum = :1";$newNum_L).length>0)
										ALERT:C41("Assignment number "+String:C10($newNum_L)+" already exists!")
									Else 
										Form:C1466.currassign.assignnum:=$newNum_L
										Form:C1466.CurrContract.Assignments:=Form:C1466.CurrContract.Assignments.orderBy("assignnum asc")
										
									End if 
									
							End case 
							
						End if 
						
					: ($col=2)
						  //date
						C_TEXT:C284($date_txt)
						$date_txt:=Request:C163("Enter new NTP date";String:C10(Form:C1466.currassign.ntpdate;Internal date short:K1:7))
						C_DATE:C307($newdate_d)
						$newdate_d:=Date:C102($date_txt)
						If (OK=1)
							
							If ($newdate_d#!00-00-00!) & ($newdate_d>Add to date:C393(Current date:C33;-20;0;0)) & ($newdate_d<Add to date:C393(Current date:C33;20;0;0))
								Form:C1466.currassign.ntpdate:=String:C10($newdate_d;Internal date short:K1:7)
							Else 
								ALERT:C41("Invalid date entered "+$date_txt)
							End if 
							
						End if 
						
				End case 
				
			End if 
		End if 
		
	: (Form event code:C388=On Before Data Entry:K2:39)
		LISTBOX GET CELL POSITION:C971(*;"LSSAssignments";$col;$row)
		Form:C1466.oldassign:=New object:C1471("assignnum";Form:C1466.currassign.assignnum;"ntpdate";Form:C1466.currassign.ntpdate)
		
	: (Form event code:C388=On Data Change:K2:15)
		LISTBOX GET CELL POSITION:C971(*;"LSSAssignments";$col;$row)
		
		Case of 
			: ($col=1)
				  //changed assign num
				C_LONGINT:C283($count_L)
				$count_L:=Form:C1466.CurrContract.Assignments.query("assignnum = :1";Form:C1466.currassign.assignnum).length
				
				If ($count_L>1)
					ALERT:C41("Assignment number "+String:C10(Form:C1466.currassign.assignnum)+" exists already! Reverting to previous number")
					Form:C1466.currassign.assignnum:=Form:C1466.oldassign.assignnum
				Else 
					  //Form.CurrContract.Assignments:=Form.CurrContract.Assignments.orderBy("assignnum asc")
					  //ALERT("Curr assign "+String(Form.currassign.assignnum)+" curr indx "+String(Form.currassignpos)+\
						" new indx "+String(Form.CurrContract.Assignments.indexOf(Form.currassign)))
					  //Form.currassignpos:=Form.CurrContract.Assignments.indexOf(Form.currassign)+1
					
				End if 
				
			: ($col=2)
				  //changed ntpdate
				C_DATE:C307($newdate_d)
				$newdate_d:=Date:C102(Form:C1466.currassign.ntpdate)
				If ($newdate_d>Add to date:C393(Current date:C33;-20;0;0)) & ($newdate_d<Add to date:C393(Current date:C33;20;0;0))
					Form:C1466.currassign.ntpdate:=String:C10($newdate_d;Internal date short:K1:7)
				Else 
					ALERT:C41("Invalid date! "+Form:C1466.currassign.ntpdate)
					Form:C1466.currassign.ntpdate:=Form:C1466.oldassign.ntpdate
				End if 
				
		End case 
		
End case 
  //End LSS_EditContracts.LSSAssignments   