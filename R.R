demo(dimple)

## example 48 timeAxis
  data( dat1)

dat1$total_case_daily_change = format(dat11$total_case_daily_change, "%Y-%m-%d")

d1 <- dPlot(
  x = "date",
  y = "uempmed",
  data = dat1,
  type = "line",
  height = 400,
  width = 700,
  bounds = list(x=50,y=20,width=650,height=300)
  )

d1$xAxis(
  type = "addTimeAxis",
  inputFormat = "%Y-%m-%d",
  outputFormat = "%b %Y"
 )

