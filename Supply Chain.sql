create database supplychain;

use supplychain;

#KPI 1 : Total Sales
select concat('$', round(sum(Sales) / 1000000, 2), 'M') as Total_Sales from supply_chain_view;



#KPI 2 : 
# Month wise sales
select 
	MonthNo,
    MonthName,
	concat('$', round(sum(Sales) / 1000000, 2), 'M') as Total_Sales
from supply_chain_view
group by MonthName,MonthNo
order by MonthNo;

# Quarter wise sales
select 
    Quarter,
	concat('$', round(sum(Sales) / 1000000, 2), 'M') as Total_Sales
from supply_chain_view
group by Quarter
order by Quarter;

# Year wise sales
select 
    Year,
	concat('$', round(sum(Sales) / 1000000, 2), 'M') as Total_Sales
from supply_chain_view
group by Year
order by Year ;



#KPI 3 : Product Wise Sales
select 
    fi.`Product Name`,
    concat('$', round(sum(sc.Sales) / 1000, 2), 'K') as Total_Sales
from supply_chain_view sc
join f_inventory_adjusted fi 
    on binary sc.SkuNumber = binary fi.`Sku Number`
group by fi.`Product Name`
order by sum(sc.Sales) desc;



#KPI 4 : Sales Growth
select 
    curr.MonthNo,
    concat(
        round(((curr.Total_Sales - prev.Total_Sales) / prev.Total_Sales) * 100, 2),'%') as Sales_Growth_Percentage
from (
    select 
        MonthNo,
        sum(Sales) as Total_Sales
    from supply_chain_view
    group by MonthNo
) curr
join (
    select 
        MonthNo + 1 as MonthNo,
        sum(Sales) as Total_Sales
    from supply_chain_view
    group by MonthNo
) prev
on curr.MonthNo = prev.MonthNo
order by curr.MonthNo;



#KPI 5 : Daily Sales Trend
select 
	MonthNo,
    day(Date) as DayOfMonth,
    MonthName,
    concat('$', round(sum(Sales) / 1000, 2), 'K') as Total_Sales
from supply_chain_view
group by MonthNo, MonthName, DayOfMonth
order by MonthNo, MonthName, DayOfMonth;



#KPI 6 : State Wise Sales
select 
    StoreState,
    concat('$', round(sum(Sales) / 1000000, 2), 'M') as Total_Sales
from supply_chain_view 
group by StoreState
order by sum(Sales) desc;



#KPI 7 : Top 5 Store Wise Sales
select 
    StoreName,
    concat('$', round(sum(Sales) / 1000000, 2), 'M') as Total_Sales
from supply_chain_view 
group by StoreName
order by sum(Sales) desc
limit 5;



#KPI 8 : Region Wise Sales
select 
    StoreRegion,
    concat('$', round(sum(Sales) / 1000000, 2), 'M') as Total_Sales
from supply_chain_view 
group by StoreRegion
order by sum(Sales) desc;



#KPI 9 : Total Inventory
select 
    sum(`Quantity on Hand`) as Total_Inventory
from f_inventory_adjusted;



#KPI 10 : Inventory Value
select 
    concat('$', round(sum(`Quantity on Hand` * `Cost Amount`) / 1000, 2), 'K') as Total_Inventory_Value
from f_inventory_adjusted;



#KPI 12 : Purchase Method Wise Sales
select 
    fs.`Purchase Method`,
    concat('$', round(sum(sc.Sales) / 1000000, 2), 'M') as Total_Sales
from supply_chain_view sc
join f_sales fs 
    on sc.OrderNumber = fs.`Order Number`
group by fs.`Purchase Method`
order by sum(sc.Sales) desc;













