create view gold.dim_customer AS 

select 
    row_number() over(order by cst_id) AS Customer_Number,
	ci.cst_id,
	ci.cst_key,
	ci.cst_firstname,
	ci.cst_lastname,
	ci.cst_marital_status,
	case when ci.cst_gndr !='n/a' then ci.cst_gndr --CRM is master for gender info
	     else coalesce( ca.GEN,'n/a')
	end as Gender,
	ci.cst_create_date,
	ca.BDATE,
	la.CNTRY
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca
on ci.cst_key = ca.CID
left join silver.erp_loc_a101 la
on ci.cst_key=la.CID

create view gold.dim_product as 

select 
    ROW_NUMBER() over(order by p.prd_start_dt ) AS Product_Key,
	p.prd_id,
	p.prd_key,
	p.prd_nm,
	p.cat_id,
	pc.CAT,
	pc.SUBCAT,
	pc.MAINTENANCE,
	p.prd_cost,
	p.prd_line,
	p.prd_start_dt
	
from silver.crm_prd_info p
left join silver.erp_px_cat_g1v2 pc
on p.cat_id = pc.ID

create view gold.fact_sales as 
select 
	sd.sls_ord_num Order_number,
	pr.Product_Key,
	cr.Customer_Key,
	sd.sls_order_dt Order_Date,
	sd.sls_ship_dt Ship_date,
	sd.sls_due_dt due_Date,
	sd.sls_sales Sales,
	sd.sls_quantity Quantity,
	sd.sls_price price
from silver.crm_sales_details sd
left join gold.dim_product pr
on sd.sls_prd_key=pr.prd_key
left join gold.dim_customer cr
on sd.sls_cust_id=cr.cst_id



