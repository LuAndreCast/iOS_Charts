

In order to run program, you just must have a Shinobi Trial Key, get your trial key at https://www.shinobicontrols.com/


Make sure to update the file 'Constants.swift' with your trial key.

##delegate methods:##

###returns the number of points for a series/chart
- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart


###returns an Series object, for a given chart
-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index 


###returns the number of series in chart 
- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex


###returns the data point at a specified index for a series/chart
- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex


****Order of Delegate execution

** Executated 1st - 1 time only **
- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart

** Executated 2nd - For all Series **
- (SChartSeries *)sChart:(ShinobiChart *)chart
seriesAtIndex:(NSInteger)index

** the following are executed right after each other for each series (at a time)

- (NSInteger)sChart:(ShinobiChart *)chart
numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex

- (id<SChartData>)sChart:(ShinobiChart *)chart
dataPointAtIndex:(NSInteger)dataIndex
forSeriesAtIndex:(NSInteger)seriesIndex
