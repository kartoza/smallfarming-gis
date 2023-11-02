--create database farming;
-- add connect statement here
/* -------- CONVENTIONS ----------
CREATE TABLE table_name (
		id SERIAL NOT NULL PRIMARY KEY, 
	uuid UUID UNIQUE NOT NULL DEFAULT gen_random_uuid(),
    	last_update TIMESTAMP DEFAULT now() NOT NULL,
    	last_update_by TEXT NOT NULL,
        name TEXT UNIQUE NOT NULL, 
	notes TEXT, 
	image TEXT,
	attribute_a FLOAT NOT NULL,
	attribute_b 
    	foreign_item_uuid UUID NOT NULL REFERENCES foreign_item(uuid),

)
COMMENT ON TABLE table_name IS 'A description of what this table is about or how it functions';
COMMENT ON COLUMN infrastructure_type.id is 'The unique infrastructure type ID. This is the Primary Key.';

*/
-- create extension postgis;
----------------------------------------INFRASTRUCTURE-------------------------------------
-- INFRASTRUCTURE TYPE
create table if not exists infrastructure_type (
    	id SERIAL not null primary key, 
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text

);

comment on
table infrastructure_type is 'Lookup table for the types of infrastructure available, e.g. Furniture .';

comment on
column infrastructure_type.id is 'The unique infrastructure type ID. This is the Primary Key.';

comment on
column infrastructure_type.uuid is 'The unique user ID.';

comment on
column infrastructure_type.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column infrastructure_type.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column infrastructure_type.name is 'The infrastructure type name.';

comment on
column infrastructure_type.notes is 'Additional information of the infrastructure type.';

comment on
column infrastructure_type.image is 'Image of the infrastructure type.';
-- INFRASTRUCTURE ITEM
create table if not exists infrastructure_item(
    	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text not null, 
	notes text, 
	image text,
    	geometry GEOMETRY (POINT,
4326), 
    	infrastructure_type_uuid UUID not null references infrastructure_type(uuid)
);

comment on
table infrastructure_item is 'Infrastructure item refers to any physical components found in the area, e.g. desk, chair.';

comment on
column infrastructure_item.id is 'The unique infrastructure item ID. Primary Key.';

comment on
column infrastructure_item.uuid is 'The unique user ID.';

comment on
column infrastructure_item.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column infrastructure_item.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column infrastructure_item.name is 'The name of the infrastructure item.';

comment on
column infrastructure_item.notes is 'Additional information of the infrastructure item.';

comment on
column infrastructure_item.image is 'Image of the infrastructure item.';

comment on
column infrastructure_item.geometry is 'The centroid location of the infrastructure item. Follows EPSG: 4326.';
-- INFRASTRUCTURE LOG ACTION
create table if not exists infrastructure_log_action(
    	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text
);

comment on
table infrastructure_log_action is 'Infrastructure log action refers to the actions taken to maintain infrastructure items, e.g. Screwing, Painting, Welding.';

comment on
column infrastructure_log_action.id is 'The unique log action ID. Primary Key.';

comment on
column infrastructure_log_action.uuid is 'The unique user ID.';

comment on
column infrastructure_log_action.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column infrastructure_log_action.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column infrastructure_log_action.name is 'The name of the action taken.';

comment on
column infrastructure_log_action.notes is 'Additional information of the action taken.';

comment on
column infrastructure_log_action.image is 'Image of the action taken.';
-- INFRASTRUCTURE MANAGEMENT LOG 
create table if not exists infrastructure_management_log(
    	id SERIAL not null primary key, 
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text,
    	condition text not null, 
    	infrastructure_item_uuid UUID not null references infrastructure_item(uuid),
    	infrastructure_log_action_uuid UUID not null references infrastructure_log_action (uuid)
);

comment on
table infrastructure_management_log is 'Infrastructure management log refers to the process of task that needs to be done on an infrastructure item, e.g. Repair.';

comment on
column infrastructure_management_log.id is 'The unique management log ID. Primary Key.';

comment on
column infrastructure_management_log.uuid is 'The unique user ID.';

comment on
column infrastructure_management_log.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column infrastructure_management_log.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column infrastructure_management_log.name is 'The name of the process.';

comment on
column infrastructure_management_log.notes is 'Additional information of the process.';

comment on
column infrastructure_management_log.image is 'Image of the work flow.';

comment on
column infrastructure_management_log.condition is 'Circumstances or factors affecting the infrastructure item type.';
----------------------------------------ELECTRICITY-------------------------------------
-- ELECTRICITY LINE TYPE
create table if not exists electricity_line_type (
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text,
        sort_order INT unique,
-- Add unique together constraint for voltage and current
current_a FLOAT not null,
	voltage_v FLOAT not null,
-- Unique together constraint for voltage and current
	unique(current_a,
voltage_v)
);

comment on
table electricity_line_type is 'Look up table for the types of electricity lines, e.g. Low-voltage line, High-voltage line etc.';

comment on
column electricity_line_type.id is 'The unique electricity line type ID. Primary key.';

comment on
column electricity_line_type.uuid is 'The unique user ID.';

comment on
column electricity_line_type.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column electricity_line_type.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column electricity_line_type.name is 'The name of the electricity line type.';

comment on
column electricity_line_type.notes is 'Additional information of the electricity line type.';

comment on
column electricity_line_type.image is 'Image of the electricity line type';

comment on
column electricity_line_type.sort_order is 'Defines the pattern of how electricity line type records are to be sorted.';

comment on
column electricity_line_type.current_a is 'The electricity line current measured in ampere.';

comment on
column electricity_line_type.voltage_v is 'The electricity line voltage measured in volt.';
-- ELECTRICITY LINE
create table if not exists electricity_line (
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
	notes text, 
	image text,
	geometry GEOMETRY(LINESTRING,
4326) not null,
	electricity_line_type_uuid UUID not null references electricity_line_type(uuid)
);

comment on
table electricity_line is 'Electricity line refers to the geolocated wire or conductor used for transmitting or supplying electricity.';

comment on
column electricity_line.id is 'The unique electricity line ID. Primary key.';

comment on
column electricity_line.uuid is 'The unique user ID.';

comment on
column electricity_line.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column electricity_line.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column electricity_line.notes is 'Additional information of the electricity line.';

comment on
column electricity_line.image is 'Image of the electricity line';

comment on
column electricity_line.geometry is 'The location of the electricity line. Follows EPSG: 4326.';
-- ELECTRICITY LINE CONDITION
create table if not exists electricity_line_condition_type (
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text,
        sort_order INT unique
);

comment on
table electricity_line_condition_type is 'Look up table for the types of electricity line conditions, e.g. Working, Broken etc.';

comment on
column electricity_line_condition_type.id is 'The unique electricity line condition ID. Primary key.';

comment on
column electricity_line_condition_type.uuid is 'The unique user ID.';

