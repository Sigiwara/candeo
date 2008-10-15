<h2><?php echo $institute['Institute']['name']?></h2>
<div class="actions">
	<ul>
		<li><?php echo $html->link('Edit', array('action'=>'edit', $institute['Institute']['id']), array('class'=>'btn')); ?></li>
	</ul>
</div>
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
</dl>
<div id="page_nav">
	<?php echo $html->link('Back', array('action'=>'index',),  array('class'=>'back')); ?>
</div>