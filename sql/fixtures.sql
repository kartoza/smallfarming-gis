-- vegetation
--months of the year
INSERT INTO month(last_update_by, name, sort_order) values ('Luna', 'January', 1);
INSERT INTO month(last_update_by, name, sort_order) values ('Luna', 'February', 2);
INSERT INTO month(last_update_by, name, sort_order) values ('Luna', 'March', 3);
INSERT INTO month(last_update_by, name, sort_order) values ('Luna', 'April', 4);
INSERT INTO month(last_update_by, name, sort_order) values ('Luna', 'May', 5);
INSERT INTO month(last_update_by, name, sort_order) values ('Luna', 'June', 6);
INSERT INTO month(last_update_by, name, sort_order) values ('Luna', 'July', 7);
INSERT INTO month(last_update_by, name, sort_order) values ('Luna', 'August', 8);
INSERT INTO month(last_update_by, name, sort_order) values ('Luna', 'September', 9);
INSERT INTO month(last_update_by, name, sort_order) values ('Luna', 'October', 10);
INSERT INTO month(last_update_by, name, sort_order) values ('Luna', 'November', 11);
INSERT INTO month(last_update_by, name, sort_order) values ('Luna', 'December',12);

--plant growth activities type
INSERT INTO plant_growth_activity_type(last_update_by, name, sort_order) VALUES ('Luna', 'Sprouting', 1);
INSERT INTO plant_growth_activity_type(last_update_by, name, sort_order) VALUES ('Luna', 'Seeding', 2);
INSERT INTO plant_growth_activity_type(last_update_by, name, sort_order) VALUES ('Luna', 'Vegetative', 3);
INSERT INTO plant_growth_activity_type(last_update_by, name, sort_order) VALUES ('Luna', 'Budding', 4);
INSERT INTO plant_growth_activity_type(last_update_by, name, sort_order) VALUES ('Luna', 'Flowering', 5);
INSERT INTO plant_growth_activity_type(last_update_by, name, sort_order) VALUES ('Luna', 'Ripening', 6);

--plant usage
INSERT INTO plant_usage(last_update_by, name) VALUES ('Luna', 'Food Plant');
INSERT INTO plant_usage(last_update_by, name) VALUES ('Luna', 'Fodder Plant');
INSERT INTO plant_usage(last_update_by, name) VALUES ('Luna', 'Commercial Plant');


-- electricity
--electricity line type
INSERT INTO electricity_line_type(last_update_by, name, sort_order, current_a, voltage_v) VALUES ('Ashleigh', 'Low Voltage', 1, 50, 230);
INSERT INTO electricity_line_type(last_update_by, name, sort_order, current_a, voltage_v) VALUES ('Ashleigh', 'Medium Voltage', 2, 75, 11000);
INSERT INTO electricity_line_type(last_update_by, name, sort_order, current_a, voltage_v) VALUES ('Ashleigh', 'High Voltage', 3, 100, 33000);
INSERT INTO electricity_line_type(last_update_by, name, sort_order, current_a, voltage_v) VALUES ('Ashleigh', 'Extra-High Voltage', 4, 120, 365000);
INSERT INTO electricity_line_type(last_update_by, name, sort_order, current_a, voltage_v) VALUES ('Ashleigh', 'Ultra-High Voltage', 5, 150, 800000 );

--electricity line condition type
INSERT INTO electricity_line_condition_type(last_update_by, name) VALUES ('Ashleigh', 'Working');   
INSERT INTO electricity_line_condition_type(last_update_by, name) VALUES ('Ashleigh', 'Broken');    


-- water
-- water source
INSERT INTO water_source (last_update_by, name) VALUES ('Polly', 'Aquifer');
INSERT INTO water_source (last_update_by, name) VALUES ('Polly', 'River');
INSERT INTO water_source (last_update_by, name) VALUES ('Polly', 'Reservoir');
INSERT INTO water_source (last_update_by, name) VALUES ('Polly', 'Rainwater');

-- water polygon type
INSERT INTO water_polygon_type (last_update_by, name) VALUES ('Polly', 'Wetland');
INSERT INTO water_polygon_type (last_update_by, name) VALUES ('Polly', 'Lake');
INSERT INTO water_polygon_type (last_update_by, name) VALUES ('Polly', 'Reservoir');
INSERT INTO water_polygon_type (last_update_by, name) VALUES ('Polly', 'Pond');

