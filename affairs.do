**Question 1**
tab kids if yrsmarr>4

**92.7% of the couples have kids

**Question 2**
recode relig (5=1) (else=0), gen(veryrel)
label variable veryrel "=1,Very Religious"

recode relig (4=1) (else=0), gen(somewhat_rel)
label variable somewhat_rel "=1,Somewhat Religious"

recode relig (3=1) (else=0), gen(slightly_rel)
label variable slightly_rel "=1,Slightly Religious"

recode relig (2=1) (else=0), gen(not_rel)
label variable not_rel "=1,Not at all Religious"

**Question 3**
recode ratemarr (5=1) (else=0), gen(veryhappy)
label variable veryhappy "=1,Very Happy Marriage"

recode ratemarr (4=1) (else=0), gen(moreavghappy)
label variable moreavghappy "=1,Happier than average"

recode ratemarr (3=1) (else=0), gen(avghappy)
label variable avghappy "=1,Average :)"

recode ratemarr (2=1) (else=0), gen(somewhathappy)
label variable somewhathappy "=1,Somewhat happy :*)"

**Question 4**
regress naffairs age educ i.occup i.kids i.male

**a**
rvfplot,yline(0)
estat hettest
**H0 constant variance is rejected

**b**
predict resid1,r
histogram resid1, normal normopts(lcolor(red) lwidth(thick))

**Question 5**
tab age if naffairs==12 //32 and 37
