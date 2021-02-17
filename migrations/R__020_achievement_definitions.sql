-- Repeatable migration: Flyway will replay this SQL every time this file (checksum) has changed!
-- You can not delete items by removing them from this file! Also make sure never to edit or reuse existing ids!

-- If you want to edit an existing or add a new achievement, just append it to the SQL command and run flyway migrate.
-- Matching achievement definitions and their logic need to be hardcoded into the lobby server.
-- A list of all achievements is held here: https://github.com/FAForever/server/blob/develop/server/stats/achievement_service.py

INSERT INTO `achievement_definitions` (id, `order`, name_key, description_key, type, total_steps, revealed_icon_url, unlocked_icon_url, initial_state, experience_points) VALUES
('02081bb0-3b7a-4a36-99ef-5ae5d92d7146',16,'achievement.rusher.title','achievement.rusher.description','STANDARD',NULL,'https://content.faforever.com/achievements/02081bb0-3b7a-4a36-99ef-5ae5d92d7146.png','https://content.faforever.com/achievements/02081bb0-3b7a-4a36-99ef-5ae5d92d7146.png','REVEALED',10),
('045342e1-ae0d-4ef6-98bc-0bb54ffe00b3',41,'achievement.whatASwarm.title','achievement.whatASwarm.description','INCREMENTAL',500,'https://content.faforever.com/achievements/045342e1-ae0d-4ef6-98bc-0bb54ffe00b3.png','https://content.faforever.com/achievements/045342e1-ae0d-4ef6-98bc-0bb54ffe00b3.png','REVEALED',10),
('06a39447-66a3-4160-93d5-d48337b0cbb5',24,'achievement.blaze.title','achievement.blaze.description','INCREMENTAL',25,'https://content.faforever.com/achievements/06a39447-66a3-4160-93d5-d48337b0cbb5.png','https://content.faforever.com/achievements/06a39447-66a3-4160-93d5-d48337b0cbb5.png','REVEALED',25),
('06b19364-5aab-4bce-883d-975f663d2091',38,'achievement.techie.title','achievement.techie.description','INCREMENTAL',5,'https://content.faforever.com/achievements/06b19364-5aab-4bce-883d-975f663d2091.png','https://content.faforever.com/achievements/06b19364-5aab-4bce-883d-975f663d2091.png','REVEALED',5),
('08629902-8e18-4d92-ad14-c8ecde4a8674',12,'achievement.hattrick.title','achievement.hattrick.description','STANDARD',NULL,'https://content.faforever.com/achievements/08629902-8e18-4d92-ad14-c8ecde4a8674.png','https://content.faforever.com/achievements/08629902-8e18-4d92-ad14-c8ecde4a8674.png','REVEALED',10),
('10f17c75-1154-447d-a4f7-6217add0407e',37,'achievement.fieldMarshal.title','achievement.fieldMarshal.description','INCREMENTAL',50,'https://content.faforever.com/achievements/10f17c75-1154-447d-a4f7-6217add0407e.png','https://content.faforever.com/achievements/10f17c75-1154-447d-a4f7-6217add0407e.png','REVEALED',20),
('1a3ad9e0-53eb-47d0-9404-14dbcefbed9b',17,'achievement.ma12Striker.title','achievement.ma12Striker.description','INCREMENTAL',5,'https://content.faforever.com/achievements/1a3ad9e0-53eb-47d0-9404-14dbcefbed9b.png','https://content.faforever.com/achievements/1a3ad9e0-53eb-47d0-9404-14dbcefbed9b.png','REVEALED',5),
('1c8fcb6f-a5b6-497f-8b0d-ac5ac6fef408',47,'achievement.incomingRobots.title','achievement.incomingRobots.description','INCREMENTAL',50,'https://content.faforever.com/achievements/1c8fcb6f-a5b6-497f-8b0d-ac5ac6fef408.png','https://content.faforever.com/achievements/1c8fcb6f-a5b6-497f-8b0d-ac5ac6fef408.png','REVEALED',10),
('1f140add-b0ae-4e02-91a0-45d62b988a22',51,'achievement.alienInvasion.title','achievement.alienInvasion.description','INCREMENTAL',50,'https://content.faforever.com/achievements/1f140add-b0ae-4e02-91a0-45d62b988a22.png','https://content.faforever.com/achievements/1f140add-b0ae-4e02-91a0-45d62b988a22.png','REVEALED',10),
('2103e0de-1c87-4fba-bc1b-0bba66669607',62,'achievement.dontMessWitHme.title','achievement.dontMessWitHme.description','INCREMENTAL',100,'https://content.faforever.com/achievements/2103e0de-1c87-4fba-bc1b-0bba66669607.png','https://content.faforever.com/achievements/2103e0de-1c87-4fba-bc1b-0bba66669607.png','REVEALED',10),
('290df67c-eb01-4fe7-9e32-caae1c10442f',13,'achievement.thatWasClose.title','achievement.thatWasClose.description','STANDARD',NULL,'https://content.faforever.com/achievements/290df67c-eb01-4fe7-9e32-caae1c10442f.png','https://content.faforever.com/achievements/290df67c-eb01-4fe7-9e32-caae1c10442f.png','REVEALED',5),
('2d5cd544-4fc8-47b9-8ebb-e72ed6423d51',30,'achievement.seaman.title','achievement.seaman.description','INCREMENTAL',25,'https://content.faforever.com/achievements/2d5cd544-4fc8-47b9-8ebb-e72ed6423d51.png','https://content.faforever.com/achievements/2d5cd544-4fc8-47b9-8ebb-e72ed6423d51.png','REVEALED',10),
('305a8d34-42fd-42f3-ba91-d9f5e437a9a6',14,'achievement.topScore.title','achievement.topScore.description','STANDARD',NULL,'https://content.faforever.com/achievements/305a8d34-42fd-42f3-ba91-d9f5e437a9a6.png','https://content.faforever.com/achievements/305a8d34-42fd-42f3-ba91-d9f5e437a9a6.png','REVEALED',10),
('31a728f8-ace9-45fa-a3f2-57084bc9e461',57,'achievement.iHaveACannon.title','achievement.iHaveACannon.description','STANDARD',NULL,'https://content.faforever.com/achievements/31a728f8-ace9-45fa-a3f2-57084bc9e461.png','https://content.faforever.com/achievements/31a728f8-ace9-45fa-a3f2-57084bc9e461.png','REVEALED',10),
('326493d7-ce2c-4a43-bbc8-3e990e2685a1',18,'achievement.riptide.title','achievement.riptide.description','INCREMENTAL',25,'https://content.faforever.com/achievements/326493d7-ce2c-4a43-bbc8-3e990e2685a1.png','https://content.faforever.com/achievements/326493d7-ce2c-4a43-bbc8-3e990e2685a1.png','REVEALED',10),
('46a6e900-88bb-4eae-92d1-4f31b53faedc',59,'achievement.soMuchResources.title','achievement.soMuchResources.description','STANDARD',NULL,'https://content.faforever.com/achievements/46a6e900-88bb-4eae-92d1-4f31b53faedc.png','https://content.faforever.com/achievements/46a6e900-88bb-4eae-92d1-4f31b53faedc.png','REVEALED',10),
('50260d04-90ff-45c8-816b-4ad8d7b97ecd',56,'achievement.rainmaker.title','achievement.rainmaker.description','STANDARD',NULL,'https://content.faforever.com/achievements/50260d04-90ff-45c8-816b-4ad8d7b97ecd.png','https://content.faforever.com/achievements/50260d04-90ff-45c8-816b-4ad8d7b97ecd.png','REVEALED',10),
('53173f4d-450c-46f0-ac59-85834cc74972',29,'achievement.landLubber.title','achievement.landLubber.description','INCREMENTAL',5,'https://content.faforever.com/achievements/53173f4d-450c-46f0-ac59-85834cc74972.png','https://content.faforever.com/achievements/53173f4d-450c-46f0-ac59-85834cc74972.png','REVEALED',5),
('539da20b-5026-4c49-8e22-e4a305d58845',53,'achievement.deathFromAbove.title','achievement.deathFromAbove.description','INCREMENTAL',50,'https://content.faforever.com/achievements/539da20b-5026-4c49-8e22-e4a305d58845.png','https://content.faforever.com/achievements/539da20b-5026-4c49-8e22-e4a305d58845.png','REVEALED',10),
('5b7ec244-58c0-40ca-9d68-746b784f0cad',5,'achievement.firstSuccess.title','achievement.firstSuccess.description','STANDARD',NULL,'https://content.faforever.com/achievements/5b7ec244-58c0-40ca-9d68-746b784f0cad.png','https://content.faforever.com/achievements/5b7ec244-58c0-40ca-9d68-746b784f0cad.png','REVEALED',5),
('60d1e60d-036b-491e-a992-2b18321848c2',52,'achievement.assWasher.title','achievement.assWasher.description','INCREMENTAL',50,'https://content.faforever.com/achievements/60d1e60d-036b-491e-a992-2b18321848c2.png','https://content.faforever.com/achievements/60d1e60d-036b-491e-a992-2b18321848c2.png','REVEALED',10),
('6a37e2fc-1609-465e-9eca-91eeda4e63c4',3,'achievement.senior.title','achievement.senior.description','INCREMENTAL',250,'https://content.faforever.com/achievements/6a37e2fc-1609-465e-9eca-91eeda4e63c4.png','https://content.faforever.com/achievements/6a37e2fc-1609-465e-9eca-91eeda4e63c4.png','REVEALED',20),
('6acc8bc6-1fd3-4c33-97a1-85dfed6d167a',28,'achievement.suthanus.title','achievement.suthanus.description','INCREMENTAL',50,'https://content.faforever.com/achievements/6acc8bc6-1fd3-4c33-97a1-85dfed6d167a.png','https://content.faforever.com/achievements/6acc8bc6-1fd3-4c33-97a1-85dfed6d167a.png','REVEALED',20),
('7aa7fc88-48a2-4e49-9cd7-35e2f6ce4cec',27,'achievement.yenzyne.title','achievement.yenzyne.description','INCREMENTAL',25,'https://content.faforever.com/achievements/7aa7fc88-48a2-4e49-9cd7-35e2f6ce4cec.png','https://content.faforever.com/achievements/7aa7fc88-48a2-4e49-9cd7-35e2f6ce4cec.png','REVEALED',10),
('7d6d8c55-3e2a-41d0-a97e-d35513af1ec6',19,'achievement.demolisher.title','achievement.demolisher.description','INCREMENTAL',50,'https://content.faforever.com/achievements/7d6d8c55-3e2a-41d0-a97e-d35513af1ec6.png','https://content.faforever.com/achievements/7d6d8c55-3e2a-41d0-a97e-d35513af1ec6.png','REVEALED',20),
('7f993f98-dbec-41a5-9c9a-5f85edf30767',25,'achievement.serenity.title','achievement.serenity.description','INCREMENTAL',50,'https://content.faforever.com/achievements/7f993f98-dbec-41a5-9c9a-5f85edf30767.png','https://content.faforever.com/achievements/7f993f98-dbec-41a5-9c9a-5f85edf30767.png','REVEALED',50),
('805f268c-88aa-4073-aa2b-ea30700f70d6',4,'achievement.addict.title','achievement.addict.description','INCREMENTAL',1000,'https://content.faforever.com/achievements/805f268c-88aa-4073-aa2b-ea30700f70d6.png','https://content.faforever.com/achievements/805f268c-88aa-4073-aa2b-ea30700f70d6.png','REVEALED',50),
('987ca192-26e1-4b96-b593-40c115451cc0',58,'achievement.makeItHail.title','achievement.makeItHail.description','STANDARD',NULL,'https://content.faforever.com/achievements/987ca192-26e1-4b96-b593-40c115451cc0.png','https://content.faforever.com/achievements/987ca192-26e1-4b96-b593-40c115451cc0.png','REVEALED',10),
('9ad697bb-441e-45a5-b682-b9227e8eef3e',60,'achievement.nuclearWar.title','achievement.nuclearWar.description','STANDARD',NULL,'https://content.faforever.com/achievements/9ad697bb-441e-45a5-b682-b9227e8eef3e.png','https://content.faforever.com/achievements/9ad697bb-441e-45a5-b682-b9227e8eef3e.png','REVEALED',10),
('a1f87fb7-67ca-4a86-afc6-f23a41b40e9f',48,'achievement.arachnologist.title','achievement.arachnologist.description','INCREMENTAL',50,'https://content.faforever.com/achievements/a1f87fb7-67ca-4a86-afc6-f23a41b40e9f.png','https://content.faforever.com/achievements/a1f87fb7-67ca-4a86-afc6-f23a41b40e9f.png','REVEALED',10),
('a4ade3d4-d541-473f-9788-e92339446d75',33,'achievement.wingman.title','achievement.wingman.description','INCREMENTAL',25,'https://content.faforever.com/achievements/a4ade3d4-d541-473f-9788-e92339446d75.png','https://content.faforever.com/achievements/a4ade3d4-d541-473f-9788-e92339446d75.png','REVEALED',10),
('a6b7dfa1-1ebc-4c6d-9305-4a9d623e1b4f',61,'achievement.drEvil.title','achievement.drEvil.description','INCREMENTAL',500,'https://content.faforever.com/achievements/a6b7dfa1-1ebc-4c6d-9305-4a9d623e1b4f.png','https://content.faforever.com/achievements/a6b7dfa1-1ebc-4c6d-9305-4a9d623e1b4f.png','REVEALED',10),
('a909629f-46f5-469e-afd1-192d42f55e4d',55,'achievement.itAintACity.title','achievement.itAintACity.description','INCREMENTAL',50,'https://content.faforever.com/achievements/a909629f-46f5-469e-afd1-192d42f55e4d.png','https://content.faforever.com/achievements/a909629f-46f5-469e-afd1-192d42f55e4d.png','REVEALED',10),
('a98fcfaf-29ac-4526-84c2-44f284518f8c',46,'achievement.flyingDeath.title','achievement.flyingDeath.description','INCREMENTAL',50,'https://content.faforever.com/achievements/a98fcfaf-29ac-4526-84c2-44f284518f8c.png','https://content.faforever.com/achievements/a98fcfaf-29ac-4526-84c2-44f284518f8c.png','REVEALED',10),
('ab241de5-e773-412e-b073-090da8e38c4c',50,'achievement.fatterIsBetter.title','achievement.fatterIsBetter.description','INCREMENTAL',50,'https://content.faforever.com/achievements/ab241de5-e773-412e-b073-090da8e38c4c.png','https://content.faforever.com/achievements/ab241de5-e773-412e-b073-090da8e38c4c.png','REVEALED',10),
('af161922-3e52-4600-9161-d850ab0fae86',21,'achievement.wagner.title','achievement.wagner.description','INCREMENTAL',25,'https://content.faforever.com/achievements/af161922-3e52-4600-9161-d850ab0fae86.png','https://content.faforever.com/achievements/af161922-3e52-4600-9161-d850ab0fae86.png','REVEALED',10),
('bd12277a-6604-466a-9ee6-af6908573585',4,'achievement.veteran.title','achievement.veteran.description','INCREMENTAL',500,'https://content.faforever.com/achievements/bd12277a-6604-466a-9ee6-af6908573585.png','https://content.faforever.com/achievements/bd12277a-6604-466a-9ee6-af6908573585.png','REVEALED',30),
('bd77964b-c06b-4649-bf7c-d35cb7715854',31,'achievement.admiralOfTheFleet.title','achievement.admiralOfTheFleet.description','INCREMENTAL',50,'https://content.faforever.com/achievements/bd77964b-c06b-4649-bf7c-d35cb7715854.png','https://content.faforever.com/achievements/bd77964b-c06b-4649-bf7c-d35cb7715854.png','REVEALED',20),
('c1ccde26-8449-4625-b769-7d8f75fa8df3',32,'achievement.wrightBrother.title','achievement.wrightBrother.description','INCREMENTAL',5,'https://content.faforever.com/achievements/c1ccde26-8449-4625-b769-7d8f75fa8df3.png','https://content.faforever.com/achievements/c1ccde26-8449-4625-b769-7d8f75fa8df3.png','REVEALED',5),
('c6e6039f-c543-424e-ab5f-b34df1336e81',1,'achievement.novice.title','achievement.novice.description','INCREMENTAL',10,'https://content.faforever.com/achievements/c6e6039f-c543-424e-ab5f-b34df1336e81.png','https://content.faforever.com/achievements/c6e6039f-c543-424e-ab5f-b34df1336e81.png','REVEALED',5),
('c964ac69-b146-43d0-bd7a-cd22144f9983',26,'achievement.thaam.title','achievement.thaam.description','INCREMENTAL',5,'https://content.faforever.com/achievements/c964ac69-b146-43d0-bd7a-cd22144f9983.png','https://content.faforever.com/achievements/c964ac69-b146-43d0-bd7a-cd22144f9983.png','REVEALED',5),
('cd64c5e7-b063-4543-9f52-0e87883b33a9',39,'achievement.iLoveBigToys.title','achievement.iLoveBigToys.description','INCREMENTAL',25,'https://content.faforever.com/achievements/cd64c5e7-b063-4543-9f52-0e87883b33a9.png','https://content.faforever.com/achievements/cd64c5e7-b063-4543-9f52-0e87883b33a9.png','REVEALED',10),
('d1d50fbb-7fe9-41b0-b667-4433704b8a2c',20,'achievement.mantis.title','achievement.mantis.description','INCREMENTAL',5,'https://content.faforever.com/achievements/d1d50fbb-7fe9-41b0-b667-4433704b8a2c.png','https://content.faforever.com/achievements/d1d50fbb-7fe9-41b0-b667-4433704b8a2c.png','REVEALED',5),
('d38aec23-e487-4aa2-899e-418e29ffbd36',42,'achievement.theTransporter.title','achievement.theTransporter.description','INCREMENTAL',500,'https://content.faforever.com/achievements/d38aec23-e487-4aa2-899e-418e29ffbd36.png','https://content.faforever.com/achievements/d38aec23-e487-4aa2-899e-418e29ffbd36.png','REVEALED',10),
('d3d2c78b-d42d-4b65-99b8-a350f119f898',15,'achievement.unbeatable.title','achievement.unbeatable.description','INCREMENTAL',10,'https://content.faforever.com/achievements/d3d2c78b-d42d-4b65-99b8-a350f119f898.png','https://content.faforever.com/achievements/d3d2c78b-d42d-4b65-99b8-a350f119f898.png','REVEALED',20),
('d5c759fe-a1a8-4103-888d-3ba319562867',2,'achievement.junior.title','achievement.junior.description','INCREMENTAL',50,'https://content.faforever.com/achievements/d5c759fe-a1a8-4103-888d-3ba319562867.png','https://content.faforever.com/achievements/d5c759fe-a1a8-4103-888d-3ba319562867.png','REVEALED',10),
('d656ade4-e054-415a-a2e9-5f4105f7d724',23,'achievement.aurora.title','achievement.aurora.description','INCREMENTAL',5,'https://content.faforever.com/achievements/d656ade4-e054-415a-a2e9-5f4105f7d724.png','https://content.faforever.com/achievements/d656ade4-e054-415a-a2e9-5f4105f7d724.png','REVEALED',5),
('db141e87-5818-435f-80a3-08cc6f1fdac6',49,'achievement.holyCrab.title','achievement.holyCrab.description','INCREMENTAL',50,'https://content.faforever.com/achievements/db141e87-5818-435f-80a3-08cc6f1fdac6.png','https://content.faforever.com/achievements/db141e87-5818-435f-80a3-08cc6f1fdac6.png','REVEALED',10),
('e220d5e6-481c-4347-ac69-b6b6f956bc0f',34,'achievement.kingOfTheSkies.title','achievement.kingOfTheSkies.description','INCREMENTAL',50,'https://content.faforever.com/achievements/e220d5e6-481c-4347-ac69-b6b6f956bc0f.png','https://content.faforever.com/achievements/e220d5e6-481c-4347-ac69-b6b6f956bc0f.png','REVEALED',20),
('e5c63aec-20a0-4263-841d-b7bc45209713',35,'achievement.militiaman.title','achievement.militiaman.description','INCREMENTAL',5,'https://content.faforever.com/achievements/e5c63aec-20a0-4263-841d-b7bc45209713.png','https://content.faforever.com/achievements/e5c63aec-20a0-4263-841d-b7bc45209713.png','REVEALED',5),
('e603f306-ba6b-4507-9556-37a308e5a722',54,'achievement.stormySea.title','achievement.stormySea.description','INCREMENTAL',50,'https://content.faforever.com/achievements/e603f306-ba6b-4507-9556-37a308e5a722.png','https://content.faforever.com/achievements/e603f306-ba6b-4507-9556-37a308e5a722.png','REVEALED',10),
('e7645e7c-7456-48a8-a562-d97521498e7e',44,'achievement.deadlyBugs.title','achievement.deadlyBugs.description','INCREMENTAL',500,'https://content.faforever.com/achievements/e7645e7c-7456-48a8-a562-d97521498e7e.png','https://content.faforever.com/achievements/e7645e7c-7456-48a8-a562-d97521498e7e.png','REVEALED',10),
('e8af7cc9-aaa6-4d0e-8e5a-481702a83a4e',40,'achievement.experimentalist.title','achievement.experimentalist.description','INCREMENTAL',50,'https://content.faforever.com/achievements/e8af7cc9-aaa6-4d0e-8e5a-481702a83a4e.png','https://content.faforever.com/achievements/e8af7cc9-aaa6-4d0e-8e5a-481702a83a4e.png','REVEALED',20),
('eb1ee9ab-4828-417b-b3e8-c8281ee7a353',43,'achievement.whoNeedsSupport.title','achievement.whoNeedsSupport.description','INCREMENTAL',10,'https://content.faforever.com/achievements/eb1ee9ab-4828-417b-b3e8-c8281ee7a353.png','https://content.faforever.com/achievements/eb1ee9ab-4828-417b-b3e8-c8281ee7a353.png','REVEALED',10),
('ec8faec7-e3e1-436e-a1ac-9f7adc3d0387',36,'achievement.grenadier.title','achievement.grenadier.description','INCREMENTAL',25,'https://content.faforever.com/achievements/ec8faec7-e3e1-436e-a1ac-9f7adc3d0387.png','https://content.faforever.com/achievements/ec8faec7-e3e1-436e-a1ac-9f7adc3d0387.png','REVEALED',10),
('f0cde5d8-4933-4074-a2fb-819074d21abd',45,'achievement.noMercy.title','achievement.noMercy.description','INCREMENTAL',500,'https://content.faforever.com/achievements/f0cde5d8-4933-4074-a2fb-819074d21abd.png','https://content.faforever.com/achievements/f0cde5d8-4933-4074-a2fb-819074d21abd.png','REVEALED',10),
('ff23024e-f533-4e23-8f8f-ecc21d5283f8',22,'achievement.trebuchet.title','achievement.trebuchet.description','INCREMENTAL',50,'https://content.faforever.com/achievements/ff23024e-f533-4e23-8f8f-ecc21d5283f8.png','https://content.faforever.com/achievements/ff23024e-f533-4e23-8f8f-ecc21d5283f8.png','REVEALED',20)
-- add new row above this comment (don't forget to append the comma to the previous one)
ON DUPLICATE KEY UPDATE
    `order`=VALUES(`order`),
    name_key=VALUES(name_key),
    description_key=VALUES(description_key),
    type=VALUES(type),
    total_steps=VALUES(total_steps),
    revealed_icon_url=VALUES(revealed_icon_url),
    unlocked_icon_url=VALUES(unlocked_icon_url),
    initial_state=VALUES(initial_state),
    experience_points=VALUES(experience_points);