-- water point type
INSERT INTO water_point_type (last_update_by, name) VALUES ('Polly', 'Drinking Trough'); 
INSERT INTO water_point_type (last_update_by, name) VALUES ('Polly', 'Tap'); 
INSERT INTO water_point_type (last_update_by, name) VALUES ('Polly', 'Borehole');
INSERT INTO water_point_type (last_update_by, name) VALUES ('Polly', 'Water Tank');  

-- water line type
INSERT INTO water_line_type (last_update_by, name, sort_order) VALUES ('Polly', 'River', 1);
INSERT INTO water_line_type (last_update_by, name, sort_order) VALUES ('Polly', 'Stream', 2);


-- readings
INSERT INTO readings(last_update_by, name) VALUES ('Mondli', 'Moisture Testers');

-- fence
-- fence type
INSERT INTO fence_type (last_update_by, name, sort_order) VALUES ('Jeff', 'Barbed wire', 1);
INSERT INTO fence_type (last_update_by, name, sort_order) VALUES ('Jeff', 'Chain link', 2);
INSERT INTO fence_type (last_update_by, name, sort_order) VALUES ('Jeff', 'Electric fence', 3);
INSERT INTO fence_type (last_update_by, name, sort_order) VALUES ('Jeff', 'Split rail', 4);
INSERT INTO fence_type (last_update_by, name, sort_order) VALUES ('Jeff', 'Wall', 5);
INSERT INTO fence_type (last_update_by, name, sort_order) VALUES ('Jeff', 'Wood', 6);
INSERT INTO fence_type (last_update_by, name, sort_order) VALUES ('Jeff', 'Wrought fence', 7);

-- point of interest
-- point of interest type
INSERT INTO point_of_interest_type (last_update_by, name, sort_order) VALUES ('Jeff', 'Bridge', 1);
INSERT INTO point_of_interest_type (last_update_by, name, sort_order) VALUES ('Jeff', 'Electric', 2);
INSERT INTO point_of_interest_type (last_update_by, name, sort_order) VALUES ('Jeff', 'Fence', 3);
INSERT INTO point_of_interest_type (last_update_by, name, sort_order) VALUES ('Jeff', 'Gate', 4);
INSERT INTO point_of_interest_type (last_update_by, name, sort_order) VALUES ('Jeff', 'Ruin', 5);
INSERT INTO point_of_interest_type (last_update_by, name, sort_order) VALUES ('Jeff', 'Water point', 6);

-- condition
INSERT INTO "condition"  (last_update_by, name) VALUES ('Jeff', 'Fixed');
INSERT INTO "condition"  (last_update_by, name) VALUES ('Jeff', 'Broken');

----------------------------------------FAUNA-------------------------------------
--ANIMAL ACTIVITY
INSERT INTO activity (name, last_update_by) VALUES ('feeding', 'Mpilwenhle');
INSERT INTO activity (name, last_update_by) VALUES ('drinking', 'Mpilwenhle');
INSERT INTO activity (name, last_update_by) VALUES ('mograting', 'Mpilwenhle');
INSERT INTO activity (name, last_update_by) VALUES ('resting', 'Mpilwenhle');
INSERT INTO activity (name, last_update_by) VALUES ('running', 'Mpilwenhle');

--ANIMAL HABITAT
INSERT INTO habitat (name, last_update_by) VALUES ('forest', 'Mpilwenhle');
INSERT INTO habitat (name, last_update_by) VALUES ('savanna', 'Mpilwenhle');
INSERT INTO habitat (name, last_update_by) VALUES ('artic', 'Mpilwenhle');
INSERT INTO habitat (name, last_update_by) VALUES ('ocean', 'Mpilwenhle');
INSERT INTO habitat (name, last_update_by) VALUES ('grassland', 'Mpilwenhle');
INSERT INTO habitat (name, last_update_by) VALUES ('karoo', 'Mpilwenhle');
INSERT INTO habitat (name, last_update_by) VALUES ('desert', 'Mpilwenhle');


--ANIMAL TAXON_RANK
INSERT INTO taxon_rank (name, last_update_by) VALUES ('Kingdom', 'Mpilwenhle');
INSERT INTO taxon_rank (name, last_update_by) VALUES ('Phylum', 'Mpilwenhle');
INSERT INTO taxon_rank (name, last_update_by) VALUES ('Family', 'Mpilwenhle');
INSERT INTO taxon_rank (name, last_update_by) VALUES ('Order', 'Mpilwenhle');
INSERT INTO taxon_rank (name, last_update_by) VALUES ('Class', 'Mpilwenhle');
INSERT INTO taxon_rank (name, last_update_by) VALUES ('Genus', 'Mpilwenhle');
INSERT INTO taxon_rank (name, last_update_by) VALUES ('Species', 'Mpilwenhle');

