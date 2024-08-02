#Gemma Code for ADHD Meta-analysis
#Sophie Mensch

#Installing Packages
if(!requireNamespace("devtools", quietly=T)){
  install.packages("devtools")
}

devtools:: install_github("PavlidisLab/gemma.R", force=T)

install.packages("plyr")

install.packages("tidyverse")

install.packages("dplyr")

#Loading Packages
library(gemma.R)
library(plyr)
library(dplyr)

#Example
AllHippocampusDatasets<- gemma.R ::get_datasets(query ="hippocampus") %>% 
  gemma.R:::get_all_pages()
str(AllHippocampusDatasets)

#Unfiltered ADHD Search
Old_ADHD_Search<- gemma.R ::get_datasets(query ="(ADHD OR \"attention-deficit disorder\" OR \"attention deficit disorder\" OR \"attention-deficit hyperactivity disorder\" OR \"attention deficit hyperactivity disorder\" OR hyperactiv* OR impuls* OR inattenti* OR \"hyperkinetic disorder\" OR \"attention defici*\" OR \"attentional defici*\") OR \"Naples high excitability\" OR  \"Naples high-excitability\" OR \"Spontaneously hypertensive\" OR \"SHR rat\" OR \"Steroid sulfatase defici*\" OR \"Steroid sulfatase knockout\" OR \"Steroid sulfatase knock-out\" OR \"Steroid sulfatase knock-down\" OR \"Steroid sulfatase knockdown\" OR \"STS defici*\" OR \"STS knockout\" OR \"STS knock-out\" OR \"STS knock-down\" OR \"STS knockdown\" OR \"mutation Coloboma\" OR \"Coloboma mutat*\" OR \"CM muta*\" OR \"Dopamine transporter knock-out\" OR \"Dopamine transporter knockout\" OR \"DAT-KO\" OR \"DAT KO\" OR \"DAT knockout\" OR \"DAT hypofunctional\" OR \"DAT-CI\" OR \"DAT CI\" OR \"DAT-knockout\" OR \"DAT knock-out\" OR \"DAT defici*\" OR \"Dopamine transporter muta* \" OR \"Dopamine transporter defici*\" OR \"Dopamine transporter KD\" OR \"Dopamine transporter knockdown*\" OR \"Dopamine transporter knock-down*\" OR \"DAT KD\" OR \"DAT-KD\" OR \"DAT-knockdown*\" OR \"DAT knock-down*\"  OR \"Dopamine 4 KO\" OR \"Dopamine 4 knock-out \" OR \"Dopamine 4 knockout\" OR \"Dopamine D4 receptor KO\" OR \"Dopamine D4 receptor knockout\" OR \"Dopamine D4 receptor knock-out\"") %>% 
  gemma.R:::get_all_pages()
str(Old_ADHD_Search)

Test_ADHD_Search<- gemma.R ::get_datasets(query =" ADHD OR \"attention deficit disorder\" OR \"attention-deficit disorder\" OR \"attention-deficit hyperactivity disorder\" OR \"attention deficit hyperactivity disorder\" OR hyperactiv* OR impuls* OR inattenti* OR \"attentional defici\" OR attention defici* OR \"hyperkinetic disorder\" OR \"Naples high excitability\" OR \"Naples high-excitability\" OR \"Spontaneously hypertensive\" OR \"SHR rat\" OR \"steroid sulfatase knockout\" OR \"steroid sulfatase knock-out\" OR \"steroid sulfatase knock-down\" OR steroid sulfatase knockdown\" OR \"STS defici*\" OR \"STS knock-out\" OR \"STS knockout\" OR \"STS knock-down\" OR \"STS knockdown\" OR \"mutation Coloboma\" OR \"Colomboma muta*\" OR \"CM muta*\" OR \"dopamine transporter knock-out\" OR \"dopamine transporter knockout\" OR \"dopamine transporter knock-down\" OR \"dopamine transporter knockdown\" OR \"DAT-KO\" OR \"DAT KO\" OR \"DAT knockout\" OR \"DAT knock-out\" OR \"DAT hypofunctional\" OR \"DAT defici*\" OR \"DAT-CI\" OR \"DAT-CI\" OR \"DAT-knockout\" OR \"DAT knock-out\" OR \"DAT knock-down\" OR \"DAT knockdown\" OR \"dopamine transporter muta*\" OR \"dopamine transporter KD\" OR \"DAT KD\" OR \"DAT-KD\" OR \"dopamine 4 KO\" OR \"dopamine 4 knock-out\" OR \"dopamine 4 knockout\" OR \"dopamine D4 receptor KO\" OR \"dopamine D4 receptor knockout\" OR \"dopamine D4 receptor knock-out\"") %>% 
  gemma.R:::get_all_pages()
