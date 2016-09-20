

In order to run program, you just must have a Shinobi Trial Key, get your trial key at https://www.shinobicontrols.com/


Make sure to update the file 'Constants.swift' with your trial key.



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