comment on
column electricity_line_condition_type.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column electricity_line_condition_type.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column electricity_line_condition_type.name is 'The name of the electricity line condition.';

comment on
column electricity_line_condition_type.notes is 'Additional information of the electricity line condition.';

comment on
column electricity_line_condition_type.image is 'Image of the electricity line condition.';

comment on
column electricity_line_condition_type.sort_order is 'Defines the pattern of how  electricity line condition records are to be sorted.';
-- ASSOCIATION TABLES
-- ELECTRICITY LINE CONDITION
create table if not exists electricity_line_conditions (
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null, 
	notes text, 
	image text,
	date DATE not null,
	electricity_line_uuid UUID not null references electricity_line(uuid),
	electricity_line_condition_uuid UUID not null references electricity_line_condition_type(uuid),
-- Composite primary key
	primary key (electricity_line_uuid,
electricity_line_condition_uuid,
date),
-- Unique together
	unique(electricity_line_uuid,
electricity_line_condition_uuid,
date)
);

comment on
table electricity_line_conditions is 'Associative table which stores the electricity line and its condition on a particular day.';

comment on
column electricity_line_conditions.uuid is 'The unique user ID.';

comment on
column electricity_line_conditions.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column electricity_line_conditions.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column electricity_line_conditions.notes is 'Additional information of the electricity line and condition.';

comment on
column electricity_line_conditions.image is 'Image of the electricity line and condition.';

comment on
column electricity_line_conditions.date is 'The electricity line inspection date.';
----------------------------------------WATER-------------------------------------
-- WATER SOURCE
create table if not exists water_source(
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text
);

comment on
table water_source is 'Water source refers to the geolocated water bodies that provide drinking water, e.g. Aquifer.';

comment on
column water_source.id is 'The unique water source ID. This is the Primary Key.';

comment on
column water_source.uuid is 'The unique user ID.';

comment on
column water_source.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column water_source.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column water_source.name is 'The name of the water source.';

comment on
column water_source.notes is 'Additional information of the water body.';

comment on
column water_source.image is 'Image of the water body.';
-- WATER POLYGON TYPE
create table if not exists water_polygon_type(
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text
);

comment on
table water_polygon_type is 'Lookup table of the type of water polygon, e.g. Lake.';

comment on
column water_polygon_type.id is 'The unique water polygon ID. Primary Key.';

comment on
column water_polygon_type.uuid is 'The unique user ID.';

comment on
column water_polygon_type.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column water_polygon_type.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column water_polygon_type.name is 'The name of the water polygon type.';

comment on
column water_polygon_type.notes is 'Additional information of the water polygon type.';

comment on
column water_polygon_type.image is 'Image of the water polygon type.';
-- WATER POLYGON
create table if not exists water_polygon(
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text,
	estimated_depth_m FLOAT,
-- Estimated depth of water polygon constraint (0m < Estimated Depth < 20m).
	constraint depth_check check(
	estimated_depth_m >= 0
	and estimated_depth_m <= 20),
	geometry GEOMETRY(POLYGON,
4326),
	water_source_uuid UUID not null references water_source(uuid),
	water_polygon_type_uuid UUID not null references water_polygon_type(uuid)
);

comment on
table water_polygon is 'Water polygon refers to the geolocated land areas that are covered in water, either intermittently or constantly, e.g. River.';

comment on
column water_polygon.id is 'The unique water polygon ID. Primary Key.';

comment on
column water_polygon.uuid is 'The unique user ID.';

comment on
column water_polygon.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column water_polygon.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column water_polygon.name is 'The name of the water polygon.';

comment on
column water_polygon.notes is 'Additional information of the water polygon.';

comment on
column water_polygon.image is 'Image of the water polygon.';

comment on
column water_polygon.estimated_depth_m is 'The approximate depth of the water polygon measured in meters.';

comment on
column water_polygon.geometry is 'The location of the water polygon. Follows EPSG: 4326.';
-- WATER POINT TYPE
create table if not exists water_point_type (
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text
);

comment on
table water_point_type is 'Lookup table on the types of water points, e.g. Drinking trough.';

comment on
column water_point_type.id is 'The unique water point type ID. Primary Key.';

comment on
column water_point_type.uuid is 'The unique user ID.';

comment on
column water_point_type.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column water_point_type.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column water_point_type.name is 'The name of the water point type.';

comment on
column water_point_type.notes is 'Additional information of the water point type.';

comment on
column water_point_type.image is 'Image of the water point type.';
-- WATER POINT 
create table if not exists water_point(
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
	notes text, 
	image text,
	geometry GEOMETRY (POINT,
4326),
	water_source_uuid UUID not null references water_source(uuid),
	water_point_type_uuid UUID not null references water_point_type(uuid)
);

comment on
table water_point is 'Water point refers to the geolocated water site that is available for use, e.g. Tap.';

comment on
column water_point.id is 'The unique water point ID. Primary Key.';

comment on
column water_point.uuid is 'The unique user ID.';

comment on
column water_point.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column water_point.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column water_point.notes is 'Additional information of the water point.';

comment on
column water_point.image is 'Image of the water point.';

comment on
column water_point.geometry is 'The coordinates of the water point. Follows EPSG: 4326.';
-- WATER LINE TYPE
create table if not exists water_line_type (
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text,
        sort_order INT unique,
	pipe_length_m FLOAT,
	pipe_diameter_m FLOAT,
-- Pipe length & pipe diameter constraint (length, diameter > 0)
	constraint pipe_length_and_diameter_check check(
	pipe_length_m >= 0
	and pipe_diameter_m >= 0),
-- Unique together
	unique(pipe_length_m,
pipe_diameter_m)
);

comment on
table water_line_type is 'Description of the type of line through which water flows, e.g. Water pipe.';

comment on
column water_line_type.id is 'The unique water line type ID. Primary Key.';

comment on
column water_line_type.uuid is 'The unique user ID.';

comment on
column water_line_type.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column water_line_type.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column water_line_type.name is 'The name of the water line type.';

comment on
column water_line_type.notes is 'Additional information of the water line type.';

comment on
column water_line_type.image is 'Image of the water line type.';

comment on
column water_line_type.sort_order is 'Defines the pattern of how water line types are to be sorted.';

comment on
column water_line_type.pipe_length_m is 'The water line length measured in meters.';

comment on
column water_line_type.pipe_diameter_m is 'The water line diameter measured in meters.';
-- WATER LINE
create table if not exists water_line(
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
	notes text, 
	image text,
	estimated_depth_m FLOAT,
--Estimated depth of water line (depth > 0)
	constraint estimated_depth_m check(
	estimated_depth_m >= 0),
	geometry GEOMETRY(LINESTRING,
4326),
	water_source_uuid UUID not null references water_source(uuid),
	water_line_type_uuid UUID not null references water_line_type(uuid)
);

comment on
table water_line is 'This is the geolocated path the water lines follow.';

