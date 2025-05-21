library(tidyverse)
library(readr)

dir()
dir(path = "GDP Data")
"GDP Data/NAD-Andhra_Pradesh-GSVA_cur_2016-17.csv" %>% 
 read_csv()-> df1

view(df1)

"NAD-Andhra_Pradesh-GSVA_cur_2016-17.csv" %>% 
  str_split("-") %>% 
  unlist-> state_name_vector

state_name_vector[2]-> state_name

df1 %>% 
  slice(-c(1,2),names_to = "year", values_to = "gdsp") %>% 
  clean_names() %>% 
  select(-1) %>% 
  mutate(state = st_name) -> ab
# from "GDP Data" folder, exclude GDP.csv and only take NAD Files
dir(path="GDP Data",
    pattern= "NAD")-> state_files
print(state_files)

#step 1 ===
#create for loop and iterate over all files names
dir(path="GDP Data",
    pattern= "NAD")-> state_files
print(state_files)

#step 2===
#extract state names from File name

for(i in state_files){
  print(paste0("File name: ", i))
  i %>% 
    str_split("-") %>% 
    unlist()-> state_name_vector
  
  state_name_vector[2]-> st_name
  print(paste0("state name:", st_name))
    
}

#STEP 3
#read all csv files
for(i in state_files){
  # print(paste0("File name: ",i))
  i %>% 
    str_split("-") %>% 
    unlist()-> state_name_vector
  
  state_name_vector[2]-> st_name
  
  #print(paste0("state name: ", st_name))
  
  #read csv file
  paste0("GDP Data/", i) %>% 
    read_csv()-> st_df1
  st_df1 %>% 
    slice(-c(7,11,27:33)) %>% 
    pivot_longer(-c(1,2), names_to = "year", values_to= "gdsp") %>% 
    clean_names() %>% 
    select(-1) %>% 
    mutate(state = st_name) -> state_df
  print(state_df)
}

#Step4
#read all csv files
#create empty tibble
tempdf<- tibble()
for(i in state_files){
  # print(paste0("File name: ",i))
  i %>% 
    str_split("-") %>% 
    unlist()-> state_name_vector
  
  state_name_vector[2]-> st_name
  
  #print(paste0("state name: ", st_name))
  
  #read csv file
  paste0("GDP Data/", i) %>% 
    read_csv()-> st_df1
  st_df1 %>% 
    slice(-c(7,11,27:33)) %>% 
    pivot_longer(-c(1,2), names_to = "year", values_to= "gsdp") %>% 
    clean_names() %>% 
    select(-1) %>% 
    mutate(state = st_name) -> state_df
  print(state_df)
  
  #row bind each dataframe to tempdf and save in tempdf
  bind_rows(tempdf, state_df)-> tempdf
}

tempdf -> final_statewise_gsdp

View(final_statewise_gsdp)

#step-5 
#save final_statewise_gsdp
final_statewise_gsdp %>% 
write_csv("final_statewise_gsdp.csv")

