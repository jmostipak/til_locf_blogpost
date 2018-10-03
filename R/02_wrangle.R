#' the entire data set needs some love, but let's focus in on how we
#' 1) recognize the need for using the last observation carried forward (LOCF)
#' 2) carrying out an LOCF task in R
#' 
#' one of the first things I do after importing data is look at it!

head(sample)
View(sample)

#' one of the things that _immediately_ jumps out to me is the data in the Group column
#' we see a school name (in all caps) followed by 20+ rows of demographic splits
#' then we see _another_ school name, followed by more demographic splits
#' 
#' what we want is to associated those demographic splits with a school
#' we'll start by merging our sample data set with our cref data set

sample_cref <- sample %>% 
  left_join(disd, by = "Group") %>%  
  select(Group, school_name, everything())  # this isn't necessary, but it makes looking at our 
                                            # data a bit easier!

head(sample_cref)
View(sample_cref)

#' when we look at our new data set, `sample_cref`, we see that the school_name column has the
#' correct school name, followed by NAs for all of the demographic splits. the school name is the
#' LOCF, or the last observation (that we want to) carry forward.

sample_cref_fill <- sample_cref %>% 
  fill(school_name)  # we want the NAs in school_name column to be filled in

head(sample_cref_fill)
View(sample_cref_fill)

#' the data at this point is in no way completely tidy, let alone explored or analyzed! feel free
#' to continue on and submit a PR to practice your GitHub skills :)