comment on
column water_line.id is 'The unique water line ID. Primary Key.';

comment on
column water_line.uuid is 'The unique user ID.';

comment on
column water_line.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column water_line.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column water_line.notes is 'Additional information of the water line path.';

comment on
column water_line.image is 'Image of the water line path.';

comment on
column water_line.estimated_depth_m is 'The approximate depth of the water line measured in meters.';

comment on
column water_line.geometry is 'The location of the water line. Follows EPSG: 4326';
----------------------------------------VEGETATION-------------------------------------
-- PLANT GROWTH ACTIVITY TYPE
create table if not exists plant_growth_activity_type (
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text,
        sort_order INT unique
);

comment on
table plant_growth_activity_type is 'Plant growth activity type refers to the different growth stages of plants, e.g. Sprouting, Seeding etc.';

comment on
column plant_growth_activity_type.id is 'The unique plant growth activity ID. This is the Primary Key.';

comment on
column plant_growth_activity_type.uuid is 'The unique user ID.';

comment on
column plant_growth_activity_type.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column plant_growth_activity_type.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column plant_growth_activity_type.name is 'The name of the plant growth activity type.';

comment on
column plant_growth_activity_type.notes is 'Additional information of the plant growth activity type.';

comment on
column plant_growth_activity_type.image is 'Image of the plant growth activity type.';

comment on
column plant_growth_activity_type.sort_order is 'Defines the pattern of how plant growth activity type records are to be sorted.';
-- PLANT TYPE
create table if not exists plant_type(
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text,
	scientific_name text unique,
	plant_image text,
	flower_image text,
	fruit_image text,
	variety text,
	info_url text
);

comment on
table plant_type is 'Look up table of different types of plants, e.g. Oaktree.';

comment on
column plant_type.id is 'The unique plant type ID. This is the Primary Key.';

comment on
column plant_type.uuid is 'The unique user ID.';

comment on
column plant_type.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column plant_type.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column plant_type.name is 'The name of the plant type.';

comment on
column plant_type.notes is 'Additional information of the plant type.';

comment on
column plant_type.image is 'Image of the plant type.';

comment on
column plant_type.scientific_name is 'Scientific name of the plant type e.g. Quercus.';

comment on
column plant_type.plant_image is 'Path to image of plant.';

comment on
column plant_type.flower_image is 'Path to image of flower.';

comment on
column plant_type.fruit_image is 'Path to image of fruit.';

comment on
column plant_type.variety is 'Other variety of this plant type.';

comment on
column plant_type.info_url is 'URL link to more information about this specific plant type.';
-- MONTH
create table if not exists month(
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text,
        sort_order INT unique
);

comment on
table month is 'Look up table for different months of the year, e.g. January, February etc.';

comment on
column month.id is 'The unique month ID. This is the Primary Key.';

comment on
column month.uuid is 'The unique user ID.';

comment on
column month.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column month.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column month.name is 'Name of the different months in the year e.g. January';

comment on
column month.notes is 'Additional information of the month.';

comment on
column month.image is 'Image of the object stored.';

comment on
column month.sort_order is 'Defines the pattern of how month records are to be sorted.';
-- PLANT USAGE
create table if not exists plant_usage(
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text
);

comment on
table plant_usage is 'Look up table for different usages of the plants e.g. Food plant, Commercial plant etc.';

comment on
column plant_usage.id is 'The unique plant usage ID. This is the Primary Key.';

comment on
column plant_usage.uuid is 'The unique user ID.';

comment on
column plant_usage.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column plant_usage.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column plant_usage.name is 'The name of the plant usage.';

comment on
column plant_usage.notes is 'Additional information of the plant usage.';

comment on
column plant_usage.image is 'Image of the plant stored.';
-- VEGETATION POINT
create table if not exists vegetation_point(
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
	notes text, 
	image text,
	estimated_crown_radius_m FLOAT,
--Must be positive number
	constraint radius_check check(
	estimated_crown_radius_m >= 0),
--Takes 4 digits only
estimated_planting_year decimal(4,
0),
--Must be before or equal this year
	constraint year_check check(
	estimated_planting_year >= 0),
	constraint year_check2 check(
	estimated_planting_year <= DATE_PART('Year',
NOW())),
	estimated_height_m FLOAT,
--Must be positive number
	constraint height_check check(
	estimated_height_m >= 0),
	geometry GEOMETRY(POINT,
4326) not null, 
	plant_type_uuid UUID not null references plant_type(uuid)
);

comment on
table vegetation_point is 
'Vegetation point refers a geolocated plant. Table stores the individual plant location and the properties.';

comment on
column vegetation_point.id is 'The unique vegetation point ID. This is the Primary Key.';

comment on
column vegetation_point.uuid is 'The unique user ID.';

comment on
column vegetation_point.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column vegetation_point.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column vegetation_point.notes is 'Additional information of the vegetation point.';

comment on
column vegetation_point.image is 'Image of the vegetation point.';

comment on
column vegetation_point.estimated_crown_radius_m is 'Estimated radius of the plant''s crown measured in meters.';

comment on
column vegetation_point.estimated_height_m is 'Estimated height of plant measured in meters.';

comment on
column vegetation_point.estimated_planting_year is 'The year the plant was planted. The year must be in the range of 0 to current year.';

comment on
column vegetation_point.geometry is 'The coordinates of the vegetation point. Follows EPSG 4326.';
-- PRUNING ACTIVITY
create table if not exists pruning_activity(
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text,
	date DATE not null,
	before_image text,
	after_image text,
	vegetation_point_uuid UUID not null references vegetation_point(uuid)
);

comment on
table pruning_activity is 'Pruning activity refers to the trimming of unwanted parts of a plant.';

comment on
column pruning_activity.id is 'The unique pruning activity ID. This is the Primary Key.';

comment on
column pruning_activity.uuid is 'The unique user ID.';

comment on
column pruning_activity.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column pruning_activity.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column pruning_activity.name is 'The name of the pruning activity.';

comment on
column pruning_activity.notes is 'Additional information of the  pruning activity.';

comment on
column pruning_activity.image is 'Image of the  pruning activity.';

comment on
column pruning_activity.date is 'The date of the pruning activity (yyyy:mm:dd).';

comment on
column pruning_activity.before_image is 'Path to image before the pruning activity was done.';

comment on
column pruning_activity.after_image is 'Path to image after the pruning activity was done.';
-- HARVEST ACTIVITY
create table if not exists harvest_activity(
	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
        name text unique not null, 
	notes text, 
	image text,
	date DATE not null,
	quantity_kg FLOAT,
	vegetation_point_uuid UUID not null references vegetation_point(uuid)
);

comment on
table harvest_activity is 'Harvest activity refers to the gathering of ripe crop or fruits.';

comment on
column harvest_activity.id is 'The unique harvest activity ID. This is the Primary Key.';

comment on
column harvest_activity.uuid is 'The unique user ID.';

