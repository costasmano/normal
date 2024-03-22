//If ([Conslt Rating]ThirdRepResubmit="")
//If ([Conslt Rating]SecondRepResubmit="")
//[Conslt Rating]MostRecentSub:=[Conslt Rating]FirstRepSubmit
//  Else 
//   [Conslt Rating]MostRecentSub:=[Conslt Rating]SecondRepResubmit
//End if 
//Else 
//[Conslt Rating]MostRecentSub:=[Conslt Rating]ThirdRepResubmit
//End if 


PushChange(1; Self:C308)
[Conslt Rating:63]MostRecentSub:49:=[Conslt Rating:63]RepSubmit1:23
PushChange(1; ->[Conslt Rating:63]MostRecentSub:49)

