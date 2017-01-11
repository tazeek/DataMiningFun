# Read in dataset
mushroom_set <- read.csv('mushrooms.csv')

# Normalize the class for mushroom
normalize_class <- c(edible='e',poisonous='p')
mushroom_set$class <- factor(mushroom_set$class,normalize_class,names(normalize_class))

# Normalize the cap shapes 
normalize_cap_shape <- c(bell='b',conical='c',convex='x',flat='f',knobbed='k',sunken='s')
mushroom_set$cap.shape <- factor(mushroom_set$cap.shape,normalize_cap_shape,
	names(normalize_cap_shape))

# Normalize surface
normalize_cap_surface <- c(fibrous='f',grooves='g',scaly='y',smooth='s')
mushroom_set$cap.surface <- factor(mushroom_set$cap.surface,normalize_cap_surface,
	names(normalize_cap_surface))

# Normalize cap color
normalize_cap_color <- c(brown='n',buff='b',cinnamon='c',gray='g',green='r',pink='p',
	purple='u',red='e',white='w',yellow='y')

mushroom_set$cap.color <- factor(mushroom_set$cap.color,normalize_cap_color,
	names(normalize_cap_color))

# Normalize bruises
normalize_bruises <- c(yes='t',no='f')
mushroom_set$bruises <- factor(mushroom_set$bruises,normalize_bruises,
	names(normalize_bruises))

# Normalize odor
normalize_odor <- c(almond='a',anise='l',creosote='c',fishy='y',foul='f',musty='m',
	none='n',pungen='p',spicy='s')

mushroom_set$odor <- factor(mushroom_set$odor,normalize_odor,names(normalize_odor))

# Normalize habitat
normalize_habitat <- c(grasses='g',leaves='l',meadows='m',paths='p',urban='u',
	waste='w',woods='d')

mushroom_set$habitat <- factor(mushroom_set$habitat,normalize_habitat,
	names(normalize_habitat))

# Normalize population
normalize_population <- c(abundant='a',clustered='c',numerous='n',scattered='s',
	several='v',solitary='y')

mushroom_set$population <- factor(mushroom_set$population,normalize_population,
	names(normalize_population))

# Normalize spore color
normalize_spore_color <- c(black='k',brown='n',buff='b',chocolate='h',
	green='r',orange='o',purple='u',white='w',yellow='y')

mushroom_set$spore.print.color <- factor(mushroom_set$spore.print.color, 
	normalize_spore_color, names(normalize_spore_color))

# Normalize ring type
normalizeMushroomRingType <- c(cobwebby='c',evanescent='e',flaring='f',large='l',
	none='n',pendant='p',sheathing='s',zone='z')

mushroom_set$ring.type <- factor(mushroom_set$ring.type, normalizeMushroomRingType, 
	names(normalizeMushroomRingType))

# Normalize ring number
normalize_ring_number <- c(none='n',one='o',two='t')
mushroom_set$ring.number <- factor(mushroom_set$ring.number, normalize_ring_number, 
	names(normalize_ring_number))

# Normalize veil color
normalize_veil_color <- c(brown='n',orange='o',white='w',yellow='y')

mushroom_set$veil.color <- factor(mushroom_set$veil.color, normalize_veil_color, 
	names(normalize_veil_color))

# Normalize gill attachment
normalize_gill_attach <- c(attached='a',descending='d',free='f',notched='n')

mushroom_set$gill.attachment <- factor(mushroom_set$gill.attachment, normalize_gill_attach, 
	names(normalize_gill_attach))

# Normalize gill spacing
normalize_gill_spacing <- c(close='c',crowded='w',distant='d')

mushroom_set$gill.spacing <- factor(mushroom_set$gill.spacing, normalize_gill_spacing, 
	names(normalize_gill_spacing))

# Normalize gill size
normalize_gill_size <- c(broad='b',narrow='n')

mushroom_set$gill.size <- factor(mushroom_set$gill.size, normalize_gill_size, 
	names(normalize_gill_size))

# Normalize gill color
normalize_gill_color <- c(black='k',brown='n',buff='b',chocolate='h',gray='g', 
	green='r',orange='o',pink='p',purple='u',red='e',white='w',yellow='y')

mushroom_set$gill.color <- factor(mushroom_set$gill.color, normalize_gill_color, 
	names(normalize_gill_color))

# Normalize stalk shape
normalize_stalk_shape <- c(enlarging='e',tapering='t')
mushroom_set$stalk.shape <- factor(mushroom_set$stalk.shape, normalize_stalk_shape, 
	names(normalize_stalk_shape))

# Normalize stalk root
normalize_stalk_root <- c(bulbous='b',club='c',cup='u',equal='e',rhizomorphs='z',
	rooted='r', unknown='?')

mushroom_set$stalk.root <- factor(mushroom_set$stalk.root, normalize_stalk_root, 
	names(normalize_stalk_root))

# Normalize stalk surface above and below ring
normalize_stalk_surface <- c(fibrous='f',scaly='y',silky='k',smooth='s')

mushroom_set$stalk.surface.above.ring <- factor(mushroom_set$stalk.surface.above.ring, 
	normalize_stalk_surface, names(normalize_stalk_surface))

mushroom_set$stalk.surface.below.ring <- factor(mushroom_set$stalk.surface.below.ring, 
	normalize_stalk_surface, names(normalize_stalk_surface))

# Normalize stalk color below and above ring
normalize_stalk_color <- c(brown='n',buff='b',cinnamon='c',gray='g',orange='o',
	pink='p',red='e',white='w',yellow='y')

mushroom_set$stalk.color.above.ring <- factor(mushroom_set$stalk.color.above.ring, 
	normalize_stalk_color, names(normalize_stalk_color))

mushroom_set$stalk.color.below.ring <- factor(mushroom_set$stalk.color.below.ring, 
	normalize_stalk_color, names(normalize_stalk_color))

# Normalize veil type
normalize_veil_type <- c(partial='p',universal='u')
mushroom_set$veil.type <- factor(mushroom_set$veil.type, normalize_veil_type, 
	names(normalize_veil_type))

# Save CSV file
write.csv(mushroom_set, 'clean_mushrooms.csv', row.names=FALSE)