comment on
column harvest_activity.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column harvest_activity.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column harvest_activity.name is 'The name of the harvest activity.';

comment on
column harvest_activity.notes is 'Additional information of the harvest activity.';

comment on
column harvest_activity.image is 'Image of the harvest activity.';

comment on
column harvest_activity.date is 'The date of the harvest activity (yyyy:mm:dd).';

comment on
column harvest_activity.quantity_kg is 'The quantity of harvest measured in kilograms.';
-- ASSOCIATION TABLES
-- PLANT GROWTH ACTIVITIES
create table if not exists plant_growth_activities(
	fk_plant_activity_uuid UUID not null references plant_growth_activity_type(uuid),
	fk_plant_type_uuid UUID not null references plant_type(uuid),
	fk_month_uuid UUID not null references month(uuid),
-- Composite primary key using the three foreign keys above
	primary key (fk_plant_activity_uuid,
fk_plant_type_uuid,
fk_month_uuid)
);

comment on
table plant_growth_activities is 
'Associative table to store the plant growth activities and plant types at different months in the year e.g. January_activity.';

comment on
column plant_growth_activities.fk_plant_activity_uuid is 'The foreign key linking to plant growth activity type table''s UUID.';

comment on
column plant_growth_activities.fk_plant_type_uuid is 'The foreign key linking to plant type table''s UUID.';

comment on
column plant_growth_activities.fk_month_uuid is 'The foreign key linking to month table''s UUID.';
-- PLANT TYPE USAGES
create table if not exists plant_type_usages(
	fk_plant_usage_uuid UUID not null references plant_usage(uuid),
	fk_plant_type_uuid UUID not null references plant_type(uuid),
	primary key (fk_plant_usage_uuid,
fk_plant_type_uuid)
);

comment on
table plant_type_usages is 
'Associative table to store the different plant usages and plant types ';

comment on
column plant_type_usages.fk_plant_usage_uuid is 'The foreign key linking to plant usage table''s UUID.';

comment on
column plant_type_usages.fk_plant_type_uuid is 'The foreign key linking to plant type table''s UUID.';
----------------------------------------MONITORING STATIONS-------------------------------------
-- READING UNIT
create table if not exists reading_unit (
   id SERIAL not null primary key,
   uuid UUID unique not null default gen_random_uuid(),
   last_update TIMESTAMP default now() not null,
   last_update_by text not null,
   name text not null,
   abbreviation text not null
);

comment on
table reading_unit is 'Look up table for monitoring station reading unit';

comment on
column reading_unit.id is 'The equipment type ID. This is the Primary Key.';

comment on
column reading_unit.uuid is 'Global Unique Identifier.';

comment on
column reading_unit.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column reading_unit.last_update_by is 'The name of the person who updated the table last.';

comment on
column reading_unit.name is 'Where we make comments and a description about the reading_unit.';

comment on
column reading_unit.abbreviation is 'Where we make comments and a description about the reading_unit.';
-- EQUIPMENT TYPE
create table if not exists equipment_type (
   id SERIAL not null primary key,
   uuid UUID unique not null default gen_random_uuid(),
   last_update TIMESTAMP default now() not null,
   last_update_by text not null,
   name text not null,
   url text,
   notes text,
   model text,
   manufacturer text,
   calibration_date TIMESTAMP default NOW() not null
);

comment on
table equipment_type is 'Look up table for equipment type, e.g. moisture tester, penetrometers.';

comment on
column equipment_type.id is 'The equipment type ID. This is the Primary Key.';

comment on
column equipment_type.uuid is 'Global Unique Identifier.';

comment on
column equipment_type.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column equipment_type.last_update_by is 'The name of the person who updated the table last.';

comment on
column equipment_type.name is 'Where we make comments and a description about the equipment type.';

comment on
column equipment_type.url is 'The URL is unique to the equipment type.';

comment on
column equipment_type.notes is 'Additional information of the equipment type';

comment on
column equipment_type.model is 'Where we make comments and a description about the equipment type.';

comment on
column equipment_type.manufacturer is 'Information about the manufacturer that manufactured the equipment.';

comment on
column equipment_type.calibration_date is 'The last date the equipment was calibrated.';
-- ASSOCIATION TABLE
-- MONITORING STATION
create table if not exists monitoring_station (
   id SERIAL not null primary key,
   uuid UUID unique not null default gen_random_uuid(),
   last_update TIMESTAMP default now() not null,
   last_update_by text not null,
   name text not null,
   image text,
   equipment text not null,
   geometry GEOMETRY (POINT,
4326) not null,
   equipment_type_uuid UUID not null references equipment_type(uuid)
);

comment on
table monitoring_station is 'Look up table for monitoring station, e.g. station 1, station 2.';

comment on
column monitoring_station.id is 'The monitoring station ID. This is the Primary Key.';

comment on
column monitoring_station.uuid is 'Global Unique Identifier.';

comment on
column monitoring_station.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column monitoring_station.last_update_by is 'The name of the person who updated the table last.';

comment on
column monitoring_station.name is 'Where we make comments and a description about the equipment name.';

comment on
column monitoring_station.image is 'The image link associated with the monitoring station image.';

comment on
column monitoring_station.geometry is 'The location of the monitoring station. Follows EPSG: 4326.';

comment on
column monitoring_station.equipment_type_uuid is 'Globally Unique Identifier.';
-- ASSOCIATION TABLE
-- READINGS
create table if not exists readings (
   id SERIAL not null primary key,
   uuid UUID unique not null default gen_random_uuid(),
   last_update TIMESTAMP default now() not null,
   last_update_by text not null,
   name text not null,
   notes text,
   equipment text not null,
   geometry GEOMETRY (POINT,
4326) not null,
   soil_ph FLOAT not null,
   soil_temperature FLOAT not null,
   estimated_depth_m FLOAT not null,
   monitoring_station_uuid UUID not null references monitoring_station(uuid),
   reading_unit_uuid UUID not null references reading_unit(uuid)
);

comment on
table readings is 'Look up table for readings, e.g. reading at station 1, station 2.';

comment on
column readings.id is 'The monitoring station ID. This is the Primary Key.';

comment on
column readings.uuid is 'Global Unique Identifier.';

comment on
column readings.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column readings.last_update_by is 'The name of the person who updated the table last.';

comment on
column readings.name is 'Where we make comments and a description about the readings name.';

comment on
column readings.notes is 'Additional information of the readings.';

comment on
column readings.equipment is 'Equipment name used for the readings.  e.g. moisture_testers, penetrometers';

comment on
column readings.geometry is 'The location of the monitoring station. Follows EPSG: 4326.';

comment on
column readings.soil_ph is 'The soil ph measured in pH scale is from 0 (most acid) to 14 (most alkaline) and a pH of 7 is neutral.';

comment on
column readings.soil_temperature is 'The soil temperature measured in degrees celcius.';

