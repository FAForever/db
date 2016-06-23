--
-- Dumping data for table `achievement_definitions`
--

TRUNCATE TABLE `achievement_definitions`;
INSERT INTO `achievement_definitions` (`id`, `order`, `name_key`, `description_key`, `type`, `total_steps`, `revealed_icon_url`, `unlocked_icon_url`, `initial_state`, `experience_points`) VALUES
('c6e6039f-c543-424e-ab5f-b34df1336e81', 1, 'achievement.novice.title', 'achievement.novice.description', 'INCREMENTAL', 10, 'http://content.faforever.com/achievements/c6e6039f-c543-424e-ab5f-b34df1336e81.png', 'http://content.faforever.com/achievements/c6e6039f-c543-424e-ab5f-b34df1336e81.png', 'REVEALED', 5),
('d5c759fe-a1a8-4103-888d-3ba319562867', 2, 'achievement.junior.title', 'achievement.junior.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/d5c759fe-a1a8-4103-888d-3ba319562867.png', 'http://content.faforever.com/achievements/d5c759fe-a1a8-4103-888d-3ba319562867.png', 'REVEALED', 10),
('6a37e2fc-1609-465e-9eca-91eeda4e63c4', 3, 'achievement.senior.title', 'achievement.senior.description', 'INCREMENTAL', 250, 'http://content.faforever.com/achievements/6a37e2fc-1609-465e-9eca-91eeda4e63c4.png', 'http://content.faforever.com/achievements/6a37e2fc-1609-465e-9eca-91eeda4e63c4.png', 'REVEALED', 20),
('bd12277a-6604-466a-9ee6-af6908573585', 4, 'achievement.veteran.title', 'achievement.veteran.description', 'INCREMENTAL', 500, 'http://content.faforever.com/achievements/bd12277a-6604-466a-9ee6-af6908573585.png', 'http://content.faforever.com/achievements/bd12277a-6604-466a-9ee6-af6908573585.png', 'REVEALED', 30),
('805f268c-88aa-4073-aa2b-ea30700f70d6', 4, 'achievement.addict.title', 'achievement.addict.description', 'INCREMENTAL', 1000, 'http://content.faforever.com/achievements/805f268c-88aa-4073-aa2b-ea30700f70d6.png', 'http://content.faforever.com/achievements/805f268c-88aa-4073-aa2b-ea30700f70d6.png', 'REVEALED', 50),
('5b7ec244-58c0-40ca-9d68-746b784f0cad', 5, 'achievement.firstSuccess.title', 'achievement.firstSuccess.description', 'STANDARD', NULL, 'http://content.faforever.com/achievements/5b7ec244-58c0-40ca-9d68-746b784f0cad.png', 'http://content.faforever.com/achievements/5b7ec244-58c0-40ca-9d68-746b784f0cad.png', 'REVEALED', 5),
('08629902-8e18-4d92-ad14-c8ecde4a8674', 12, 'achievement.hattrick.title', 'achievement.hattrick.description', 'STANDARD', NULL, 'http://content.faforever.com/achievements/08629902-8e18-4d92-ad14-c8ecde4a8674.png', 'http://content.faforever.com/achievements/08629902-8e18-4d92-ad14-c8ecde4a8674.png', 'REVEALED', 10),
('290df67c-eb01-4fe7-9e32-caae1c10442f', 13, 'achievement.thatWasClose.title', 'achievement.thatWasClose.description', 'STANDARD', NULL, 'http://content.faforever.com/achievements/290df67c-eb01-4fe7-9e32-caae1c10442f.png', 'http://content.faforever.com/achievements/290df67c-eb01-4fe7-9e32-caae1c10442f.png', 'REVEALED', 5),
('305a8d34-42fd-42f3-ba91-d9f5e437a9a6', 14, 'achievement.topScore.title', 'achievement.topScore.description', 'STANDARD', NULL, 'http://content.faforever.com/achievements/305a8d34-42fd-42f3-ba91-d9f5e437a9a6.png', 'http://content.faforever.com/achievements/305a8d34-42fd-42f3-ba91-d9f5e437a9a6.png', 'REVEALED', 10),
('d3d2c78b-d42d-4b65-99b8-a350f119f898', 15, 'achievement.unbeatable.title', 'achievement.unbeatable.description', 'INCREMENTAL', 10, 'http://content.faforever.com/achievements/d3d2c78b-d42d-4b65-99b8-a350f119f898.png', 'http://content.faforever.com/achievements/d3d2c78b-d42d-4b65-99b8-a350f119f898.png', 'REVEALED', 20),
('02081bb0-3b7a-4a36-99ef-5ae5d92d7146', 16, 'achievement.rusher.title', 'achievement.rusher.description', 'STANDARD', NULL, 'http://content.faforever.com/achievements/02081bb0-3b7a-4a36-99ef-5ae5d92d7146.png', 'http://content.faforever.com/achievements/02081bb0-3b7a-4a36-99ef-5ae5d92d7146.png', 'REVEALED', 10),
('1a3ad9e0-53eb-47d0-9404-14dbcefbed9b', 17, 'achievement.ma12Striker.title', 'achievement.ma12Striker.description', 'INCREMENTAL', 5, 'http://content.faforever.com/achievements/1a3ad9e0-53eb-47d0-9404-14dbcefbed9b.png', 'http://content.faforever.com/achievements/1a3ad9e0-53eb-47d0-9404-14dbcefbed9b.png', 'REVEALED', 5),
('326493d7-ce2c-4a43-bbc8-3e990e2685a1', 18, 'achievement.riptide.title', 'achievement.riptide.description', 'INCREMENTAL', 25, 'http://content.faforever.com/achievements/326493d7-ce2c-4a43-bbc8-3e990e2685a1.png', 'http://content.faforever.com/achievements/326493d7-ce2c-4a43-bbc8-3e990e2685a1.png', 'REVEALED', 10),
('7d6d8c55-3e2a-41d0-a97e-d35513af1ec6', 19, 'achievement.demolisher.title', 'achievement.demolisher.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/7d6d8c55-3e2a-41d0-a97e-d35513af1ec6.png', 'http://content.faforever.com/achievements/7d6d8c55-3e2a-41d0-a97e-d35513af1ec6.png', 'REVEALED', 20),
('d1d50fbb-7fe9-41b0-b667-4433704b8a2c', 20, 'achievement.mantis.title', 'achievement.mantis.description', 'INCREMENTAL', 5, 'http://content.faforever.com/achievements/d1d50fbb-7fe9-41b0-b667-4433704b8a2c.png', 'http://content.faforever.com/achievements/d1d50fbb-7fe9-41b0-b667-4433704b8a2c.png', 'REVEALED', 5),
('af161922-3e52-4600-9161-d850ab0fae86', 21, 'achievement.wagner.title', 'achievement.wagner.description', 'INCREMENTAL', 25, 'http://content.faforever.com/achievements/af161922-3e52-4600-9161-d850ab0fae86.png', 'http://content.faforever.com/achievements/af161922-3e52-4600-9161-d850ab0fae86.png', 'REVEALED', 10),
('ff23024e-f533-4e23-8f8f-ecc21d5283f8', 22, 'achievement.trebuchet.title', 'achievement.trebuchet.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/ff23024e-f533-4e23-8f8f-ecc21d5283f8.png', 'http://content.faforever.com/achievements/ff23024e-f533-4e23-8f8f-ecc21d5283f8.png', 'REVEALED', 20),
('d656ade4-e054-415a-a2e9-5f4105f7d724', 23, 'achievement.aurora.title', 'achievement.aurora.description', 'INCREMENTAL', 5, 'http://content.faforever.com/achievements/d656ade4-e054-415a-a2e9-5f4105f7d724.png', 'http://content.faforever.com/achievements/d656ade4-e054-415a-a2e9-5f4105f7d724.png', 'REVEALED', 5),
('06a39447-66a3-4160-93d5-d48337b0cbb5', 24, 'achievement.blaze.title', 'achievement.blaze.description', 'INCREMENTAL', 25, 'http://content.faforever.com/achievements/06a39447-66a3-4160-93d5-d48337b0cbb5.png', 'http://content.faforever.com/achievements/06a39447-66a3-4160-93d5-d48337b0cbb5.png', 'REVEALED', 25),
('7f993f98-dbec-41a5-9c9a-5f85edf30767', 25, 'achievement.serenity.title', 'achievement.serenity.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/7f993f98-dbec-41a5-9c9a-5f85edf30767.png', 'http://content.faforever.com/achievements/7f993f98-dbec-41a5-9c9a-5f85edf30767.png', 'REVEALED', 50),
('c964ac69-b146-43d0-bd7a-cd22144f9983', 26, 'achievement.thaam.title', 'achievement.thaam.description', 'INCREMENTAL', 5, 'http://content.faforever.com/achievements/c964ac69-b146-43d0-bd7a-cd22144f9983.png', 'http://content.faforever.com/achievements/c964ac69-b146-43d0-bd7a-cd22144f9983.png', 'REVEALED', 5),
('7aa7fc88-48a2-4e49-9cd7-35e2f6ce4cec', 27, 'achievement.yenzyne.title', 'achievement.yenzyne.description', 'INCREMENTAL', 25, 'http://content.faforever.com/achievements/7aa7fc88-48a2-4e49-9cd7-35e2f6ce4cec.png', 'http://content.faforever.com/achievements/7aa7fc88-48a2-4e49-9cd7-35e2f6ce4cec.png', 'REVEALED', 10),
('6acc8bc6-1fd3-4c33-97a1-85dfed6d167a', 28, 'achievement.suthanus.title', 'achievement.suthanus.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/6acc8bc6-1fd3-4c33-97a1-85dfed6d167a.png', 'http://content.faforever.com/achievements/6acc8bc6-1fd3-4c33-97a1-85dfed6d167a.png', 'REVEALED', 20),
('53173f4d-450c-46f0-ac59-85834cc74972', 29, 'achievement.landLubber.title', 'achievement.landLubber.description', 'INCREMENTAL', 5, 'http://content.faforever.com/achievements/53173f4d-450c-46f0-ac59-85834cc74972.png', 'http://content.faforever.com/achievements/53173f4d-450c-46f0-ac59-85834cc74972.png', 'REVEALED', 5),
('2d5cd544-4fc8-47b9-8ebb-e72ed6423d51', 30, 'achievement.seaman.title', 'achievement.seaman.description', 'INCREMENTAL', 25, 'http://content.faforever.com/achievements/2d5cd544-4fc8-47b9-8ebb-e72ed6423d51.png', 'http://content.faforever.com/achievements/2d5cd544-4fc8-47b9-8ebb-e72ed6423d51.png', 'REVEALED', 10),
('bd77964b-c06b-4649-bf7c-d35cb7715854', 31, 'achievement.admiralOfTheFleet.title', 'achievement.admiralOfTheFleet.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/bd77964b-c06b-4649-bf7c-d35cb7715854.png', 'http://content.faforever.com/achievements/bd77964b-c06b-4649-bf7c-d35cb7715854.png', 'REVEALED', 20),
('c1ccde26-8449-4625-b769-7d8f75fa8df3', 32, 'achievement.wrightBrother.title', 'achievement.wrightBrother.description', 'INCREMENTAL', 5, 'http://content.faforever.com/achievements/c1ccde26-8449-4625-b769-7d8f75fa8df3.png', 'http://content.faforever.com/achievements/c1ccde26-8449-4625-b769-7d8f75fa8df3.png', 'REVEALED', 5),
('a4ade3d4-d541-473f-9788-e92339446d75', 33, 'achievement.wingman.title', 'achievement.wingman.description', 'INCREMENTAL', 25, 'http://content.faforever.com/achievements/a4ade3d4-d541-473f-9788-e92339446d75.png', 'http://content.faforever.com/achievements/a4ade3d4-d541-473f-9788-e92339446d75.png', 'REVEALED', 10),
('e220d5e6-481c-4347-ac69-b6b6f956bc0f', 34, 'achievement.kingOfTheSkies.title', 'achievement.kingOfTheSkies.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/e220d5e6-481c-4347-ac69-b6b6f956bc0f.png', 'http://content.faforever.com/achievements/e220d5e6-481c-4347-ac69-b6b6f956bc0f.png', 'REVEALED', 20),
('e5c63aec-20a0-4263-841d-b7bc45209713', 35, 'achievement.militiaman.title', 'achievement.militiaman.description', 'INCREMENTAL', 5, 'http://content.faforever.com/achievements/e5c63aec-20a0-4263-841d-b7bc45209713.png', 'http://content.faforever.com/achievements/e5c63aec-20a0-4263-841d-b7bc45209713.png', 'REVEALED', 5),
('ec8faec7-e3e1-436e-a1ac-9f7adc3d0387', 36, 'achievement.grenadier.title', 'achievement.grenadier.description', 'INCREMENTAL', 25, 'http://content.faforever.com/achievements/ec8faec7-e3e1-436e-a1ac-9f7adc3d0387.png', 'http://content.faforever.com/achievements/ec8faec7-e3e1-436e-a1ac-9f7adc3d0387.png', 'REVEALED', 10),
('10f17c75-1154-447d-a4f7-6217add0407e', 37, 'achievement.fieldMarshal.title', 'achievement.fieldMarshal.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/10f17c75-1154-447d-a4f7-6217add0407e.png', 'http://content.faforever.com/achievements/10f17c75-1154-447d-a4f7-6217add0407e.png', 'REVEALED', 20),
('06b19364-5aab-4bce-883d-975f663d2091', 38, 'achievement.techie.title', 'achievement.techie.description', 'INCREMENTAL', 5, 'http://content.faforever.com/achievements/06b19364-5aab-4bce-883d-975f663d2091.png', 'http://content.faforever.com/achievements/06b19364-5aab-4bce-883d-975f663d2091.png', 'REVEALED', 5),
('cd64c5e7-b063-4543-9f52-0e87883b33a9', 39, 'achievement.iLoveBigToys.title', 'achievement.iLoveBigToys.description', 'INCREMENTAL', 25, 'http://content.faforever.com/achievements/cd64c5e7-b063-4543-9f52-0e87883b33a9.png', 'http://content.faforever.com/achievements/cd64c5e7-b063-4543-9f52-0e87883b33a9.png', 'REVEALED', 10),
('e8af7cc9-aaa6-4d0e-8e5a-481702a83a4e', 40, 'achievement.experimentalist.title', 'achievement.experimentalist.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/e8af7cc9-aaa6-4d0e-8e5a-481702a83a4e.png', 'http://content.faforever.com/achievements/e8af7cc9-aaa6-4d0e-8e5a-481702a83a4e.png', 'REVEALED', 20),
('045342e1-ae0d-4ef6-98bc-0bb54ffe00b3', 41, 'achievement.whatASwarm.title', 'achievement.whatASwarm.description', 'INCREMENTAL', 500, 'http://content.faforever.com/achievements/045342e1-ae0d-4ef6-98bc-0bb54ffe00b3.png', 'http://content.faforever.com/achievements/045342e1-ae0d-4ef6-98bc-0bb54ffe00b3.png', 'REVEALED', 10),
('d38aec23-e487-4aa2-899e-418e29ffbd36', 42, 'achievement.theTransporter.title', 'achievement.theTransporter.description', 'INCREMENTAL', 500, 'http://content.faforever.com/achievements/d38aec23-e487-4aa2-899e-418e29ffbd36.png', 'http://content.faforever.com/achievements/d38aec23-e487-4aa2-899e-418e29ffbd36.png', 'REVEALED', 10),
('eb1ee9ab-4828-417b-b3e8-c8281ee7a353', 43, 'achievement.whoNeedsSupport.title', 'achievement.whoNeedsSupport.description', 'INCREMENTAL', 10, 'http://content.faforever.com/achievements/eb1ee9ab-4828-417b-b3e8-c8281ee7a353.png', 'http://content.faforever.com/achievements/eb1ee9ab-4828-417b-b3e8-c8281ee7a353.png', 'REVEALED', 10),
('e7645e7c-7456-48a8-a562-d97521498e7e', 44, 'achievement.deadlyBugs.title', 'achievement.deadlyBugs.description', 'INCREMENTAL', 500, 'http://content.faforever.com/achievements/e7645e7c-7456-48a8-a562-d97521498e7e.png', 'http://content.faforever.com/achievements/e7645e7c-7456-48a8-a562-d97521498e7e.png', 'REVEALED', 10),
('f0cde5d8-4933-4074-a2fb-819074d21abd', 45, 'achievement.noMercy.title', 'achievement.noMercy.description', 'INCREMENTAL', 500, 'http://content.faforever.com/achievements/f0cde5d8-4933-4074-a2fb-819074d21abd.png', 'http://content.faforever.com/achievements/f0cde5d8-4933-4074-a2fb-819074d21abd.png', 'REVEALED', 10),
('a98fcfaf-29ac-4526-84c2-44f284518f8c', 46, 'achievement.flyingDeath.title', 'achievement.flyingDeath.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/a98fcfaf-29ac-4526-84c2-44f284518f8c.png', 'http://content.faforever.com/achievements/a98fcfaf-29ac-4526-84c2-44f284518f8c.png', 'REVEALED', 10),
('1c8fcb6f-a5b6-497f-8b0d-ac5ac6fef408', 47, 'achievement.incomingRobots.title', 'achievement.incomingRobots.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/1c8fcb6f-a5b6-497f-8b0d-ac5ac6fef408.png', 'http://content.faforever.com/achievements/1c8fcb6f-a5b6-497f-8b0d-ac5ac6fef408.png', 'REVEALED', 10),
('a1f87fb7-67ca-4a86-afc6-f23a41b40e9f', 48, 'achievement.arachnologist.title', 'achievement.arachnologist.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/a1f87fb7-67ca-4a86-afc6-f23a41b40e9f.png', 'http://content.faforever.com/achievements/a1f87fb7-67ca-4a86-afc6-f23a41b40e9f.png', 'REVEALED', 10),
('db141e87-5818-435f-80a3-08cc6f1fdac6', 49, 'achievement.holyCrab.title', 'achievement.holyCrab.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/db141e87-5818-435f-80a3-08cc6f1fdac6.png', 'http://content.faforever.com/achievements/db141e87-5818-435f-80a3-08cc6f1fdac6.png', 'REVEALED', 10),
('ab241de5-e773-412e-b073-090da8e38c4c', 50, 'achievement.fatterIsBetter.title', 'achievement.fatterIsBetter.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/ab241de5-e773-412e-b073-090da8e38c4c.png', 'http://content.faforever.com/achievements/ab241de5-e773-412e-b073-090da8e38c4c.png', 'REVEALED', 10),
('1f140add-b0ae-4e02-91a0-45d62b988a22', 51, 'achievement.alienInvasion.title', 'achievement.alienInvasion.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/1f140add-b0ae-4e02-91a0-45d62b988a22.png', 'http://content.faforever.com/achievements/1f140add-b0ae-4e02-91a0-45d62b988a22.png', 'REVEALED', 10),
('60d1e60d-036b-491e-a992-2b18321848c2', 52, 'achievement.assWasher.title', 'achievement.assWasher.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/60d1e60d-036b-491e-a992-2b18321848c2.png', 'http://content.faforever.com/achievements/60d1e60d-036b-491e-a992-2b18321848c2.png', 'REVEALED', 10),
('539da20b-5026-4c49-8e22-e4a305d58845', 53, 'achievement.deathFromAbove.title', 'achievement.deathFromAbove.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/539da20b-5026-4c49-8e22-e4a305d58845.png', 'http://content.faforever.com/achievements/539da20b-5026-4c49-8e22-e4a305d58845.png', 'REVEALED', 10),
('e603f306-ba6b-4507-9556-37a308e5a722', 54, 'achievement.stormySea.title', 'achievement.stormySea.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/e603f306-ba6b-4507-9556-37a308e5a722.png', 'http://content.faforever.com/achievements/e603f306-ba6b-4507-9556-37a308e5a722.png', 'REVEALED', 10),
('a909629f-46f5-469e-afd1-192d42f55e4d', 55, 'achievement.itAintACity.title', 'achievement.itAintACity.description', 'INCREMENTAL', 50, 'http://content.faforever.com/achievements/a909629f-46f5-469e-afd1-192d42f55e4d.png', 'http://content.faforever.com/achievements/a909629f-46f5-469e-afd1-192d42f55e4d.png', 'REVEALED', 10),
('50260d04-90ff-45c8-816b-4ad8d7b97ecd', 56, 'achievement.rainmaker.title', 'achievement.rainmaker.description', 'STANDARD', NULL, 'http://content.faforever.com/achievements/50260d04-90ff-45c8-816b-4ad8d7b97ecd.png', 'http://content.faforever.com/achievements/50260d04-90ff-45c8-816b-4ad8d7b97ecd.png', 'REVEALED', 10),
('31a728f8-ace9-45fa-a3f2-57084bc9e461', 57, 'achievement.iHaveACannon.title', 'achievement.iHaveACannon.description', 'STANDARD', NULL, 'http://content.faforever.com/achievements/31a728f8-ace9-45fa-a3f2-57084bc9e461.png', 'http://content.faforever.com/achievements/31a728f8-ace9-45fa-a3f2-57084bc9e461.png', 'REVEALED', 10),
('987ca192-26e1-4b96-b593-40c115451cc0', 58, 'achievement.makeItHail.title', 'achievement.makeItHail.description', 'STANDARD', NULL, 'http://content.faforever.com/achievements/987ca192-26e1-4b96-b593-40c115451cc0.png', 'http://content.faforever.com/achievements/987ca192-26e1-4b96-b593-40c115451cc0.png', 'REVEALED', 10),
('46a6e900-88bb-4eae-92d1-4f31b53faedc', 59, 'achievement.soMuchResources.title', 'achievement.soMuchResources.description', 'STANDARD', NULL, 'http://content.faforever.com/achievements/46a6e900-88bb-4eae-92d1-4f31b53faedc.png', 'http://content.faforever.com/achievements/46a6e900-88bb-4eae-92d1-4f31b53faedc.png', 'REVEALED', 10),
('9ad697bb-441e-45a5-b682-b9227e8eef3e', 60, 'achievement.nuclearWar.title', 'achievement.nuclearWar.description', 'STANDARD', NULL, 'http://content.faforever.com/achievements/9ad697bb-441e-45a5-b682-b9227e8eef3e.png', 'http://content.faforever.com/achievements/9ad697bb-441e-45a5-b682-b9227e8eef3e.png', 'REVEALED', 10),
('a6b7dfa1-1ebc-4c6d-9305-4a9d623e1b4f', 61, 'achievement.drEvil.title', 'achievement.drEvil.description', 'INCREMENTAL', 500, 'http://content.faforever.com/achievements/a6b7dfa1-1ebc-4c6d-9305-4a9d623e1b4f.png', 'http://content.faforever.com/achievements/a6b7dfa1-1ebc-4c6d-9305-4a9d623e1b4f.png', 'REVEALED', 10),
('2103e0de-1c87-4fba-bc1b-0bba66669607', 62, 'achievement.dontMessWitHme.title', 'achievement.dontMessWitHme.description', 'INCREMENTAL', 100, 'http://content.faforever.com/achievements/2103e0de-1c87-4fba-bc1b-0bba66669607.png', 'http://content.faforever.com/achievements/2103e0de-1c87-4fba-bc1b-0bba66669607.png', 'REVEALED', 10);




