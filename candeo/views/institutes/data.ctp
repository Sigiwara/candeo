	<?php foreach ($institutes as $institute): ?>
<item>
	<id><?php echo $institute['Institute']['id']; ?></id>
	<name><?php echo $institute['Institute']['name']; ?></name>
	<area><?php echo $institute['Institute']['area']; ?></area>
	<shortcut><?php echo $institute['Institute']['shortcut']; ?></shortcut>
	
	<?php if($institute['Building']){ ?>
	<buildings>
	<?php foreach ($institute['Building'] as $building) { ?>
		<building>
			<id><?php echo $building['id']; ?></id>
			<name><?php echo $building['name']; ?></name>
			<street><?php echo $building['street']; ?></street>
			<number><?php echo $building['number']; ?></number>
			<visitors><?php echo $building['visitors']; ?></visitors>
			<employees><?php echo $building['employees']; ?></employees>
			<size><?php echo $building['size']; ?></size>
			<floors><?php echo $building['floors']; ?></floors>
		</building>
		<?php } ?>
	</buildings>
	<?php } ?>
	
	<?php if($institute['Record']){ ?>
	<records>
	<?php foreach ( $institute['Record'] as $record) { ?>
		<record>
			<id><?php echo $record['id']; ?></id>
			<name><?php echo $record['name']; ?></name>
			<institute><?php echo $record['institute_id']; ?></institute>
			<version><?php echo $record['version']; ?></version>
			<sourcetype><?php echo $record['source_type']; ?></sourcetype>
			<!-- <source><?php echo $record['source']; ?></source> -->
			<?php
			switch($record['source_type']){
				case 'Atomic':
					echo '<source>'.$record['atomic_id'].'</source>';
					break;
				case 'Biological':
					echo '<source>'.$record['biological_id'].'</source>';
					break;
				case 'Chemical':
					echo '<source>'.$record['chemical_id'].'</source>';
					break;
				default:
					break;
			}
			?>
			<amount><?php echo $record['amount']; ?></amount>
			<room><?php echo $record['room']; ?></room>
			<floor><?php echo $record['floor']; ?></floor>
		</record>
		<?php } ?>
	</records>
	<?php } ?>
</item>
	<?php endforeach; ?>
	