str(Test_ADHD_Search)
#Nearly 5000

ADHDSearch<- gemma.R ::get_datasets(query ="(ADHD OR \"attention deficit disorder\" OR \"attention deficit hyperactivity disorder\" OR hyperactiv* OR impuls* OR inattenti* OR \"hyperkinetic disorder\" OR \"attention defici*\" OR \"attentional defici*\" OR \"Naples high excitability\" OR \"Spontaneously hypertensive\" OR \"SHR rat\" OR \"Steroid sulfatase defici*\" OR \"Steroid sulfatase knockout\" OR \"Steroid sulfatase knockdown\" OR \"STS defici*\" OR \"STS knockout\" OR \"STS knockdown\" OR \"mutation Coloboma\" OR \"Coloboma mutat*\" OR \"CM muta*\" OR \"Dopamine transporter knockout\" OR \"DAT KO\" OR \"DAT knockout\" OR \"DAT hypofunctional\" OR \"DAT CI\" OR \"DAT defici*\" OR \"Dopamine transporter muta* \" OR \"Dopamine transporter defici*\" OR \"Dopamine transporter KD\" OR \"Dopamine transporter knockdown*\" OR \"DAT KD\" OR \"Dopamine 4 KO\" OR \"Dopamine 4 knockout\" OR \"Dopamine D4 receptor KO\" OR \"Dopamine D4 receptor knockout\"") %>% 
  gemma.R:::get_all_pages()
str(ADHDSearch)

QueryTerms<-"ADHD OR \"attention deficit disorder\" OR \"attention deficit hyperactivity disorder\" OR hyperactiv* OR impuls* OR inattenti* OR \"hyperkinetic disorder\" OR \"attention defici*\" OR \"attentional defici*\" OR \"Naples high excitability\" OR \"Spontaneously hypertensive\" OR \"SHR rat\" OR \"Steroid sulfatase defici*\" OR \"Steroid sulfatase knockout\" OR \"Steroid sulfatase knockdown\" OR \"STS defici*\" OR \"STS knockout\" OR \"STS knockdown\" OR \"mutation Coloboma\" OR \"Coloboma mutat*\" OR \"CM muta*\" OR \"Dopamine transporter knockout\" OR \"DAT KO\" OR \"DAT knockout\" OR \"DAT hypofunctional\" OR \"DAT CI\" OR \"DAT defici*\" OR \"Dopamine transporter muta* \" OR \"Dopamine transporter defici*\" OR \"Dopamine transporter KD\" OR \"Dopamine transporter knockdown*\" OR \"DAT KD\" OR \"Dopamine 4 KO\" OR \"Dopamine 4 knockout\" OR \"Dopamine D4 receptor KO\" OR \"Dopamine D4 receptor knockout\""

ADHDSearch_NoFilter<- gemma.R ::get_datasets(query = QueryTerms) %>% 
  gemma.R:::get_all_pages()
ADHDSearch_NoFilter

table(ADHDSearch_NoFilter$taxon.name)
#human (61), mouse (183), rat(54)
table(ADHDSearch_NoFilter$experiment.troubled)
#FALSE 298
table(ADHDSearch_NoFilter$experiment.rawData)
#-1: 47
# 1: 249
result_QueryTerms_RatsMice<- gemma.R ::get_datasets(query=QueryTerms, taxa = c("mouse", "rat")) %>% 
  gemma.R:::get_all_pages() 
str(result_QueryTerms_RatsMice)

result_QueryTerms_RatsMice_Hippocampus <- gemma.R ::get_datasets(query=QueryTerms, filter = 'allCharacteristics.valueUri in (http://purl.obolibrary.org/obo/UBERON_0002421)', taxa = c("mouse", "rat")) %>% 
  gemma.R:::get_all_pages() 
str(result_QueryTerms_RatsMice_Hippocampus)

result_QueryTerms_RatsMice_Hippocampus_Filtered<-result_QueryTerms_RatsMice_Hippocampus[result_QueryTerms_RatsMice_Hippocampus$experiment.troubled==FALSE,]
str(result_QueryTerms_RatsMice_Hippocampus_Filtered)

table(result_QueryTerms_RatsMice_Hippocampus_Filtered$experiment.rawData)


#################################
getwd()
rm()