--
-- Dumping data for table `event_definitions`
--

TRUNCATE TABLE `event_definitions`;
INSERT INTO `event_definitions` (`id`, `name_key`, `image_url`, `type`) VALUES
('cfa449a6-655b-48d5-9a27-6044804fe35c', 'event.customGamesPlayed', NULL, 'NUMERIC'),
('4a929def-e347-45b4-b26d-4325a3115859', 'event.ranked1v1GamesPlayed', NULL, 'NUMERIC'),
('d6a699b7-99bc-4a7f-b128-15e1e289a7b3', 'event.lostAcus', NULL, 'NUMERIC'),
('3ebb0c4d-5e92-4446-bf52-d17ba9c5cd3c', 'event.builtAirUnits',  NULL, 'NUMERIC'),
('225e9b2e-ae09-4ae1-a198-eca8780b0fcd', 'event.lostAirUnits', NULL, 'NUMERIC'),
('ea123d7f-bb2e-4a71-bd31-88859f0c3c00', 'event.builtLandUnits', NULL, 'NUMERIC'),
('a1a3fd33-abe2-4e56-800a-b72f4c925825', 'event.lostLandUnits',  NULL, 'NUMERIC'),
('b5265b42-1747-4ba1-936c-292202637ce6', 'event.builtNavalUnits', NULL, 'NUMERIC'),
('3a7b3667-0f79-4ac7-be63-ba841fd5ef05', 'event.lostNavalUnits', NULL, 'NUMERIC'),
('cc791f00-343c-48d4-b5b3-8900b83209c0', 'event.secondsPlayed', NULL, 'TIME'),
('a8ee4f40-1e30-447b-bc2c-b03065219795', 'event.builtTech1Units', NULL, 'NUMERIC'),
('3dd3ed78-ce78-4006-81fd-10926738fbf3', 'event.lostTech1Units', NULL, 'NUMERIC'),
('89d4f391-ed2d-4beb-a1ca-6b93db623c04', 'event.builtTech2Units', NULL, 'NUMERIC'),
('aebd750b-770b-4869-8e37-4d4cfdc480d0', 'event.lostTech2Units', NULL, 'NUMERIC'),
('92617974-8c1f-494d-ab86-65c2a95d1486', 'event.builtTech3Units', NULL, 'NUMERIC'),
('7f15c2be-80b7-4573-8f41-135f84773e0f', 'event.lostTech3Units',  NULL, 'NUMERIC'),
('ed9fd79d-5ec7-4243-9ccf-f18c4f5baef1', 'event.builtExperimentals', NULL, 'NUMERIC'),
('701ca426-0943-4931-85af-6a08d36d9aaa', 'event.lostExperimentals', NULL, 'NUMERIC'),
('60bb1fc0-601b-45cd-bd26-83b1a1ac979b', 'event.builtEngineers', NULL, 'NUMERIC'),
('e8e99a68-de1b-4676-860d-056ad2207119', 'event.lostEngineers', NULL, 'NUMERIC'),
('96ccc66a-c5a0-4f48-acaa-888b00778b57', 'event.aeonPlays', NULL, 'NUMERIC'),
('a6b51c26-64e6-4e7a-bda7-ea1cfe771ebb', 'event.aeonWins', NULL, 'NUMERIC'),
('ad193982-e7ca-465c-80b0-5493f9739559', 'event.cybranPlays', NULL, 'NUMERIC'),
('56b06197-1890-42d0-8b59-25e1add8dc9a', 'event.cybranWins', NULL, 'NUMERIC'),
('1b900d26-90d2-43d0-a64e-ed90b74c3704', 'event.uefPlays',  NULL, 'NUMERIC'),
('7be6fdc5-7867-4467-98ce-f7244a66625a', 'event.uefWins', NULL, 'NUMERIC'),
('fefcb392-848f-4836-9683-300b283bc308', 'event.seraphimPlays', NULL, 'NUMERIC'),
('15b6c19a-6084-4e82-ada9-6c30e282191f', 'event.seraphimWins', NULL, 'NUMERIC');


