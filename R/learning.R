# Loading packages --------------------------------------------------------

library(tidyverse)
library(NHANES)

# Briefly glimpse contents of dataset
glimpse(NHANES)
str(NHANES)

# Select specific columns -------------------------------------------------

select(NHANES, Age, Weight, BMI)
select(NHANES, -HeadCirc)

select(NHANES, starts_with("BP"))
select(NHANES, ends_with("Day"))
select(NHANES, contains("age")) # Not case sensitive


# Renaming all columns ----------------------------------------------------

rename_with(NHANES, snakecase::to_snake_case)
NHANES_small <- rename_with(NHANES, snakecase::to_snake_case)

# Renaming specific columns -----------------------------------------------

rename(NHANES, sex = Gender)
NHANES_small <- rename(NHANES_small, sex = gender)

# Chaining the functions with the pipe ------------------------------------

colnames(NHANES_small)
NHANES_small %>%
  colnames()

NHANES_small_physically_active <- NHANES_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)

# Exercise 7.8 ------------------------------------------------------------

NHANES_small %>%
  select(bp_sys_ave, education)

NHANES_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

select(NHANES_small, bmi, contains("age"))

NHANES_small %>%
  select(bmi, contains("age"))

NHANES_small %>%
  select(starts_with("bp_")) %>%
  rename(bp_systolic = bp_sys_ave)

# Filtering data by row ---------------------------------------------------

filter(NHANES_small, phys_active == "No")

NHANES_small %>%
    filter(phys_active == "No")

# Participants who are physically active
NHANES_small %>%
    filter(phys_active != "No")

# Participants who have BMI equal to 25
NHANES_small %>%
    filter(bmi == 25)
NHANES_small %>%
    filter(bmi == 25 & phys_active != "No")
NHANES_small %>%
    filter(pregnant_now == "Yes")
NHANES_small %>%
    filter(pregnant_now == "Yes" & phys_active == "No")

# Logic operators
TRUE & TRUE
TRUE & FALSE
FALSE & FALSE

TRUE | TRUE
TRUE | FALSE
FALSE | FALSE

# When BMI is 25 OR phys_active is No
NHANES_small %>%
    filter(bmi == 25 | phys_active == "No")

NHANES_small %>%
    filter(phys_active == "Yes") %>%
    filter(bmi == 25 | phys_active == "No")

# Arranging the rows ------------------------------------------------------

NHANES_small %>%
    arrange(age)
NHANES_small %>%
    arrange(education) %>%
    select(education)
NHANES_small %>%
    arrange(desc(age)) %>%
    select(age)
NHANES_small %>%
    arrange(age, education)
NHANES_small %>%
    arrange(desc(age), education)
NHANES_small %>%
    arrange(desc(age), desc(education))

# Transform or add columns ------------------------------------------------

NHANES_small %>%
    mutate(age = age * 12)
NHANES_small %>%
    mutate(age = age * 12,
           logged_bmi = log(bmi)) %>%
    select(age, logged_bmi)

NHANES_small %>%
    mutate(
        old = if_else(age >= 30, "Yes", "No")
    ) %>%
    select(old)

# Exercise 7.12 -----------------------------------------------------------

# 1. BMI between 20 and 40 with diabetes
NHANES_small %>%
    # Format should follow: variable >= number or character
    filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes")

# Pipe the data into mutate function and:
nhanes_modified <- NHANES_small %>% # Specifying dataset
    mutate(
        # 2. Calculate mean arterial pressure
        mean_arterial_pressure = ((2 * bp_dia_ave) + bp_sys_ave)/3,
        # 3. Create young_child variable using a condition
        young_child = if_else(age <= 6, "Yes", "No")
    )

nhanes_modified