comment on
column readings.estimated_depth_m is 'The estimated_depth length measured in meters.';
-----------------------------------------------------------------------------------------------------
-- CONDITIONS
create table if not exists condition (
    id serial not null primary key,
    uuid UUID unique not null default gen_random_uuid(),
    last_update TIMESTAMP default now() not null,
    last_update_by text not null,
    name text unique not null,
    notes text,
    image text
);

comment on
table condition is 'Look up table for condition, e.g. good, bad.';

comment on
column condition.id is 'The unique condition item id. Primary key.';

comment on
column condition.uuid is 'Global Unique Identifier.';

comment on
column condition.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column condition.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column condition.name is 'The name of the condition item.';

comment on
column condition.notes is 'Additional information of the condition item.';

comment on
column condition.image is 'Image of the condition item.';
---------------------------------------- LAND USE BUILDINGS -------------------------------------
-- BUILDING TYPE --
create table if not exists building_type(
   id serial primary key,
-- We said this should be serial, not int. Also 'id', not 'building_type_id'
name VARCHAR unique not null,
--this was named 'name' in the erd, not 'type_name'. Must be unique
notes text,
   image text,
   last_update TIMESTAMP default now() not null,
   last_update_by text not null,
   uuid uuid unique not null default gen_random_uuid());

comment on
table building_type is 'Look up table for the types of buildings available, e.g barns, cottages, etc.';

comment on
column building_type.id is 'The unique building type ID. This is the Primary Key.';

comment on
column building_type.name is 'The name is unique to the buildings table.';

comment on
column building_type.notes is 'Where we make comments and a description about the building_type.';

comment on
column building_type.image is 'The image link associated with the building type.';

comment on
column building_type.last_update is 'The timestamp shown for when the building type table has been updated.';

comment on
column building_type.last_update_by is 'The name of the person who updated the table last.';

comment on
column building_type.uuid is 'Global Unique Identifier.';
-- BUILDINGS --
create table if not exists building(
   id SERIAL primary key,
   name VARCHAR not null,
   notes text not null,
   address text not null,	
   image text,
   geometry GEOMETRY(Polygon,
4326),
   area_square_meter FLOAT not null,
   height_meter FLOAT not null,	
   last_update TIMESTAMP default now() not null,
   last_update_by text not null,
   uuid UUID unique not null default gen_random_uuid(),
   building_type_uuid UUID not null references building_type(uuid));

comment on
table building is 'Look up table for the types of buildings available, e.g residential';

comment on
column building.id is 'The unique building type ID. This is the Primary Key.';

comment on
column building.name is 'The name is unique for the building table.';

comment on
column building.notes is 'Where we make comments and a description about the building_type.';

comment on
column building.address is 'The address of the building to locate it in space.';

comment on
column building.image is 'The image link associated with the building_type.';

comment on
column building.geometry is 'The geometry of building (point, line or polygon) and the projection system used.';

comment on
column building.area_square_meter is 'The area covered by the building on the ground in m^2.';

comment on
column building.height_meter is 'The height of building which can be influenced by the shadow it casts over the nearby area depending on the position of the sun.';

comment on
column building.last_update is 'The timestamp shown for when the table has been updated.';

comment on
column building.last_update_by is 'The name of the person who upated the table last.';

comment on
column building.uuid is 'Global Unique Identifier.';

comment on
column building.building_type_uuid is 'The foreign key which references the uuid from the building type table.';
--BUILDING MATERIAL--
create table if not exists building_material(
id serial primary key,
name VARCHAR unique not null,
--look up table names must be unique
notes text,
image text,
last_update TIMESTAMP default now() not null,
last_update_by text not null,
uuid UUID unique not null default gen_random_uuid());

comment on
table building_material is 'Look up table for the types of building materials e.g. wood, concrete, aluminuim sheets etc.';

comment on
column building_material.id is 'The unique building material type ID. This is the Primary Key.';

comment on
column building_material.name is 'The name is unique to the buildings table since it is a look up table.';

comment on
column building_material.notes is 'Where we make comments and a description about the building material.';

comment on
column building_material.image is 'The image link associated with the building material.';

comment on
column building_material.last_update is 'The timestamp shown for when the building material table has been updated.';

comment on
column building_material.last_update_by is 'The name of the person who upated the table last.';

comment on
column building_material.uuid is 'Globally Unique Identifier.';
-- BUILDING MATERIALS --
create table if not exists building_materials(
-- association table
uuid UUID unique not null default gen_random_uuid(),	
last_update TIMESTAMP default now() not null,
last_update_by text not null,
notes text,
image text,
date DATE not null,	
building_uuid UUID not null references building(uuid),
building_material_uuid UUID not null references building_material(uuid),
primary key (building_uuid,
building_material_uuid,
date),
--composite keys
unique (building_uuid,
building_material_uuid,
date));

comment on
table building_materials is 'An association table between building and building material.';

comment on
column building_materials.uuid is 'Global Unique Identifier.';

comment on
column building_materials.last_update is 'The timestamp shown for when the table has been updated.';

comment on
column building_materials.last_update_by is 'The name of the person who upated the table last.';

comment on
column building_materials.notes is 'Where we make comments and a description about the building materials.';

comment on
column building_materials.image is 'The image link associated with the building materials.';

comment on
column building_materials.date is 'The datetime alteration of the conditions. This is the Primary and Composite Key';

comment on
column building_materials.building_uuid is 'The composite key referenced from the building table.';

comment on
column building_materials.building_material_uuid is 'The composite key referenced from the building material table.';
-- BUILDING CONDITIONS --
create table if not exists building_conditions(
-- association table
uuid UUID unique not null default gen_random_uuid(),	
last_update TIMESTAMP default now() not null,
last_update_by text not null,
notes text,
image text,
date DATE not null,	
building_uuid UUID not null references building(uuid),
condition_uuid UUID not null references condition(uuid),
primary key (building_uuid,
condition_uuid,
date),
--composite keys
unique (building_uuid,
condition_uuid,
date));

comment on
table building_conditions is 'An association table between building and building conditions type.';

comment on
column building_conditions.uuid is 'Global Unique Identifier.';

comment on
column building_conditions.last_update is 'The timestamp shown for when the table has been updated.';

comment on
column building_conditions.last_update_by is 'The name of the person who upated the table last.';

comment on
column building_conditions.notes is 'Where we make comments and a description about the building conditions.';

comment on
column building_conditions.image is 'The image link associated with the building conditions.';

comment on
column building_conditions.date is 'The datetime alteration of the conditions. This is the Primary and Composite Key';

comment on
column building_conditions.building_uuid is 'The composite key referenced from the building table.';

comment on
column building_conditions.condition_uuid is 'The composite key referenced from the building table.';
---------------------------------------- FENCES -------------------------------------
-- FENCE TYPE
create table if not exists fence_type (
    id serial not null primary key,
    uuid UUID unique not null default gen_random_uuid(),
    last_update TIMESTAMP default now() not null,
    last_update_by text not null,
    name text unique not null,
    notes text,
    image text,
    sort_order INT unique
);