--
-- Dumping data for table `messages`
--

TRUNCATE TABLE `messages`;
INSERT INTO `messages` (`key`, `language`, `region`, `value`) VALUES
('achievement.rusher.title', 'en', 'US', 'Rusher'),
('achievement.rusher.description', 'en', 'US', 'Kill your enemy in a ranked 1v1 game in under 15 minutes'),
('achievement.whatASwarm.title', 'en', 'US', 'What a swarm'),
('achievement.whatASwarm.description', 'en', 'US', 'Build 500 Air Superiority Fighter in a single game'),
('achievement.blaze.title', 'en', 'US', 'Blaze'),
('achievement.blaze.description', 'en', 'US', 'Win 25 games with Aeon'),
('achievement.techie.title', 'en', 'US', 'Techie'),
('achievement.techie.description', 'en', 'US', 'Win 5 games with high usage of experimentals (3 or more)'),
('achievement.hattrick.title', 'en', 'US', 'Hattrick'),
('achievement.hattrick.description', 'en', 'US', 'Kill 3 enemies in one game and survive'),
('achievement.fieldMarshal.title', 'en', 'US', 'Field marshal'),
('achievement.fieldMarshal.description', 'en', 'US', 'Win 50 games with land dominant army'),
('achievement.ma12Striker.title', 'en', 'US', 'MA12 Striker'),
('achievement.ma12Striker.description', 'en', 'US', 'Win 5 games with UEF'),
('achievement.incomingRobots.title', 'en', 'US', 'Incoming robots'),
('achievement.incomingRobots.description', 'en', 'US', 'Build 50 Galactic Colossus in total'),
('achievement.alienInvasion.title', 'en', 'US', 'Alien invasion'),
('achievement.alienInvasion.description', 'en', 'US', 'Build 50 Ythothas in total'),
('achievement.dontMessWitHme.title', 'en', 'US', 'Don''t mess with me'),
('achievement.dontMessWitHme.description', 'en', 'US', 'Kill 100 ACUs in total'),
('achievement.thatWasClose.title', 'en', 'US', 'That was close'),
('achievement.thatWasClose.description', 'en', 'US', 'Survive despite your ACU\'s health got below 500hp'),
('achievement.seaman.title', 'en', 'US', 'Seaman'),
('achievement.seaman.description', 'en', 'US', 'Win 25 games with navy dominant army'),
('achievement.topScore.title', 'en', 'US', 'Top score'),
('achievement.topScore.description', 'en', 'US', 'Be the top scoring player in a game with at least 8 players.'),
('achievement.iHaveACannon.title', 'en', 'US', 'I have a cannon'),
('achievement.iHaveACannon.description', 'en', 'US', 'Win a game building a Mavor'),
('achievement.Riptide.title', 'en', 'US', 'Riptide'),
('achievement.Riptide.description', 'en', 'US', 'Win 25 games with UEF'),
('achievement.soMuchResources.title', 'en', 'US', 'So much resources'),
('achievement.soMuchResources.description', 'en', 'US', 'Win a game building a Paragon'),
('achievement.rainmaker.title', 'en', 'US', 'Rainmaker'),
('achievement.rainmaker.description', 'en', 'US',  'Win a game building a Salvation'),
('achievement.landLubber.title', 'en', 'US', 'Landlubber'),
('achievement.landLubber.description', 'en', 'US', 'Win 5 games with navy dominant army'),
('achievement.deathFromAbove.title', 'en', 'US', 'Death from above'),
('achievement.deathFromAbove.description', 'en', 'US', 'Build 50 CZARs in total'),
('achievement.firstSuccess.title', 'en', 'US', 'First success'),
('achievement.firstSuccess.description', 'en', 'US', 'Win a 1v1 ranked game'),
('achievement.assWasher.title', 'en', 'US', 'Ass washer'),
('achievement.assWasher.description', 'en', 'US', 'Build 50 Ahwassas in total'),
('achievement.senior.title', 'en', 'US', 'Senior'),
('achievement.senior.description', 'en', 'US', 'Play 250 games'),
('achievement.suthanus.title', 'en', 'US', 'Suthanus'),
('achievement.suthanus.description', 'en', 'US', 'Win 50 games with Seraphim'),
('achievement.yenzyne.title', 'en', 'US', 'Yenzyne'),
('achievement.yenzyne.description', 'en', 'US', 'Win 25 games with Seraphim'),
('achievement.demolisher.title', 'en', 'US', 'Demolisher'),
('achievement.demolisher.description', 'en', 'US', 'Win 50 games with UEF'),
('achievement.serenity.title', 'en', 'US', 'Serenity'),
('achievement.serenity.description', 'en', 'US', 'Win 50 games with Aeon'),
('achievement.makeItHail.title', 'en', 'US', 'Make it hail'),
('achievement.makeItHail.description', 'en', 'US', 'Win a game building a Scathis'),
('achievement.nuclearWar.title', 'en', 'US', 'Nuclear war'),
('achievement.nuclearWar.description', 'en', 'US', 'Win a game building a Yolona Oss'),
('achievement.arachnologist.title', 'en', 'US', 'Arachnologist'),
('achievement.arachnologist.description', 'en', 'US', 'Build 50 Monkeylords in total'),
('achievement.wingman.title', 'en', 'US', 'Wingman'),
('achievement.wingman.description', 'en', 'US', 'Win 25 games with air dominant army'),
('achievement.drEvil.title', 'en', 'US', 'Dr. Evil'),
('achievement.drEvil.description', 'en', 'US', 'Build 500 experimentals in total'),
('achievement.itAintACity.title', 'en', 'US', 'It ain''t a city'),
('achievement.itAintACity.description', 'en', 'US', 'Build 50 Atlantis in total'),
('achievement.flyingDeath.title', 'en', 'US', 'Flying death'),
('achievement.flyingDeath.description', 'en', 'US', 'Build 50 soul rippers in total'),
('achievement.fatterIsBetter.title', 'en', 'US', 'Fatter is better'),
('achievement.fatterIsBetter.description', 'en', 'US', 'Build 50 Fatboys in total'),
('achievement.wagner.title', 'en', 'US', 'Wagner'),
('achievement.wagner.description', 'en', 'US', 'Win 25 games with Cybran'),
('achievement.veteran.title', 'en', 'US', 'Veteran'),
('achievement.veteran.description', 'en', 'US', 'Play 500 games'),
('achievement.addict.title', 'en', 'US', 'Addict'),
('achievement.addict.description', 'en', 'US', 'Play 1000 games'),
('achievement.admiralOfTheFleet.title', 'en', 'US', 'Admiral of the fleet'),
('achievement.admiralOfTheFleet.description', 'en', 'US', 'Win 50 games with navy dominant army'),
('achievement.wrightBrother.title', 'en', 'US', 'Wright brother'),
('achievement.wrightBrother.description', 'en', 'US', 'Win 5 games with air dominant army'),
('achievement.novice.title', 'en', 'US', 'Novice'),
('achievement.novice.description', 'en', 'US', 'Play 10 games'),
('achievement.thaam.title', 'en', 'US', 'Thaam'),
('achievement.thaam.description', 'en', 'US', 'Win 5 games with Seraphim'),
('achievement.iLoveBigToys.title', 'en', 'US', 'I love big toys'),
('achievement.iLoveBigToys.description', 'en', 'US', 'Win 25 games with high usage of experimentals (3 or more)'),
('achievement.mantis.title', 'en', 'US', 'Mantis'),
('achievement.mantis.description', 'en', 'US', 'Win 5 games with Cybran'),
('achievement.theTransporter.title', 'en', 'US', 'The transporter'),
('achievement.theTransporter.description', 'en', 'US', 'Build 500 transporters in total'),
('achievement.unbeatable.title', 'en', 'US', 'Unbeatable'),
('achievement.unbeatable.description', 'en', 'US', 'Be the top scoring player 10 times in games with at least 8 players.'),
('achievement.junior.title', 'en', 'US', 'Junior'),
('achievement.junior.description', 'en', 'US', 'Play 50 games'),
('achievement.aurora.title', 'en', 'US', 'Aurora'),
('achievement.aurora.description', 'en', 'US', 'Win 5 games with Aeon'),
('achievement.holyCrab.title', 'en', 'US', 'Holy crab'),
('achievement.holyCrab.description', 'en', 'US', 'Build 50 Megaliths in total'),
('achievement.kingOfTheSkies.title', 'en', 'US', 'King of the skies'),
('achievement.kingOfTheSkies.description', 'en', 'US', 'Win 50 games with air dominant army'),
('achievement.militiaman.title', 'en', 'US', 'Militiaman'),
('achievement.militiaman.description', 'en', 'US', 'Win 5 games with land dominant army'),
('achievement.stormySea.title', 'en', 'US', 'Stormy sea'),
('achievement.stormySea.description', 'en', 'US', 'Build 50 Tempests in total'),
('achievement.deadlyBugs.title', 'en', 'US', 'Deadly bugs'),
('achievement.deadlyBugs.description', 'en', 'US', 'Build 500 fire beetles in total'),
('achievement.experimentalist.title', 'en', 'US', 'Experimentalist'),
('achievement.experimentalist.description', 'en', 'US', 'Win 50 games with high usage of experimentals (3 or more)'),
('achievement.whoNeedsSupport.title', 'en', 'US', 'Who needs support?'),
('achievement.whoNeedsSupport.description', 'en', 'US', 'Build 10 Support Command Units in a single game'),
('achievement.grenadier.title', 'en', 'US', 'Grenadier'),
('achievement.grenadier.description', 'en', 'US', 'Win 25 games with land dominant army'),
('achievement.noMercy.title', 'en', 'US', 'No mercy'),
('achievement.noMercy.description', 'en', 'US', 'Build 500 Mercies in total'),
('achievement.trebuchet.title', 'en', 'US', 'Trebuchet'),
('achievement.trebuchet.description', 'en', 'US', 'Win 50 games with Cybran'),
('event.seraphimWins', 'en', 'US', 'Seraphim wins'),
('event.uefPlays', 'en', 'US', 'UEF plays'),
('event.lostAirUnits', 'en', 'US', 'Lost air units'),
('event.lostNavalUnits', 'en', 'US', 'Lost naval units'),
('event.lostTech1Units', 'en', 'US', 'Lost tech 1 units'),
('event.builtAirUnits', 'en', 'US', 'Built air units'),
('event.ranked1v1GamesPlayed', 'en', 'US', 'Ranked 1v1 games played'),
('event.cybranWins', 'en', 'US', 'Cybran wins'),
('event.builtEngineers', 'en', 'US', 'Built engineers'),
('event.lostExperimentals', 'en', 'US', 'Lost experimentals'),
('event.uefWins', 'en', 'US', 'UEF wins'),
('event.lostTech3Units', 'en', 'US', 'Lost tech 3 units'),
('event.builtTech2Units', 'en', 'US', 'Built tech 2 units'),
('event.builtTech3Units', 'en', 'US', 'Built tech 3 units'),
('event.aeonPlays', 'en', 'US', 'Aeon plays'),
('event.lostLandUnits', 'en', 'US', 'Lost land units'),
('event.aeonWins', 'en', 'US', 'Aeon wins'),
('event.builtTech1Units', 'en', 'US', 'Built tech 1 units'),
('event.cybranPlays', 'en', 'US', 'Cybran plays'),
('event.lostTech2Units', 'en', 'US', 'Lost tech 2 units'),
('event.builtNavalUnits', 'en', 'US', 'Built naval units'),
('event.secondsPlayed', 'en', 'US', 'Seconds played'),
('event.customGamesPlayed', 'en', 'US', 'Custom games played'),
('event.lostAcus', 'en', 'US', 'Lost ACUs'),
('event.lostEngineers', 'en', 'US', 'Lost engineers'),
('event.builtLandUnits', 'en', 'US', 'Built land units'),
('event.builtExperimentals', 'en', 'US', 'Built experimentals'),
('event.seraphimPlays', 'en', 'US', 'Seraphim plays');


--
-- Dumping data for table `messages`
--

TRUNCATE TABLE `oauth_clients`;
INSERT INTO `oauth_clients` (`id`, `name`, `client_secret`, `client_type`, `redirect_uris`, `default_redirect_uri`, `default_scope`, `icon_url`) VALUES
('3bc8282c-7730-11e5-8bcf-feff819cdc9f', 'Downlord\'s FAF Client', '6035bd78-7730-11e5-8bcf-feff819cdc9f', 'public', 'http://localhost', 'http://localhost', 'read_events read_achievements', '');

-- Login table
delete from login;
insert into login (id, login, email, password) values (1, 'test', 'test@example.com', SHA2('test_password', 256));
insert into login (id, login, email, password) values (2, 'Dostya', 'dostya@cybran.example.com', SHA2('vodka', 256));
insert into login (id, login, email, password) values (3, 'Rhiza', 'rhiza@aeon.example.com', SHA2('puff_the_magic_dragon', 256));

-- global rating
delete from global_rating;
insert into global_rating (id, mean, deviation, numGames, is_active)
values
(1, 2000, 125, 5, 1),
(2, 1500, 75, 2, 1),
(3, 1650, 62.52, 2, 1);

-- ladder rating
delete from ladder1v1_rating;
insert into ladder1v1_rating (id, mean, deviation, numGames, is_active)
values
  (1, 2000, 125, 5, 1),
  (2, 1500, 75, 2, 1),
  (3, 1650, 62.52, 2, 1);

