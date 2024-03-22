//%attributes = {"invisible":true}
//PROCEDURE TO CALCULATE RYWDTH
//April 23, 2001
//Calculate desirable roadway width.
//This procedure calculates the desirable roadway width for the type of 
//roadway and ADT corresponding to rating code 8 in Tables
//2A,2B,2C,or 2D under Item68 in tenths of a meter.

C_REAL:C285($rywdth; $0)

$rywdth:=0

//TABLE 2A of ITEM68
If (([Bridge MHD NBIS:1]Item102:123="2") & ([Bridge MHD NBIS:1]Item28A:86=2))
	Case of 
		: ([Bridge MHD NBIS:1]Item29:88<=100)
			$rywdth:=9.8
		: (([Bridge MHD NBIS:1]Item29:88<=400) & ([Bridge MHD NBIS:1]Item29:88>100))
			$rywdth:=11
		: (([Bridge MHD NBIS:1]Item29:88<=1000) & ([Bridge MHD NBIS:1]Item29:88>400))
			$rywdth:=12.2
		: ([Bridge MHD NBIS:1]Item29:88>1000)
			$rywdth:=13.4
	End case 
End if 

//TABLE 2B of ITEM68
If (([Bridge MHD NBIS:1]Item102:123="3") & ([Bridge MHD NBIS:1]Item29:88<=100))
	$rywdth:=4.9
End if 

//Use TABLE 2A of Item68 for one lane, one way traffic 
//    per note 3 of tables 2A,2B
If (([Bridge MHD NBIS:1]Item102:123="1") & ([Bridge MHD NBIS:1]Item28A:86=1))
	Case of 
		: ([Bridge MHD NBIS:1]Item29:88<=100)
			$rywdth:=9.8
		: (([Bridge MHD NBIS:1]Item29:88<=400) & ([Bridge MHD NBIS:1]Item29:88>100))
			$rywdth:=11
		: (([Bridge MHD NBIS:1]Item29:88<=1000) & ([Bridge MHD NBIS:1]Item29:88>400))
			$rywdth:=12.2
		: ([Bridge MHD NBIS:1]Item29:88>1000)
			$rywdth:=13.4
	End case 
End if 

//Use TABLE 2A of ITEM68 when ADT>100
//     and 102=3 per coding guide note 5
If (([Bridge MHD NBIS:1]Item102:123="3") & ([Bridge MHD NBIS:1]Item29:88>100))
	Case of 
		: ([Bridge MHD NBIS:1]Item29:88<=400)
			$rywdth:=11
		: (([Bridge MHD NBIS:1]Item29:88<=1000) & ([Bridge MHD NBIS:1]Item29:88>400))
			$rywdth:=12.2
		: ([Bridge MHD NBIS:1]Item29:88>1000)
			$rywdth:=13.4
	End case 
End if 

//Use TABLE2C Other MultiLane Divided Facilities
//   for 3 or more lanes of 2-way traffic. Note 4 of Table 2A,2C
If (([Bridge MHD NBIS:1]Item102:123="2") & ([Bridge MHD NBIS:1]Item28A:86>=3))
	$rywdth:=Round:C94(((3.7*[Bridge MHD NBIS:1]Item28A:86)+5.5); 1)
End if 

//TABLE 2C of ITEM68
If (([Bridge MHD NBIS:1]Item28A:86=2) & ([Bridge MHD NBIS:1]Item102:123="1") & (Substring:C12([Bridge MHD NBIS:1]Item5:59; 3; 1)#"7"))
	$rywdth:=12.8
End if 

If ([Bridge MHD NBIS:1]Item28A:86>2)
	If (([Bridge MHD NBIS:1]Item22:128="01") | ([Bridge MHD NBIS:1]Item22:128="11") | ([Bridge MHD NBIS:1]Item22:128="12"))
		$rywdth:=Round:C94((3.7*([Bridge MHD NBIS:1]Item28A:86)+7.3); 1)
	Else 
		$rywdth:=Round:C94((3.7*([Bridge MHD NBIS:1]Item28A:86)+5.5); 1)
	End if 
End if 

//TABLE 2D of Item 68
If (([Bridge MHD NBIS:1]Item28A:86=1) & ([Bridge MHD NBIS:1]Item102:123="1") & (Substring:C12([Bridge MHD NBIS:1]Item5:59; 3; 1)="7"))
	$rywdth:=7.9
End if 
If (([Bridge MHD NBIS:1]Item28A:86>=2) & ([Bridge MHD NBIS:1]Item102:123="1") & (Substring:C12([Bridge MHD NBIS:1]Item5:59; 3; 1)="7"))
	$rywdth:=Round:C94((3.7*([Bridge MHD NBIS:1]Item28A:86)+3.7); 1)
End if 

$0:=$rywdth