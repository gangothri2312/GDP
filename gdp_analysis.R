library(tidyverse)
library(janitor)

"final_statewise_gsdp.csv" %>% 
  read_csv() %>% 
  rename("sector" = "item")-> statewise_gsdp

statewise_gsdp %>% 
  pull(sector) %>% 
  unique()

#1. for every financial year, which sector has performed well

statewise_gsdp %>% 
  group_by(year, sector) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm = TRUE)) ->df

df %>% 
  group_by(year) %>% 
  arrange(desc(total_gsdp)) %>% 
  slice(1)
  
 

#2. for every financial year, which sector has performed least

statewise_gsdp %>% 
  group_by(year, sector) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm = TRUE)) ->df
df %>% 
  group_by(year) %>% 
  arrange(total_gsdp) %>% 
  slice(1)

#3. for every financial year, which state has performed well

statewise_gsdp %>% 
  group_by(state, year) %>% 
  summarise(total_gsdp= sum(gsdp, na.rm = T)) -> df
df %>% 
  group_by(year) %>% 
  arrange(desc(total_gsdp)) %>% 
  slice(1)

#4. for every financial year, which state has performed least

statewise_gsdp %>% 
  group_by(state, year) %>% 
  summarise(total_gsdp= sum(gsdp, na.rm = T)) -> df
df %>% 
  group_by(year) %>% 
  arrange((total_gsdp))%>%
  slice(1)

#5. top 5 performing sttaes in manufacturing

statewise_gsdp %>% 
  filter(sector== "Manufacturing") %>% 
  group_by(state) %>% 
  summarise(total_gsdp= sum(gsdp, na.rm = T)) -> df
df %>% 
  arrange(desc(total_gsdp)) %>% 
  slice(1:5)

#6. top 5 performing states in construction

statewise_gsdp %>% 
  filter(sector== "Construction") %>% 
  group_by(state) %>% 
  summarise(total_gsdp= sum(gsdp, na.rm = T)) -> df
df %>% 
  arrange(desc(total_gsdp)) %>% 
  slice(1:5)

#7. for finnacial year 2016-17, for every state get top performing sector

statewise_gsdp %>% 
  filter(year== "2016-17") %>% 
  group_by(state, sector) %>% 
  summarise(total_gsdp= sum(gsdp, na.rm = T)) -> df
df %>% 
  arrange(desc(total_gsdp)) %>% 
  slice(1)


#8. for financial year 2016-17. for every state get top 5 performing sectors

statewise_gsdp %>% 
  filter(year== "2016-17") %>% 
  group_by(state, sector) %>% 
  summarise(total_gsdp= sum(gsdp, na.rm = T)) -> df
df %>% 
  arrange(desc(total_gsdp)) %>%
  slice(1:5)

#9. how many states are performing well in manufacturing,(if Manufacturing is in top 3)


df %>% 
  group_by(state) %>% 
  arrange(desc(total_gsdp)) %>% 
  slice(1:3) %>% 
  filter(sector == "Manufacturing") -> no_of_states_in_top3_manufacturing

nrow(no_of_states_in_top3_manufacturing)

#10. What is the GROSS GSDP of Karnataka for all financial years

statewise_gsdp %>% 
  filter(state == "Karnataka") %>% 
  group_by(year) %>% 
  summarise(total_gsdp = sum(gsdp, na.rm = T))

#11. 2015-2016 total gsdp

statewise_gsdp %>% 
  filter(state == "Karnataka", year=="2015-2016") %>% 
  group_by(state,sector) %>% 
  summarise(total_gsdp= sum(gsdp, na.rm = T)) ->df




