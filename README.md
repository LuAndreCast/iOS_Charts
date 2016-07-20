

In order to run program, you just must have a Shinobi Trial Key, get your trial key at https://www.shinobicontrols.com/


Make sure to update the file 'Constants.swift' with your trial key.

############################################

//delegate methods:

/* returns the number of points for a series/chart */
- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart


/* returns an Series object, for a given chart */
-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index 


/* returns the number of series in chart */
- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex


/* returns the data point at a specified index for a series/chart */
- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex


