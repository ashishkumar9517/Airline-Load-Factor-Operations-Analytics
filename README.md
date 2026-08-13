# Airline-Load-Factor-Operations-Analytics
SQL, Power BI &  Excel analysis of 110,851 U.S. domestic flights (2008-2013), tracking load factor trends, seasonality, and route saturation across 187M+ passengers.



# Airline Performance Analytics Dashboard

Load factor and route analysis on U.S. domestic airline data, 2008 to 2013. Covers 110,851 flights and 187M+ passengers. Built with SQL (MySQL), Excel & Power BI.

## Business Problem

Airlines run on thin margins, and seat utilization (load factor) is one of the clearest levers for profitability. This project looks at six years of flight data to find where capacity is being wasted, which routes and carriers are running efficiently, and where seasonal or geographic patterns could inform pricing and fleet decisions.

## KPIs Tracked

- Overall Load Factor: transported passengers as a percentage of available seats
- Load Factor by year, quarter, and month, to isolate seasonal patterns
- Load Factor by carrier, to compare legacy airlines against charter/leisure operators
- Passenger volume and market share by carrier
- Flight volume by route and by distance group
- Weekend vs. weekday load factor

## Key Findings

Average load factor across the full dataset was 76.8%, and it climbed steadily over the period, from 75.3% in 2008 to 78.1% in 2013. That's a 2.8 percentage point gain, most of it recovery from the 2008 financial crisis rather than a one-off spike.

Seasonality is sharp. July peaks at 81.5%, January bottoms out at 69.7%, an 11.8 point spread. Q3 runs strongest overall at 79.1%, driven by summer leisure travel, while Q1 sits at 73.0% and looks like the clearest target for capacity right-sizing.

Weekend and weekday load factors are nearly identical, 76.9% versus 76.7%. That near-parity means there isn't much room left to differentiate pricing by day type, airlines have already balanced this out.

By carrier, the charter and leisure operators lead on efficiency. Globespan Airways posts a 94.8% load factor, well above any legacy carrier, with Allegiant Air second at 89.4%. On raw volume, Southwest carries the most passengers at 34.1 million, and Southwest plus Delta together account for 48.7% of total passenger share among the top ten carriers.

Route-wise, the Northeast corridor dominates: four of the top five routes by flight count involve New York (Atlanta-NY, Boston-NY, DC-NY, NY-Boston, NY-DC), pointing to real saturation in that corridor. Short-haul flights under 500 miles make up 52.4% of all flights, the single largest distance band by far.

## Recommendations

- Right-size capacity in Q1: deploy smaller aircraft or lean on regional partner capacity-sharing during the January-February trough instead of running summer-sized schedules
- Push premium pricing and last-seat availability tiers on the Northeast corridor routes, where demand is already near-saturated
- Study the charter carrier model (Globe span, Allegiant) for route selection and scheduling discipline, since point-to-point, demand-led planning is clearly outperforming the legacy hub-and-spoke approach on load factor
- Add 8-10% capacity on top summer routes with enough lead time to avoid last-minute sell outs, while watching for oversupply risk in the shoulder months

## SQL Methodology

Queries covered date-field engineering (deriving year, quarter, month, weekday from raw date columns), load factor calculation by year/quarter/month, carrier ranking via window functions (`ROW_NUMBER() OVER (ORDER BY SUM(...) DESC)`), route-level flight counts, weekend/weekday classification with `CASE WHEN DAYNAME(...)`, and distance-group breakdowns. Full query set is in `/sql`.

## Dashboards

Separate Power BI  dashboards built on the same data, covering load factor trends, carrier performance, route frequency, and distance-band distribution. Screenshots are in `/dashboards`.

## Tools

SQL (MySQL), Power BI, Microsoft Excel
