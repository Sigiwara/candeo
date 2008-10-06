	<?php foreach ($atomics as $atomic): ?>
	<item>
		<id><?php echo $atomic['Atomic']['id']; ?></id>
		<name><?php echo $atomic['Atomic']['name']; ?></name>
		<open><?php echo $atomic['Atomic']['open']; ?></open>
		<ionic><?php echo $atomic['Atomic']['type']; ?></ionic>
	</item>
	<?php endforeach; ?>