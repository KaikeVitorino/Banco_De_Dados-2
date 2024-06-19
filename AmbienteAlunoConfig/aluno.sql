/* ACESSO ÀS TABELAS DO USUÁRIO DEMO PARA A ROLE TAB_DEMO */

create role tab_demo;

grant connect to tab_demo;
grant resource to tab_demo;
grant  create table to tab_demo;
grant  create view to tab_demo;
grant  create public synonym to tab_demo;
grant  drop public synonym to tab_demo;
grant  select on demo.s_dept to public;
grant  select on demo.s_customer to public;
grant  select on demo.s_emp to public;
grant  select on demo.s_inventory to public;
grant  select on demo.s_item to public;
grant  select on demo.s_ord to public;
grant  select on demo.s_product to public;
grant  select on demo.s_region to public;
grant  select on demo.s_title to public;
grant  select on demo.s_warehouse to public;
create public synonym dept for demo.s_dept;
create public synonym emp for demo.s_emp;
create public synonym produto for demo.s_product;
create public synonym s_dept for demo.s_dept;
create public synonym s_emp for demo.s_emp;
create public synonym s_product for demo.s_product;
create public synonym s_inventory for demo.s_inventory;
create public synonym s_customer for demo.s_customer;
create public synonym s_item for demo.s_item;
create public synonym s_ord for demo.s_ord;
create public synonym s_region for demo.s_region;
create public synonym s_title for demo.s_title;
create public synonym s_warehouse for demo.s_warehouse;

-- CRIA O USUÁRIO ALUNO E ATRIBUI OS PRIVILÉGIOS PARA FICAR EQUIVALENTE AO USUÁRIO DO LABORATÓRIO
create user aluno identified by aluno;
grant tab_demo to aluno;
alter user aluno default tablespace users;
alter user aluno quota unlimited on users; 
alter user aluno temporary tablespace temp;
connect aluno/aluno;