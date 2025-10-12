select
    n.n_name as nation_name,
    count(c.c_custkey) as num_customers
from {{ source('TPCH_SF10', 'CUSTOMER') }} c
join {{ source('TPCH_SF10', 'NATION') }} n
  on c.c_nationkey = n.n_nationkey
group by n.n_name
order by num_customers desc