comment on
table fence_type is 'Look up table for fence types, e.g. electric, chain_link.';

comment on
column fence_type.id is 'The unique fence type item id. Primary key.';

comment on
column fence_type.uuid is 'Global Unique Identifier.';

comment on
column fence_type.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column fence_type.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column fence_type.name is 'The name of the fence type item.';

comment on
column fence_type.notes is 'Additional information of the fence type item.';

comment on
column fence_type.image is 'Image of the fence type item.';
-- FENCE LINE
create table if not exists fence (
    id serial not null primary key,
    uuid UUID unique not null default gen_random_uuid(),
    last_update TIMESTAMP default now() not null,
    last_update_by text not null,
    notes text,
    image text,
    height_m FLOAT,
    installation_date DATE not null,
    is_date_estimated BOOLEAN,
    geometry GEOMETRY(LINESTRING,
4326) not null,
    fence_type_uuid UUID not null references fence_type(uuid)
);

comment on
table fence is 'The fence item refers to any geolocated line acting as boundary in the area, e.g. fence lines';

comment on
column fence.id is 'The unique fence item id. Primary key.';

comment on
column fence.uuid is 'Global Unique Identifier.';

comment on
column fence.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column fence.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column fence.notes is 'Additional information of the fence item.';

comment on
column fence.image is 'Image of the fence item.';

comment on
column fence.height_m is 'Height of the fence in meters';

comment on
column fence.installation_date is 'The date the fence was installed.';

comment on
column fence.is_date_estimated is 'Is the fence item date of construction estimated?';

comment on
column fence.geometry is 'The location of the fence line. Follows EPSG: 4326.';
-- ASSOCIATION TABLE
-- FENCE CONDITIONS
create table if not exists fence_conditions (
    uuid UUID unique not null default gen_random_uuid(),
    last_update TIMESTAMP default now() not null,
    last_update_by text not null,
    notes text,
    image text,
    DATE DATE not null,
    fence_uuid UUID not null references fence(uuid),
    condition_uuid UUID not null references condition(uuid),
-- composite primary key
    primary key (fence_uuid,
condition_uuid,
DATE),
-- unique together
    unique(fence_uuid,
condition_uuid,
DATE)
);

comment on
table fence_conditions is 'An Association table showing the fence conditions, e.g. good, bad.';

comment on
column fence_conditions.uuid is 'Global Unique Identifier.';

comment on
column fence_conditions.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column fence_conditions.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column fence_conditions.notes is 'Additional information of the fence conditions item.';

comment on
column fence_conditions.image is 'Image of the fence conditions item.';

comment on
column fence_conditions."date" is 'The date of the current conditions are marked as changed';
-- POINT OF INTEREST TYPE
create table if not exists point_of_interest_type (
    id serial not null primary key,
    uuid UUID unique not null default gen_random_uuid(),
    last_update TIMESTAMP default now() not null,
    last_update_by text not null,
    name text unique not null,
    notes text,
    image text,
    sort_order INT unique
);

comment on
table point_of_interest_type is 'Look up tables for point of interest types, e.g. types of gates';

comment on
column point_of_interest_type.id is 'The unique point of interest type item id. Primary key.';

comment on
column point_of_interest_type.uuid is 'Global Unique Identifier.';

comment on
column point_of_interest_type.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column point_of_interest_type.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column point_of_interest_type.name is 'The name of the point of interest type.';

comment on
column point_of_interest_type.notes is 'Additional information of the point of interest type.';

comment on
column point_of_interest_type.image is 'Image of the point of interest type.';

comment on
column point_of_interest_type.sort_order is 'The pattern of how point of interest types are to be sorted.';
-- POINT OF INTEREST
create table if not exists point_of_interest (
    id serial not null primary key,
    uuid UUID unique not null default gen_random_uuid(),
    last_update TIMESTAMP default now() not null,
    last_update_by text not null,
    name text,
    notes text,
    image text,
    height_m FLOAT,
    installation_date DATE,
    is_date_estimated BOOLEAN,
    geometry GEOMETRY(POINT,
4326) not null,
    point_of_interest_type_uuid UUID not null references point_of_interest_type(uuid)
);

comment on
table point_of_interest is 'The point of interest item refers to any geolocated point features found in the area, e.g. gate, ruin.';

comment on
column point_of_interest.id is 'The unique point of interest item id. Primary key.';

comment on
column point_of_interest.uuid is 'Global Unique Identifier.';

comment on
column point_of_interest.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column point_of_interest.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column point_of_interest.name is 'The name of the point of interest item.';

comment on
column point_of_interest.notes is 'Additional information of the point of interest item.';

comment on
column point_of_interest.image is 'Image of the point of interest item.';

comment on
column point_of_interest.height_m is 'The height in meters of the point of interest.';

comment on
column point_of_interest.installation_date is 'The date the point of interest feature was installed/constructed.';

comment on
column point_of_interest.is_date_estimated is 'Is the point of interest date of construction estimated?';

comment on
column point_of_interest.geometry is 'The centroid location of the point of interest item. Follows EPSG: 4326.';
-- ASSOCIATION TABLE
-- POINT OF INTEREST CONDITIONS
create table if not exists point_of_interest_conditions (
    uuid UUID unique not null default gen_random_uuid(),
    last_update TIMESTAMP default now() not null,
    last_update_by text not null,
    notes text,
    image text,
    DATE DATE not null,
    point_of_interest_uuid UUID not null references point_of_interest(uuid),
    condition_uuid UUID not null references condition(uuid),
-- composite primary key
    primary key (point_of_interest_uuid,
condition_uuid,
DATE),
-- unique together
    unique(point_of_interest_uuid,
condition_uuid,
DATE)
);

comment on
table point_of_interest_conditions is 'An Association table for point of interest conditions, e.g. good, bad.';

comment on
column point_of_interest_conditions.uuid is 'Global Unique Identifier.';

comment on
column point_of_interest_conditions.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column point_of_interest_conditions.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column point_of_interest_conditions.notes is 'Additional information of the point of interest conditions item.';

comment on
column point_of_interest_conditions.image is 'Image of the point of interest conditions item.';

comment on
column point_of_interest_conditions."date" is 'The points of interest inspection date.';
----------------------------------------LANDUSE AREA -------------------------------------
-- LANDUSE AREA TYPE
create table if not exists landuse_area_type(
    	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
   	 last_update_by text not null,
   	 name VARCHAR unique not null,
	notes text,
	image text
);

comment on
table landuse_area_type is 'Lookup table for the landuse area type. Eg: Agriculture, residential, recreation, commercial, transportation etc';

comment on
column landuse_area_type.id is 'The unique landuse area type ID. This is the Primary Key.';

