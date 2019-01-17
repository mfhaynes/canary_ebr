prompt Connect as system ID
@../private/connect_system.sql
drop user canary_sch cascade;
drop user canary_app cascade;
drop tablespace canary_ts;
drop edition release1 cascade;
drop trigger edition_router_trig;
drop function get_random_edition;
