/*************************************************/
/* PAGE1 |------|                                */
/* PAGE1  |--------|                             */
/* PAGE2            |------|                     */
/* PAGE2                |----|                   */
/* PAGE1                        |------------|   */
/* PAGE1                                |------| */
/*************************************************/
with cte as (
	select ClientSessionId, PageName, StartDate
		,gn=row_number() over (partition by ClientSessionId, PageName order by StartDate)
		,rn=row_number() over (partition by ClientSessionId order by StartDate)
	from Pages
)
, cte2 as (
	select ClientSessionId, PageName, StartDate, gn, rn, gn - rn  as gb /* the difference between the 2 ranks create a rank by page break */
	from cte 
)
, cte3 as (
	select ClientSessionId, PageName, StartDate=min(StartDate), EndDate=max(StartDate)
	from cte2
	group by ClientSessionId, PageName, gb
)
select ClientSessionId, PageName, StartDate, EndDate
from cte3
order by StartDate