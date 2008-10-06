	<?php foreach ($records as $record): ?>
<item>
	<id><?php echo $record['Record']['id']; ?></id>
	<instituteid><?php echo $record['Institute']['id']; ?></instituteid>
	<buildingid><?php echo $record['Building']['id']; ?></buildingid>
	<name><?php echo $record['Record']['name']; ?></name>
	<version><?php echo $record['Record']['version']; ?></version>
	<sourcetype><?php echo $record['Record']['source_type']; ?></sourcetype>
	<atomicname><?php echo $record['Atomic']['name']; ?></atomicname>
	<atomicopen><?php echo $record['Atomic']['open']; ?></atomicopen>
	<chemicalname><?php echo $record['Chemical']['name']; ?></chemicalname>
	<biologicalname><?php echo $record['Biological']['name']; ?></biologicalname>
	<biologicalclass><?php echo $record['Biological']['security']; ?></biologicalclass>
	<amount><?php echo $record['Record']['amount']; ?></amount>
	<room><?php echo $record['Record']['room']; ?></room>
	<floor><?php echo $record['Record']['floor']; ?></floor>
	<notes><?php echo $record['Record']['notes']; ?></notes>
</item>
	<?php endforeach; ?>