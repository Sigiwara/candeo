	<?php foreach ($atomics as $atomic): ?>
	<item>
		<id><?php echo $atomic['Atomic']['id']; ?></id>
		<name><?php echo $atomic['Atomic']['name']; ?></name>
		<ionic><?php echo $atomic['Atomic']['ionic']; ?></ionic>
	</item>
	<?php endforeach; ?>