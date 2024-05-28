**Question1**
mean wage if asian==1 & female==1
mean wage if black==1 & female==1
/*The average wage earned by a black woman is 18.21848 and the average wage earned
by an asian woman is 21.38277, hence the asian woman on a average earn 3.16429*/

**Question2**
mean educ if asian==1 & female==1
mean educ if black==1 & female==1
**SPECIFIC TESTING PARAMETERS
gen var1=0 if asian==1 & female==1
replace var1=1 if black==1 & female==1
label define var1 0 "Asian Female" 1 "Black Female"
label value var1 var1
ttest educ, by(var1)
/*Except for the fact that the education distribution of the black women is 
concentrated around 12 years of eduction, the asian women have more percentage of 
women in each of the level of education than the black women*/

**ASIAN WOMEN ARE MORE EDUCATED THAT THE BLACK WOMEN

**Question3**
*a
generate more_work=1 if hrswk>60
replace more_work=0 if hrswk<=60
label define more_work 0 "Works Less" 1 "Works More"
label value more_work more_work

*b
label variable more_work "=1, if working more that 60 hours per week"

*c
tab more_work if asian==1
tab more_work if black==1

histogram more_work if asian==1, discrete percent barwidth(0.8) addlabel xlabel(0 "Work Less" 1 "Work More")
histogram more_work if black==1, discrete percent barwidth(0.8) addlabel xlabel(0 "Work Less" 1 "Work More")

/*Among the black people only 0.89% of the people work hard, bu among the 
asian peole 4.65% of the people work hard*/

/*EXTRA- Can use by(catvar) to categorize it further into different histogram
for each group.*/

**Question 4**
recode educ (0/6=1) (7/11=2) (12/13=3) (14/21=4), gen(reduc)
label define reduc 1 "Primary" 2 "Secondary" 3 "Higher-Secondary" 4 "Graduate and above"
label value reduc reduc
order reduc, after(educ)

/* So there are 4 categories so we could create 3 dummies for them to avoid dummy variable trap*/

gen primary=1 if reduc==1
replace primary=0 if reduc>1
label variable primary "=1,primary education level"

gen secondary=1 if reduc==2
replace secondary=0 if reduc>2 | reduc==1
label variable secondary "=1,secondary education level"

gen high_sec=1 if reduc==3
replace high_sec=0 if reduc>3 | reduc<3
label variable high_sec "=1,higher secondary education level"

order primary,after(reduc)
order secondary,after(primary)
order high_sec,after(secondary)

tab primary
tab secondary
tab high_sec

**Question 5**
graph matrix wage educ exper hrswk, diagonal(, color(white)) mcolor(midblue) ///
msymbol(circle) title(Scatterplot Matrix)

**Question 6**
generate lwage=log(wage)
generate lexper=log(exper)
scatter lwage lexper
twoway(scatter lwage lexper) (lfit lwage lexper) // EXTRA
**Slight positive correlation

**Question 7**
regress wage educ exper
**Regression Equation= wage=-11.751+2.068educ+0.1446exper

**INDIVIDUAL TEST
ttest educ=0
**H0 for mean(educ)=0 is rejected as p value is 0.00
ttest exper=0
**H0 for mean(exper)=0 is rejected as p value is 0.00

**JOINT TEST
test educ=exper=0 // same as test educ exper
**H0:educ=exper=0 is rejected as p value is 0.00

**Question 8**
regress wage exper i.metro ib3.reduc
**Here we have selected higher secondary education to be the base 
regress wage exper i.metro ib4.reduc //EXTRA- Base as Graduate and above

/*We will have different values corresponding to the different levels of eductaion 
as per reduc*/

**Question 9**
regress wage exper i.metro ib3.reduc
*a
rvfplot,yline(0)
/* There is some sort of a trend in the data between the residuals and the 
fitted values hence there is heteroscedasticity*/
*b
estat hettest
**Here too the H0 of constant variance is rejected**

**Question 10**
**Robust command is used to give unbiased standard errors in the regression analysis
regress wage exper i.metro ib3.reduc,robust

**Question 11**
by female, sort : summarize wage
/*INTERPRETATION- Mean wages for male workers are higher.
Hwever, maximum wages of 76.39 are received by female workers.*/

by married female, sort : summarize wage
/*INTERPRETATION- Mean Wages for married male workers are the highest.
Maximum wages are received by the female unmarried workers*/

**Question 12**
* - USED TO COMMENT IN A SINGLE LINE

// - STATA DOESN'T RUN ANHYTHING WRITTEN AFTER //. USED TO COMMENT OUT OF A CODE
tab educ if female==1 // & asian==1-> Here the // could be removed later just to run the code later

/// - TO CHANGE LINES IN THE CODE
tab educ  ///
if female==1 & asian==1

