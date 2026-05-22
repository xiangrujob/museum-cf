-- Update wing images to use Wikimedia commons direct stable URLs
-- These use the non-thumb direct file path which is more stable

UPDATE wings SET img = 'https://upload.wikimedia.org/wikipedia/commons/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg'
WHERE id = 'jvm';

UPDATE wings SET img = 'https://upload.wikimedia.org/wikipedia/commons/4/4a/The_Fighting_Temeraire%2C_JMW_Turner%2C_National_Gallery.jpg'
WHERE id = 'conc';

UPDATE wings SET img = 'https://upload.wikimedia.org/wikipedia/commons/3/36/The_Swing-Fragonard.jpg'
WHERE id = 'coll';

UPDATE wings SET img = 'https://upload.wikimedia.org/wikipedia/commons/3/3b/Jacques-Louis_David_-_The_Death_of_Socrates_-_Metropolitan_Museum_of_Art.jpg'
WHERE id = 'mysql';

UPDATE wings SET img = 'https://upload.wikimedia.org/wikipedia/commons/b/b9/Caspar_David_Friedrich_-_Wanderer_above_the_sea_of_fog.jpg'
WHERE id = 'redis';

UPDATE wings SET img = 'https://upload.wikimedia.org/wikipedia/commons/8/8e/Gustave_Courbet_-_Bonjour_Monsieur_Courbet_-_Google_Art_Project.jpg'
WHERE id = 'spring';

UPDATE wings SET img = 'https://upload.wikimedia.org/wikipedia/commons/a/a4/Claude_Monet_-_Water_Lilies_-_1906%2C_Ryerson.jpg'
WHERE id = 'sys';

UPDATE wings SET img = 'https://upload.wikimedia.org/wikipedia/commons/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg'
WHERE id = 'net';

UPDATE wings SET img = 'https://upload.wikimedia.org/wikipedia/commons/a/a4/Piet_Mondrian%2C_1930_-_Mondrian_Composition_II_in_Red%2C_Blue%2C_and_Yellow.jpg'
WHERE id = 'algo';

UPDATE wings SET img = 'https://upload.wikimedia.org/wikipedia/commons/b/b4/Vincent_Willem_van_Gogh_128.jpg'
WHERE id = 'proj';
