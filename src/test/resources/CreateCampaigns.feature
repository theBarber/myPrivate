Feature: create test data via API 

@campaign 
Scenario Outline: generate campaigns via API only if needed 
	Given Campaign named {<c>} 
	And Campaign named {<c>} has a creative with banner named {<b>} 
	
	And Banner named {<b>} 
	And Zone named {<z>} 
	And Zoneset named {<zs>} 
	And Zone named {<z>} is in the zoneset named {<zs>} 
	And Campaign named {<c>} zoneset list contains the zoneset named {<zs>} 
	
	
	Examples: 
		| c | b | cr |z  | zs | 
		| 75396-197419-Cross Screen Video Blend-2 |75396-197419-251985-Linear Video Ad-VAST unit|cr2 | z2|zs2 |
		| c3|b1 |cr1 | z1|zs1 |
		#    | c2|b2 |cr2 | z1|zs2 |
		#    | c1|b1 |cr2 | z1|zs2 |
    