-- UniqueID_exempt
delete from uniqueid_exempt;
insert into uniqueid_exempt (user_id, reason) values (1, 'Because test');

-- Lobby version table
delete from version_lobby;
insert into version_lobby (id, `file`, version) values (1, 'some-installer.msi', '0.10.125');

-- Sample maps
delete from table_map;
insert into table_map (id, filename, `mapuid`)
values
(1, 'scmp_001/scmp_001.scenario_info.lua', 1),
(2, 'scmp_002/scmp_002.scenario_info.lua', 2),
(3, 'scmp_003/scmp_003.scenario_info.lua', 3),
(4, 'scmp_004/scmp_004.scenario_info.lua', 4),
(5, 'scmp_005/scmp_005.scenario_info.lua', 5),
(6, 'scmp_006/scmp_006.scenario_info.lua', 6),
(7, 'scmp_007/scmp_007.scenario_info.lua', 7),
(8, 'scmp_008/scmp_008.scenario_info.lua', 8),
(9, 'scmp_009/scmp_009.scenario_info.lua', 9),
(10, 'scmp_010/scmp_010.scenario_info.lua', 11),
(11, 'scmp_011/scmp_011.scenario_info.lua', 12),
(12, 'scmp_012/scmp_012.scenario_info.lua', 13),
(13, 'scmp_013/scmp_014.scenario_info.lua', 14),
(14, 'scmp_014/scmp_014.scenario_info.lua', 15),
(15, 'scmp_015/scmp_015.scenario_info.lua', 16);