comment on
column landuse_area_type.uuid is 'Global Unique Identifier.';

comment on
column landuse_area_type.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column landuse_area_type.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column landuse_area_type.name is 'The landuse area type field name. This is unique.';

comment on
column landuse_area_type.notes is 'Additional information of the landuse area type.';

comment on
column landuse_area_type.image is 'Image of the landuse area type.';
-- LANDUSE AREA OWNERSHIP TYPE
create table if not exists landuse_area_ownership_type(
    	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
   	last_update_by text not null,
    	name VARCHAR unique not null,
	notes text,
	image text
);

comment on
table landuse_area_ownership_type is 'Lookup table for the landuse area ownership type. Eg: Public or private ';

comment on
column landuse_area_ownership_type.id is 'The unique landuse area ownership type ID. This is the Primary Key.';

comment on
column landuse_area_ownership_type.uuid is 'Global Unique Identifier.';

comment on
column landuse_area_ownership_type.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column landuse_area_ownership_type.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column landuse_area_ownership_type.name is 'The landuse area ownership type field name. This is unique.';

comment on
column landuse_area_ownership_type.notes is 'Additional information of the landuse area ownership type.';

comment on
column landuse_area_ownership_type.image is 'Image of the landuse area ownership type.';
-- LANDUSE AREA OWNER
create table if not exists landuse_area_owner(
    	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
    	name VARCHAR unique,
	notes text,
	image text,
	address text,
	landuse_area_ownership_type_uuid UUID not null references landuse_area_ownership_type(uuid)
);

comment on
table landuse_area_owner is 'Lookup table for the landuse area owner. ';

comment on
column landuse_area_owner.id is 'The unique landuse area owner ID. This is the Primary Key.';

comment on
column landuse_area_owner.uuid is 'Global Unique Identifier.';

comment on
column landuse_area_owner.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column landuse_area_owner.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column landuse_area_owner.name is 'The landuse area ownership field name. This is unique.';

comment on
column landuse_area_owner.notes is 'Additional information of the landuse area owner.';

comment on
column landuse_area_owner.image is 'Image of the landuse area owner.';

comment on
column landuse_area_owner.address is 'Address of the owner of the landuse area.';

comment on
column landuse_area_owner.landuse_area_ownership_type_uuid is 'The foreign key which references the uuid from the landuse area ownership type table.';
-- LANDUSE AREA
create table if not exists landuse_area(
    	id SERIAL not null primary key,
    	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
   	last_update_by text not null,
   	 name VARCHAR unique,
	notes text,
	image text,
    	geometry GEOMETRY(POLYGON,
4326),
    	landuse_area_type_uuid UUID not null references landuse_area_type(uuid),
    	landuse_area_owner_uuid UUID not null references landuse_area_owner(uuid)
);

comment on
table landuse_area is 'Lookup table for the landuse area.';

comment on
column landuse_area.id is 'The unique landuse area ID. This is the Primary Key.';

comment on
column landuse_area.uuid is 'Global Unique Identifier.';

comment on
column landuse_area.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column landuse_area.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column landuse_area.name is 'The landuse area name. This is unique.';

comment on
column landuse_area.notes is 'Additional information of the landuse area.';

comment on
column landuse_area.image is 'Image of the landuse area.';

comment on
column landuse_area.geometry is 'The geometry of landuse (in this case a polygon) and the projection system used.';

comment on
column landuse_area.landuse_area_type_uuid is 'The foreign key which references the uuid from the landuse area type table.';

comment on
column landuse_area.landuse_area_owner_uuid is 'The foreign key which references the uuid from the landuse area owner table.';
-- LANDUSE AREA CONDITION TYPE
create table if not exists landuse_area_condition_type(
   	id SERIAL not null primary key,
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
   	last_update_by text not null,
    	name VARCHAR unique not null,
--lookup names must be unique
notes text,
	image text
);

comment on
table landuse_area_condition_type is 'Lookup table for the landuse area condition type. e.g. Bare, Occupied, Work in Progress';

comment on
column landuse_area_condition_type.id is 'The unique landuse area condition type ID. This is the Primary Key.';

comment on
column landuse_area_condition_type.uuid is 'Global Unique Identifier.';

comment on
column landuse_area_condition_type.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column landuse_area_condition_type.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column landuse_area_condition_type.name is 'The landuse area condition type field name.';

comment on
column landuse_area_condition_type.notes is 'Additional information of the landuse area condition type.';

comment on
column landuse_area_condition_type.image is 'Image of the landuse area condition type.';
-- ASSOCIATION TABLE
-- LANDUSE AREA CONDITIONS
create table if not exists landuse_area_conditions (
	uuid UUID unique not null default gen_random_uuid(),
    	last_update TIMESTAMP default now() not null,
    	last_update_by text not null,
    	name VARCHAR unique,
	notes text,
	image text,
    	date DATE not null,
    	landuse_area_condition_type_uuid UUID not null references landuse_area_condition_type(uuid),
    	landuse_area_uuid UUID not null references landuse_area(uuid),
-- Composite primary key
    	primary key (landuse_area_condition_type_uuid,
landuse_area_uuid,
date),
-- Unique together
   	 unique (landuse_area_condition_type_uuid,
landuse_area_uuid,
date)
);

comment on
table landuse_area_conditions is 'Associative table to store the landuse area of different landuse area condition type.';

comment on
column landuse_area_conditions.uuid is 'Global Unique Identifier.';

comment on
column landuse_area_conditions.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column landuse_area_conditions.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column landuse_area_conditions.name is 'The landuse area conditions name which is unique.';

comment on
column landuse_area_conditions.notes is 'Additional information of the landuse area conditions.';

comment on
column landuse_area_conditions.image is 'Image of the landuse area conditions.';

comment on
column landuse_area_conditions.date is 'The datetime alteration of the conditions. This is the Primary and Composite Key';

comment on
column landuse_area_conditions.landuse_area_uuid is 'The foreign key linking to the landuse area table''s UUID.';

comment on
column landuse_area_conditions.landuse_area_condition_type_uuid is 'The foreign key linking to the landuse area condition type table''s UUID.';
----------------------------------------GATES BY JEREMY-------------------------------------

create table if not exists gate_type (
        id SERIAL not null primary key,
    uuid UUID unique not null default gen_random_uuid(),
        last_update timestamp default now() not null,
        last_update_by text,
        primary_type text not null,
    notes text,
    pic text
);

comment on
table gate_type is 'Describes the type of gate.';

comment on
column gate_type.primary_type is 'Describes the type of gate.';

create table if not exists gate_function (
        id SERIAL not null primary key,
    uuid UUID unique not null default gen_random_uuid(),
        last_update TIMESTAMP default now() not null,
        last_update_by text,
        primary_function text not null,
    notes text,
    pic text
);

comment on
table gate_function is 'This table lists the functions that a gate can perform';

