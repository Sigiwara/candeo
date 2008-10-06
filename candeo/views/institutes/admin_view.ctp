<h2><?php echo $institute['Institute']['name']?></h2>
	<?php echo $html->link('Edit', '/institutes/edit/'.$institute['Institute']['id'], array('class'=>'edit')); ?>
<dl>
	<dt>Shortcut</dt><dd><?php echo $institute['Institute']['shortcut']; ?></dd>
	<dt>Area</dt><dd><?php echo $institute['Institute']['area']; ?></dd>
	<dt>URL</dt><dd><?php echo $html->link($institute['Institute']['url'], $institute['Institute']['url'], array()); ?></dd>
	<dt>Buildings</dt>
	<?php
		foreach ( $institute['Building'] as $building) {
			echo '<dd>'.$html->link($building['name'], '/buildings/view/'.$building['id'], array()).'</dd>';
		}
	?>
	<dt>Records</dt>
	<?php
		foreach ( $institute['Record'] as $record) {
			echo '<dd>'.$html->link($record['name'], '/records/view/'.$record['id'], array()).'</dd>';
		}
	?>
</dl>
<div id="page_nav">
	<?php echo $html->link('Back', '/institutes',  array('class'=>'back')); ?>
</div>