-- game_stats table
delete from game_stats;
insert into game_stats (id, startTime, gameName, gameType, gameMod, `host`, mapId, validity)
values (1, NOW(), 'Test game', '0', 6, 1, 1, 0);

-- featured mods
delete from game_featuredMods;
insert into game_featuredMods (id, gamemod, name, description, publish)
values (1, 'faf', 'FAF', 'Forged Alliance Forever', 1),
       (6, 'ladder1v1', 'FAF', 'Ladder games', 1),
       (25, 'coop', 'Coop', 'Multiplayer campaign games', 1);

delete from friends_and_foes;
insert into friends_and_foes (user_id, subject_id, `status`)
values(42, 56, "FRIEND"),
      (42, 57, "FOE");

-- sample mods
delete from table_mod;
insert into table_mod (uid, `name`,
                       version, author, ui, description, filename, icon, likers, played)
VALUES ('foo', 'test-mod', 1, 'baz', 0, NOW(), 'foobar.zip', 'foobar.png', '', 0),
       ('bar', 'test-mod2', 1, 'baz', 0, NOW(), 'foobar2.zip', 'foobar2.png', '', 0),
       ('EA040F8E-857A-4566-9879-0D37420A5B9D', 'test-mod3', 1, 'baz', 0, NOW(), 'foobar3.zip', 'foobar3.png', '', 1);
