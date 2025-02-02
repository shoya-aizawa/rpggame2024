

set hashtag_1=#
set hashtag_2=##
set hashtag_3=###
set hashtag_4=####
set hashtag_5=#####
set hashtag_6=######
set hashtag_7=#######
set hashtag_8=########
set hashtag_9=#########
set hashtag_10=##########
set hashtag_11=###########
set hashtag_12=############
set hashtag_13=#############
set hashtag_14=##############
set hashtag_15=###############
set hashtag_16=################
set hashtag_17=#################
set hashtag_18=##################
set hashtag_19=###################
set hashtag_20=####################
set hashtag_21=#####################
set hashtag_22=######################
set hashtag_23=#######################
set hashtag_24=########################
set hashtag_25=#########################




for /l %%a in (1,1,25) do (
    call echo %%hashtag_%%a%%
    for /l %%t in (1,1,50000) do (
        if %%t equ 50000 (cls)
    )
)