comment on
column gate_function.primary_function is 'Describes the gate function.';

create table if not exists gate_materials (
        id SERIAL not null primary key,
    uuid UUID unique not null default gen_random_uuid(),
        last_update TIMESTAMP default now() not null,
        last_update_by text,
        materials text not null,
    notes text,
    pic text
);

comment on
table gate_materials is 'This table lists the materials that a gate can consist of';

comment on
column gate_materials.materials is 'Describes the gate material.';

create table if not exists gate (
        id SERIAL not null primary key,
    uuid UUID unique not null default gen_random_uuid(),
        last_update TIMESTAMP default now() not null,
        last_update_by text not null,
        name text not null,
    notes text,
    pic text,
    geometry GEOMETRY(point,
4326) not null,
    height_m FLOAT,
    width_m FLOAT,
    installation_date DATE not null,
    is_date_estimated BOOLEAN,
    gate_direction_from_hinge_when_closed FLOAT not null,
    gate_open_maximum_degrees FLOAT,
    gate_open_minimum_degrees FLOAT,
    gate_type_uuid UUID references gate_type(uuid),
    gate_function_uuid UUID references gate_function(uuid)
);

comment on
table gate is 'Items in the Gate table can stand alone or be referenced from other entities like buildings and fences.';

comment on
column gate.geometry is 'This is the Point where the gate is mounted (ie. the Hinge Side).';

comment on
column gate.height_m is 'Enter the height of the Gate in Meters.';

comment on
column gate.width_m is 'Enter the width of the Gate in Meters.';

comment on
column gate.installation_date is 'Enter the date the Gate was installed. This can be an approximate date.';

comment on
column gate.is_date_estimated is 'Was the Gate installation date estimated?';

comment on
column gate.gate_direction_from_hinge_when_closed is 'What direction does the gate go from the hinge? North = 0, East = 90, South = 180, West = 270, Maximum 360 (back to North)';

comment on
column gate.gate_open_maximum_degrees is 'Positive clockwise degrees the gate will open (zero if the gate only opens counterclockwise)';

comment on
column gate.gate_open_minimum_degrees is 'Negative counter-clockwise degrees that the gate opens (zero if the gate only opens clockwise)';

create table if not exists gate_material (
	primary key (fk_gate_uuid,
fk_gate_materials_uuid),
    fk_gate_uuid UUID not null references gate(uuid),
	fk_gate_materials_uuid UUID not null references gate_materials(uuid)
);

create table if not exists building_gate (
	primary key (fk_building_uuid,
fk_gate_uuid),
    fk_building_uuid UUID not null references building(uuid),
	fk_gate_uuid UUID not null references gate(uuid)
);

create table if not exists fence_gate (
	primary key (fk_fence_uuid,
fk_gate_uuid),
    fk_fence_uuid UUID not null references fence(uuid),
	fk_gate_uuid UUID not null references gate(uuid)
);

create table if not exists gate_conditions (
        primary key (gate_uuid,
condition_uuid,
date),
    uuid UUID unique not null default gen_random_uuid(),
        last_update TIMESTAMP default now() not null,
        last_update_by text,
        primary_type text not null,
    notes text,
    pic text,
    date DATE not null,
gate_uuid UUID not null references gate(uuid),
    condition_uuid UUID not null references condition(uuid)
);

----------------------------------------POLES BY CHARLES-------------------------------------
create extension if not exists postgis;

create table if not exists pole_material (
    id serial not null primary key ,
    name text not null ,
    notes text ,
    picture text ,
    last_update TIMESTAMP default now() not null ,
    last_update_by text not null,
    uuid UUID unique not null default gen_random_uuid()
);

comment on
table pole_material is 'Lookup table for the different pole material available e.g steel, concrete';

comment on
column pole_material.id is 'The unique pole material id. This is a primary key';

comment on
column pole_material.name is 'The name of the pole material';

comment on
column pole_material.notes is 'Any additional notes of the name of the pole material';

comment on
column pole_material.picture is 'Any visual representation of the material';

comment on 
column pole_material.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on 
column pole_material.last_update_by is 'The name of the user responsible for the latest update.';

create table if not exists pole_function(
    id serial not null primary key,
    function text not null,
    notes text,
    picture text,
    last_update TIMESTAMP default now() not null,
    last_update_by text not null,
    uuid uuid default gen_random_uuid()
);

comment on 
table pole_function is 'Lookup table for the different pole function e.g telecommunincation pole';

comment on
column pole_function.id is 'The unique pole material id. This is a primary key';

comment on 
column pole_function.function is 'The possible function of a pole e.g street lighting pole or telecommunications pole';

comment on 
column pole_function.notes is 'Any additional information on the pole functionality';

comment on 
column pole_function.picture is 'Any visual representation of the pole function';

comment on 
column pole_function.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column pole_function.last_update_by is 'The name of the user responsible for the latest update.';

create table if not exists pole_condition(
    pole_uuid UUID not null,
    condition_uuid UUID not null,
    primary key (pole_uuid,
condition_uuid,
date),
notes text not null,
    picture text,
    date Date not null,
    last_update TIMESTAMP default now() not null,
    last_update_by text not null,
    uuid uuid default gen_random_uuid(),
    foreign key (pole_uuid) references pole(uuid),
    foreign key (condition_uuid) references condition(uuid)
);

comment on 
table pole_condition is 'The table that records the state of a pole';

comment on
column pole_condition.pole_uuid is 'A foreign key which is used as composite primary key';

comment on
column pole_condition.condition_uuid is 'A foreign key which is used as composite primary key';

comment on
column pole_condition.notes is 'And additional information on the condition of the pole';

comment on
column pole_condition.date is 'Stores the date that is used in the composite key';

comment on
column pole_condition.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column pole_condition.last_update_by is 'The name of the user responsible for the latest update.';

create table if not exists pole (
    id serial not null primary key,
    notes VARCHAR(255),
    installation_date DATE default now() not null,
    geometry GEOMETRY(POINT,
4326) not null,
height FLOAT not null,
    last_update TIMESTAMP not null,
    last_update_by text not null,
    uuid UUID unique not null default gen_random_uuid(),
    pole_material_id INT not null,
pole_function_id INT not null,
    foreign key (pole_material_id) references pole_material(id),
    foreign key (pole_function_id) references pole_function(id)
    );

comment on
table pole is 'Pole table records any point entered as a pole e.g street pole';

comment on 
column pole.notes is 'Anything unique or additional information about the pole';

comment on
column pole.installation_date is 'The date and time when the pole was installed or created';

comment on 
column pole.height is 'The height for the pole created';

comment on
column pole.last_update is 'The date that the last update was made (yyyy-mm-dd hh:mm:ss).';

comment on
column pole.last_update_by is 'The name of the user responsible for the latest update.';

comment on
column pole.pole_material_id is 'Foreign key pole material';

comment on 
column pole.pole_function_id is 'Foreign key pole function';