--ANIMAL TAXON
INSERT INTO taxon (scientific_name, last_update_by, taxon_rank_uuid, parent_uuid)
VALUES ('Animalia', 'Mpilwenhle', '5a70ca78-7679-49ae-b672-76ab6ddac7ad', null);
INSERT INTO taxon (scientific_name, last_update_by, taxon_rank_uuid, parent_uuid)
VALUES ('Chordata', 'Mpilwenhle', '9493133d-0fde-420b-aa67-59909011eb8d', '8cdf3f7e-ec06-47f6-9da7-02a0aebbdbe3');
INSERT INTO taxon (scientific_name, last_update_by, taxon_rank_uuid, parent_uuid)
VALUES ('Mammalia', 'Mpilwenhle', '3053d90a-79c9-4d1c-8aa9-868d6329f5d9', '248e468a-e212-4069-8a33-926f5e1c1b43');
INSERT INTO taxon (scientific_name, last_update_by, taxon_rank_uuid, parent_uuid)
VALUES ('Artiodactyla', 'Mpilwenhle', 'b4abaf6e-8107-4ffb-84f1-940c970516ff', '249baeba-86cb-4316-a36d-4b2d434306c0');
INSERT INTO taxon (scientific_name, last_update_by, taxon_rank_uuid, parent_uuid)
VALUES ('Bovidae', 'Mpilwenhle', 'b8fb7897-d7c9-4923-8ce3-4cbece54d9c8', '7f7d3f92-a153-4609-b264-bab7e3c4417c');
INSERT INTO taxon (scientific_name, last_update_by, taxon_rank_uuid, parent_uuid)
VALUES ('Capra', 'Mpilwenhle', 'c8cedd9e-4d36-4e00-8554-02c692da40c9', '2774e1be-58a8-4189-b41b-75393cf78099');
INSERT INTO taxon (scientific_name, last_update_by, taxon_rank_uuid, parent_uuid)
VALUES ('Capra nubiana','Mpilwenhle', '0388c2a7-e8c6-4728-90ef-9f82d62780c6', 'd4b7b489-420d-415f-bee6-aa9ed68b9992');

UPDATE taxon SET common_name = 'goat' WHERE scientific_name = 'Capra nubiana' AND parent_uuid = 'd4b7b489-420d-415f-bee6-aa9ed68b9992';

INSERT INTO taxon (scientific_name, last_update_by, taxon_rank_uuid, parent_uuid)
VALUES ('Animalia', 'Mpilwenhle', '5a70ca78-7679-49ae-b672-76ab6ddac7ad', null);
INSERT INTO taxon (scientific_name, last_update_by, taxon_rank_uuid, parent_uuid)
VALUES ('Chordata', 'Mpilwenhle', '9493133d-0fde-420b-aa67-59909011eb8d', '8cdf3f7e-ec06-47f6-9da7-02a0aebbdbe3');
INSERT INTO taxon (scientific_name, last_update_by, taxon_rank_uuid, parent_uuid)
VALUES ('Mammalia', 'Mpilwenhle', '3053d90a-79c9-4d1c-8aa9-868d6329f5d9', '248e468a-e212-4069-8a33-926f5e1c1b43');
INSERT INTO taxon (scientific_name, last_update_by, taxon_rank_uuid, parent_uuid)
VALUES ('Artiodactyla', 'Mpilwenhle', 'b4abaf6e-8107-4ffb-84f1-940c970516ff', '249baeba-86cb-4316-a36d-4b2d434306c0');
INSERT INTO taxon (scientific_name, last_update_by, taxon_rank_uuid, parent_uuid)
VALUES ('Bovidae', 'Mpilwenhle', 'b8fb7897-d7c9-4923-8ce3-4cbece54d9c8', '7f7d3f92-a153-4609-b264-bab7e3c4417c');
INSERT INTO taxon (scientific_name, last_update_by, taxon_rank_uuid, parent_uuid)
VALUES ('Syncerus', 'Mpilwenhle', 'c8cedd9e-4d36-4e00-8554-02c692da40c9', '2774e1be-58a8-4189-b41b-75393cf78099');
INSERT INTO taxon (scientific_name, common_name, last_update_by, taxon_rank_uuid, parent_uuid)
VALUES ('Syncerus caffer','buffalo''Mpilwenhle', '0388c2a7-e8c6-4728-90ef-9f82d62780c6', 'd4b7b489-420d-415f-bee6-aa9ed68b9992');


SELECT * FROM taxon_rank;
UPDATE taxon SET name = 'goat' WHERE scientific_name = 'Capra nubiana'

