
ny = read.csv('new_york_city.csv')
wash = read.csv('washington.csv')
chi = read.csv('chicago.csv')

head(ny)

head(wash)

head(chi)

#Combine New York and Chicago
x = rbind(ny,chi)
common_cols <- intersect(colnames(x), colnames(wash))
#Combine with Washington on common Columns
y = rbind(
  subset(x, select = common_cols), 
  subset(wash, select = common_cols)
)
#Provide summary
summary(y)

df <- y %>%
    group_by(Start.Station) %>%
    summarise(count = n()) %>%
    top_n(n = 5, wt = count)
ggplot(df, aes(x = Start.Station, y = count)) +
    geom_col() +
    facet_wrap(~Start.Station, scales = "free")
#Visualization for top 5 stations

#Provide summary
summary(y)

counts <- table(data = subset(y, !is.na(User.Type))$User.Type)
barplot(counts, main="User Distribution",
   xlab="User Type", ylab="Count of Users")

#Provide summary
summary(x)

counts <- table(data = subset(x, !is.na(Gender))$Gender)
barplot(counts, main="Gender Distribution",
   xlab="Gender", ylab="Count of Gender")


system('python -m nbconvert Explore_bikeshare_data.ipynb')
