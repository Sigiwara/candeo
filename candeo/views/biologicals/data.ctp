	<?php foreach ($biologicals as $biological): ?>
	<item>
		<id><?php echo $biological['Atomic']['id']; ?></id>
		<name><?php echo $biological['Atomic']['name']; ?></name>
		<openness><?php echo $biological['Atomic']['openness']; ?></openness>
		<activity><?php echo $biological['Atomic']['activity']; ?></activity>
		<group><?php echo $biological['Atomic']['group']; ?></group>
		<security><?php echo $biological['Atomic']['security']; ?></security>
	</item>
	<?php endforeach; ?>