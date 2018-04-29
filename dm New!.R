#---------------------------------------------------------------------------------------------#
###############
##############
#############
############
###########
##########
#########
########
#######
######
#####
####
###
##
#----------------------------------------�M����-----------------------------------------------#                            
#---�ھڨ��ֻP�s�W����---#

library("rattle")
library("rpart")
library("rpart.plot")
library("rattle")
library("AER")

E55 <- read.csv(file = "car4.csv", head=TRUE, sep = ",")
E55 <- subset(E55 ,select = c(CARTYPE,CARAGE,CARNO,CARCOLOR,ADDR1,COMPANY))


E55$CARAGE <- ifelse(E55$CARAGE == "2005",1,0);


E55[is.na(E55)]<-0

#----���o�`����
n<-nrow(E55)

#----�]�w�H���ƺؤl
set.seed(18000)

#----�N�ƾڶ��ǭ��s�ƦC
E63<-E55[sample(n),]

#----���X�˥��ƪ�SLR
SLR <- sample(seq_len(n),size = round(0.7*n))

#----�V�m��ƻP���ո�Ƥ��: 70%�ؼҡA30%����
trainE55 <- E63[SLR,]
testE55  <- E63[-SLR,]

#---�إߨM����ҫ� 
dtreeM <- rpart(formula = CARAGE ~ .,data = trainE55,
                method = "class",control = rpart.control(cp = 0.001))

dtreeM



#######################################################################################################

S600 <- predict(dtreeM, newdata = testE55, type = "class")

##�إ߲V�c�x�}�[��ҫ����{--##
AMG_GT <- table(testE55$CARAGE, S600, dnn = c("���", "�w��"))
AMG_GT

###-�w���~����2005�~�ǽT�v--###


#���G�v
AMG_GT[4] / sum(AMG_GT[, 2])

#�����G�v
AMG_GT[1] / sum(AMG_GT[, 1])

#����ǽT�v(���X�﨤/�`��)
accuracy <- sum(diag(AMG_GT)) / sum(AMG_GT)
accuracy


#######################################################################################################


(length((which(E55[,5] == 2005)))/( sum(table(E55$CARAGE))))         

length(which(E55[,5] == 2005))
  